// Package oracle is a development-only reference: a minimal 65816 + SNES
// hardware model used to run the original ROM headless and capture frames,
// so the high-level port can be compared against the real game.
package oracle

import "fmt"

type Bus interface {
	Read(addr uint32) uint8
	Write(addr uint32, v uint8)
}

const (
	fC = 0x01
	fZ = 0x02
	fI = 0x04
	fD = 0x08
	fX = 0x10
	fM = 0x20
	fV = 0x40
	fN = 0x80
)

type CPU struct {
	A, X, Y, S, D uint16
	DB, PB        uint8
	PC            uint16
	P             uint8
	E             bool
	bus           Bus
	// OnRead, if set, sees every CPU read; fetch is true for opcode/operand bytes.
	OnRead     func(addr uint32, fetch bool)
	InstrPC    uint32
	fetching   bool
	Cycles     uint64
	Waiting    bool
	Stopped    bool
	nmiPending bool
	irqLine    bool
}

func NewCPU(b Bus) *CPU {
	c := &CPU{bus: b}
	c.Reset()
	return c
}

func (c *CPU) Reset() {
	c.E = true
	c.P = fM | fX | fI
	c.S = 0x01FF
	c.D = 0
	c.DB, c.PB = 0, 0
	c.PC = c.rd16(0x00FFFC)
}

func (c *CPU) m8() bool { return c.P&fM != 0 }
func (c *CPU) x8() bool { return c.P&fX != 0 }

func (c *CPU) rd(a uint32) uint8 {
	c.Cycles++
	if c.OnRead != nil {
		c.OnRead(a&0xFFFFFF, c.fetching)
	}
	return c.bus.Read(a & 0xFFFFFF)
}
func (c *CPU) wr(a uint32, v uint8)    { c.Cycles++; c.bus.Write(a&0xFFFFFF, v) }
func (c *CPU) rd16(a uint32) uint16    { return uint16(c.rd(a)) | uint16(c.rd(a+1))<<8 }
func (c *CPU) wr16(a uint32, v uint16) { c.wr(a, uint8(v)); c.wr(a+1, uint8(v>>8)) }

func (c *CPU) fetch() uint8 {
	c.fetching = true
	v := c.rd(uint32(c.PB)<<16 | uint32(c.PC))
	c.fetching = false
	c.PC++
	return v
}
func (c *CPU) fetch16() uint16 { lo := c.fetch(); return uint16(lo) | uint16(c.fetch())<<8 }
func (c *CPU) fetch24() uint32 { lo := c.fetch16(); return uint32(lo) | uint32(c.fetch())<<16 }

func (c *CPU) push(v uint8) {
	c.wr(uint32(c.S), v)
	c.S--
	if c.E {
		c.S = 0x0100 | (c.S & 0xFF)
	}
}
func (c *CPU) pull() uint8 {
	c.S++
	if c.E {
		c.S = 0x0100 | (c.S & 0xFF)
	}
	return c.rd(uint32(c.S))
}
func (c *CPU) push16(v uint16) { c.push(uint8(v >> 8)); c.push(uint8(v)) }
func (c *CPU) pull16() uint16  { lo := c.pull(); return uint16(lo) | uint16(c.pull())<<8 }

func (c *CPU) setP(v uint8) {
	c.P = v
	if c.E {
		c.P |= fM | fX
	}
	if c.P&fX != 0 {
		c.X &= 0xFF
		c.Y &= 0xFF
	}
}

func (c *CPU) nz8(v uint8) {
	c.P &^= fN | fZ
	if v == 0 {
		c.P |= fZ
	}
	c.P |= v & 0x80
}
func (c *CPU) nz16(v uint16) {
	c.P &^= fN | fZ
	if v == 0 {
		c.P |= fZ
	}
	if v&0x8000 != 0 {
		c.P |= fN
	}
}

// ---- addressing: return effective 24-bit address ----
func (c *CPU) dp(off uint16) uint32 { return uint32(c.D + off) }
func (c *CPU) aDP() uint32          { return c.dp(uint16(c.fetch())) }
func (c *CPU) aDPX() uint32         { return c.dp(uint16(c.fetch()) + c.X) }
func (c *CPU) aDPY() uint32         { return c.dp(uint16(c.fetch()) + c.Y) }
func (c *CPU) aABS() uint32         { return uint32(c.DB)<<16 | uint32(c.fetch16()) }
func (c *CPU) aABSX() uint32 {
	return (uint32(c.DB)<<16 + uint32(c.fetch16()) + uint32(c.X)) & 0xFFFFFF
}
func (c *CPU) aABSY() uint32 {
	return (uint32(c.DB)<<16 + uint32(c.fetch16()) + uint32(c.Y)) & 0xFFFFFF
}
func (c *CPU) aABSL() uint32  { return c.fetch24() }
func (c *CPU) aABSLX() uint32 { return (c.fetch24() + uint32(c.X)) & 0xFFFFFF }
func (c *CPU) aIDP() uint32 {
	p := c.aDP()
	return uint32(c.DB)<<16 | uint32(c.rd16(p&0xFFFF))
}
func (c *CPU) aIDX() uint32 {
	p := c.dp(uint16(c.fetch()) + c.X)
	return uint32(c.DB)<<16 | uint32(c.rd16(p&0xFFFF))
}
func (c *CPU) aIDY() uint32 {
	p := c.aDP()
	base := uint32(c.DB)<<16 | uint32(c.rd16(p&0xFFFF))
	return (base + uint32(c.Y)) & 0xFFFFFF
}
func (c *CPU) aIDL() uint32 {
	p := c.aDP() & 0xFFFF
	return uint32(c.rd16(p)) | uint32(c.rd(p+2))<<16
}
func (c *CPU) aIDLY() uint32 {
	p := c.aDP() & 0xFFFF
	base := uint32(c.rd16(p)) | uint32(c.rd(p+2))<<16
	return (base + uint32(c.Y)) & 0xFFFFFF
}
func (c *CPU) aSR() uint32 { return uint32(c.S + uint16(c.fetch())) }
func (c *CPU) aSRY() uint32 {
	p := uint32(c.S + uint16(c.fetch()))
	base := uint32(c.DB)<<16 | uint32(c.rd16(p))
	return (base + uint32(c.Y)) & 0xFFFFFF
}

// read operand of width M or X
func (c *CPU) ldM(a uint32) uint16 {
	if c.m8() {
		return uint16(c.rd(a))
	}
	return c.rd16(a)
}
func (c *CPU) ldX(a uint32) uint16 {
	if c.x8() {
		return uint16(c.rd(a))
	}
	return c.rd16(a)
}
func (c *CPU) stM(a uint32, v uint16) {
	if c.m8() {
		c.wr(a, uint8(v))
	} else {
		c.wr16(a, v)
	}
}
func (c *CPU) stX(a uint32, v uint16) {
	if c.x8() {
		c.wr(a, uint8(v))
	} else {
		c.wr16(a, v)
	}
}
func (c *CPU) immM() uint16 {
	if c.m8() {
		return uint16(c.fetch())
	}
	return c.fetch16()
}
func (c *CPU) immX() uint16 {
	if c.x8() {
		return uint16(c.fetch())
	}
	return c.fetch16()
}

func (c *CPU) setA(v uint16) {
	if c.m8() {
		c.A = c.A&0xFF00 | v&0xFF
		c.nz8(uint8(v))
	} else {
		c.A = v
		c.nz16(v)
	}
}
func (c *CPU) setXr(v uint16) {
	if c.x8() {
		c.X = v & 0xFF
		c.nz8(uint8(v))
	} else {
		c.X = v
		c.nz16(v)
	}
}
func (c *CPU) setYr(v uint16) {
	if c.x8() {
		c.Y = v & 0xFF
		c.nz8(uint8(v))
	} else {
		c.Y = v
		c.nz16(v)
	}
}
func (c *CPU) nzM(v uint16) {
	if c.m8() {
		c.nz8(uint8(v))
	} else {
		c.nz16(v)
	}
}
func (c *CPU) nzX(v uint16) {
	if c.x8() {
		c.nz8(uint8(v))
	} else {
		c.nz16(v)
	}
}

func (c *CPU) adc(v uint16) {
	cin := uint32(c.P & fC)
	if c.m8() {
		a := uint32(c.A & 0xFF)
		var r uint32
		if c.P&fD != 0 {
			lo := (a & 0xF) + (uint32(v) & 0xF) + cin
			if lo > 9 {
				lo += 6
			}
			hi := (a >> 4) + (uint32(v)>>4)&0xF
			if lo > 0xF {
				hi++
			}
			r8 := (hi << 4) | (lo & 0xF)
			c.P &^= fV
			if (^(a^uint32(v))&(a^r8))&0x80 != 0 {
				c.P |= fV
			}
			if hi > 9 {
				hi += 6
			}
			r = (hi << 4) | (lo & 0xF)
		} else {
			r = a + uint32(v&0xFF) + cin
			c.P &^= fV
			if (^(a^uint32(v))&(a^r))&0x80 != 0 {
				c.P |= fV
			}
		}
		c.P &^= fC
		if r > 0xFF {
			c.P |= fC
		}
		c.setA(uint16(r))
	} else {
		a := uint32(c.A)
		var r uint32
		if c.P&fD != 0 {
			r = cin
			res := uint32(0)
			for i := uint(0); i < 16; i += 4 {
				d := (a>>i)&0xF + (uint32(v)>>i)&0xF + r
				r = 0
				if d > 9 {
					d += 6
					r = 1
				}
				res |= (d & 0xF) << i
			}
			c.P &^= fV
			if (^(a^uint32(v))&(a^res))&0x8000 != 0 {
				c.P |= fV
			}
			if r != 0 {
				res |= 0x10000
			}
			r = res
		} else {
			r = a + uint32(v) + cin
			c.P &^= fV
			if (^(a^uint32(v))&(a^r))&0x8000 != 0 {
				c.P |= fV
			}
		}
		c.P &^= fC
		if r > 0xFFFF {
			c.P |= fC
		}
		c.setA(uint16(r))
	}
}

func (c *CPU) sbc(v uint16) {
	if c.P&fD == 0 {
		if c.m8() {
			c.adc(^v & 0xFF)
		} else {
			c.adc(^v)
		}
		return
	}
	// decimal subtract
	borrow := 1 - int(c.P&fC)
	if c.m8() {
		a := int(c.A & 0xFF)
		lo := (a & 0xF) - int(v&0xF) - borrow
		hi := (a >> 4) - int((v>>4)&0xF)
		if lo < 0 {
			lo += 10
			hi--
		}
		c.P &^= fC
		if hi >= 0 {
			c.P |= fC
		} else {
			hi += 10
		}
		bin := a - int(v&0xFF) - borrow
		c.P &^= fV
		if ((a^int(v))&(a^bin))&0x80 != 0 {
			c.P |= fV
		}
		c.setA(uint16((hi<<4 | lo&0xF) & 0xFF))
	} else {
		a := int(c.A)
		res := 0
		for i := uint(0); i < 16; i += 4 {
			d := (a>>i)&0xF - int(v>>i)&0xF - borrow
			borrow = 0
			if d < 0 {
				d += 10
				borrow = 1
			}
			res |= (d & 0xF) << i
		}
		c.P &^= fC
		if borrow == 0 {
			c.P |= fC
		}
		bin := a - int(v) - (1 - int(c.P&fC))
		c.P &^= fV
		if ((a^int(v))&(a^bin))&0x8000 != 0 {
			c.P |= fV
		}
		c.setA(uint16(res))
	}
}

func (c *CPU) cmp(r, v uint16, eight bool) {
	if eight {
		r &= 0xFF
		v &= 0xFF
	}
	t := uint32(r) - uint32(v)
	c.P &^= fC
	if r >= v {
		c.P |= fC
	}
	if eight {
		c.nz8(uint8(t))
	} else {
		c.nz16(uint16(t))
	}
}

// read-modify-write helpers
func (c *CPU) rmw(a uint32, f func(uint16) uint16) {
	v := c.ldM(a)
	r := f(v)
	c.stM(a, r)
	c.nzM(r)
}

func (c *CPU) asl(v uint16) uint16 {
	c.P &^= fC
	if c.m8() {
		if v&0x80 != 0 {
			c.P |= fC
		}
		return (v << 1) & 0xFF
	}
	if v&0x8000 != 0 {
		c.P |= fC
	}
	return v << 1
}
func (c *CPU) lsr(v uint16) uint16 {
	c.P &^= fC
	c.P |= uint8(v & 1)
	return v >> 1
}
func (c *CPU) rol(v uint16) uint16 {
	cin := uint16(c.P & fC)
	c.P &^= fC
	if c.m8() {
		if v&0x80 != 0 {
			c.P |= fC
		}
		return (v<<1 | cin) & 0xFF
	}
	if v&0x8000 != 0 {
		c.P |= fC
	}
	return v<<1 | cin
}
func (c *CPU) ror(v uint16) uint16 {
	cin := uint16(c.P & fC)
	c.P &^= fC
	c.P |= uint8(v & 1)
	if c.m8() {
		return (v >> 1) | cin<<7
	}
	return (v >> 1) | cin<<15
}

func (c *CPU) branch(cond bool) {
	off := int8(c.fetch())
	if cond {
		c.PC = uint16(int32(c.PC) + int32(off))
	}
}

func (c *CPU) interrupt(vecNative, vecEmu uint16) {
	if !c.E {
		c.push(c.PB)
	}
	c.push16(c.PC)
	p := c.P
	if c.E {
		p &^= 0x10 // B clear for hw interrupt
	}
	c.push(p)
	c.P |= fI
	c.P &^= fD
	c.PB = 0
	if c.E {
		c.PC = c.rd16(uint32(vecEmu))
	} else {
		c.PC = c.rd16(uint32(vecNative))
	}
}

func (c *CPU) NMI() { c.nmiPending = true }

// Step executes one instruction. Returns false on STP.
func (c *CPU) Step() {
	if c.nmiPending {
		c.nmiPending = false
		c.Waiting = false
		c.interrupt(0xFFEA, 0xFFFA)
		return
	}
	if c.Waiting || c.Stopped {
		c.Cycles += 4
		return
	}
	c.InstrPC = uint32(c.PB)<<16 | uint32(c.PC)
	op := c.fetch()
	switch op {
	// ---- loads/stores ----
	case 0xA9:
		c.setA(c.immM())
	case 0xA5:
		c.setA(c.ldM(c.aDP()))
	case 0xB5:
		c.setA(c.ldM(c.aDPX()))
	case 0xAD:
		c.setA(c.ldM(c.aABS()))
	case 0xBD:
		c.setA(c.ldM(c.aABSX()))
	case 0xB9:
		c.setA(c.ldM(c.aABSY()))
	case 0xAF:
		c.setA(c.ldM(c.aABSL()))
	case 0xBF:
		c.setA(c.ldM(c.aABSLX()))
	case 0xB2:
		c.setA(c.ldM(c.aIDP()))
	case 0xA1:
		c.setA(c.ldM(c.aIDX()))
	case 0xB1:
		c.setA(c.ldM(c.aIDY()))
	case 0xA7:
		c.setA(c.ldM(c.aIDL()))
	case 0xB7:
		c.setA(c.ldM(c.aIDLY()))
	case 0xA3:
		c.setA(c.ldM(c.aSR()))
	case 0xB3:
		c.setA(c.ldM(c.aSRY()))
	case 0xA2:
		c.setXr(c.immX())
	case 0xA6:
		c.setXr(c.ldX(c.aDP()))
	case 0xB6:
		c.setXr(c.ldX(c.aDPY()))
	case 0xAE:
		c.setXr(c.ldX(c.aABS()))
	case 0xBE:
		c.setXr(c.ldX(c.aABSY()))
	case 0xA0:
		c.setYr(c.immX())
	case 0xA4:
		c.setYr(c.ldX(c.aDP()))
	case 0xB4:
		c.setYr(c.ldX(c.aDPX()))
	case 0xAC:
		c.setYr(c.ldX(c.aABS()))
	case 0xBC:
		c.setYr(c.ldX(c.aABSX()))
	case 0x85:
		c.stM(c.aDP(), c.A)
	case 0x95:
		c.stM(c.aDPX(), c.A)
	case 0x8D:
		c.stM(c.aABS(), c.A)
	case 0x9D:
		c.stM(c.aABSX(), c.A)
	case 0x99:
		c.stM(c.aABSY(), c.A)
	case 0x8F:
		c.stM(c.aABSL(), c.A)
	case 0x9F:
		c.stM(c.aABSLX(), c.A)
	case 0x92:
		c.stM(c.aIDP(), c.A)
	case 0x81:
		c.stM(c.aIDX(), c.A)
	case 0x91:
		c.stM(c.aIDY(), c.A)
	case 0x87:
		c.stM(c.aIDL(), c.A)
	case 0x97:
		c.stM(c.aIDLY(), c.A)
	case 0x83:
		c.stM(c.aSR(), c.A)
	case 0x93:
		c.stM(c.aSRY(), c.A)
	case 0x86:
		c.stX(c.aDP(), c.X)
	case 0x96:
		c.stX(c.aDPY(), c.X)
	case 0x8E:
		c.stX(c.aABS(), c.X)
	case 0x84:
		c.stX(c.aDP(), c.Y)
	case 0x94:
		c.stX(c.aDPX(), c.Y)
	case 0x8C:
		c.stX(c.aABS(), c.Y)
	case 0x64:
		c.stM(c.aDP(), 0)
	case 0x74:
		c.stM(c.aDPX(), 0)
	case 0x9C:
		c.stM(c.aABS(), 0)
	case 0x9E:
		c.stM(c.aABSX(), 0)

	// ---- ALU ----
	case 0x09, 0x05, 0x15, 0x0D, 0x1D, 0x19, 0x0F, 0x1F, 0x12, 0x01, 0x11, 0x07, 0x17, 0x03, 0x13:
		c.setA(c.A | c.aluOperand(op))
	case 0x29, 0x25, 0x35, 0x2D, 0x3D, 0x39, 0x2F, 0x3F, 0x32, 0x21, 0x31, 0x27, 0x37, 0x23, 0x33:
		v := c.aluOperand(op)
		if c.m8() {
			c.setA(c.A & (v | 0xFF00))
		} else {
			c.setA(c.A & v)
		}
	case 0x49, 0x45, 0x55, 0x4D, 0x5D, 0x59, 0x4F, 0x5F, 0x52, 0x41, 0x51, 0x47, 0x57, 0x43, 0x53:
		c.setA(c.A ^ c.aluOperand(op))
	case 0x69, 0x65, 0x75, 0x6D, 0x7D, 0x79, 0x6F, 0x7F, 0x72, 0x61, 0x71, 0x67, 0x77, 0x63, 0x73:
		c.adc(c.aluOperand(op))
	case 0xE9, 0xE5, 0xF5, 0xED, 0xFD, 0xF9, 0xEF, 0xFF, 0xF2, 0xE1, 0xF1, 0xE7, 0xF7, 0xE3, 0xF3:
		c.sbc(c.aluOperand(op))
	case 0xC9, 0xC5, 0xD5, 0xCD, 0xDD, 0xD9, 0xCF, 0xDF, 0xD2, 0xC1, 0xD1, 0xC7, 0xD7, 0xC3, 0xD3:
		c.cmp(c.A, c.aluOperand(op), c.m8())
	case 0xE0:
		c.cmp(c.X, c.immX(), c.x8())
	case 0xE4:
		c.cmp(c.X, c.ldX(c.aDP()), c.x8())
	case 0xEC:
		c.cmp(c.X, c.ldX(c.aABS()), c.x8())
	case 0xC0:
		c.cmp(c.Y, c.immX(), c.x8())
	case 0xC4:
		c.cmp(c.Y, c.ldX(c.aDP()), c.x8())
	case 0xCC:
		c.cmp(c.Y, c.ldX(c.aABS()), c.x8())
	case 0x89: // BIT imm: only Z
		v := c.immM()
		r := c.A & v
		if c.m8() {
			r &= 0xFF
		}
		c.P &^= fZ
		if r == 0 {
			c.P |= fZ
		}
	case 0x24, 0x34, 0x2C, 0x3C:
		var a uint32
		switch op {
		case 0x24:
			a = c.aDP()
		case 0x34:
			a = c.aDPX()
		case 0x2C:
			a = c.aABS()
		default:
			a = c.aABSX()
		}
		v := c.ldM(a)
		c.P &^= fZ | fN | fV
		if c.m8() {
			if uint8(c.A)&uint8(v) == 0 {
				c.P |= fZ
			}
			c.P |= uint8(v) & 0xC0
		} else {
			if c.A&v == 0 {
				c.P |= fZ
			}
			c.P |= uint8(v>>8) & 0xC0
		}
	case 0x04, 0x0C, 0x14, 0x1C: // TSB/TRB
		var a uint32
		if op == 0x04 || op == 0x14 {
			a = c.aDP()
		} else {
			a = c.aABS()
		}
		v := c.ldM(a)
		acc := c.A
		if c.m8() {
			acc &= 0xFF
		}
		c.P &^= fZ
		if v&acc == 0 {
			c.P |= fZ
		}
		if op == 0x04 || op == 0x0C {
			c.stM(a, v|acc)
		} else {
			c.stM(a, v&^acc)
		}

	// ---- shifts / inc / dec ----
	case 0x0A:
		c.setA(c.asl(c.accM()))
	case 0x4A:
		c.setA(c.lsr(c.accM()))
	case 0x2A:
		c.setA(c.rol(c.accM()))
	case 0x6A:
		c.setA(c.ror(c.accM()))
	case 0x1A:
		c.setA(c.accM() + 1)
	case 0x3A:
		c.setA(c.accM() - 1)
	case 0x06, 0x16, 0x0E, 0x1E:
		c.rmw(c.rmwAddr(op), c.asl)
	case 0x46, 0x56, 0x4E, 0x5E:
		c.rmw(c.rmwAddr(op), c.lsr)
	case 0x26, 0x36, 0x2E, 0x3E:
		c.rmw(c.rmwAddr(op), c.rol)
	case 0x66, 0x76, 0x6E, 0x7E:
		c.rmw(c.rmwAddr(op), c.ror)
	case 0xE6, 0xF6, 0xEE, 0xFE:
		c.rmw(c.rmwAddr(op), func(v uint16) uint16 { return c.maskM(v + 1) })
	case 0xC6, 0xD6, 0xCE, 0xDE:
		c.rmw(c.rmwAddr(op), func(v uint16) uint16 { return c.maskM(v - 1) })
	case 0xE8:
		c.setXr(c.X + 1)
	case 0xC8:
		c.setYr(c.Y + 1)
	case 0xCA:
		c.setXr(c.X - 1)
	case 0x88:
		c.setYr(c.Y - 1)

	// ---- transfers ----
	case 0xAA:
		c.setXr(c.A)
	case 0xA8:
		c.setYr(c.A)
	case 0x8A:
		c.setA(c.X)
	case 0x98:
		c.setA(c.Y)
	case 0x9B:
		c.setYr(c.X)
	case 0xBB:
		c.setXr(c.Y)
	case 0xBA:
		c.setXr(c.S)
	case 0x9A:
		c.S = c.X
		if c.E {
			c.S = 0x100 | c.S&0xFF
		}
	case 0x5B:
		c.D = c.A
		c.nz16(c.D)
	case 0x7B:
		c.A = c.D
		c.nz16(c.A)
	case 0x1B:
		c.S = c.A
		if c.E {
			c.S = 0x100 | c.S&0xFF
		}
	case 0x3B:
		c.A = c.S
		c.nz16(c.A)
	case 0xEB:
		c.A = c.A>>8 | c.A<<8
		c.nz8(uint8(c.A))

	// ---- stack ----
	case 0x48:
		if c.m8() {
			c.push(uint8(c.A))
		} else {
			c.push16(c.A)
		}
	case 0x68:
		if c.m8() {
			c.setA(uint16(c.pull()))
		} else {
			c.setA(c.pull16())
		}
	case 0xDA:
		if c.x8() {
			c.push(uint8(c.X))
		} else {
			c.push16(c.X)
		}
	case 0xFA:
		if c.x8() {
			c.setXr(uint16(c.pull()))
		} else {
			c.setXr(c.pull16())
		}
	case 0x5A:
		if c.x8() {
			c.push(uint8(c.Y))
		} else {
			c.push16(c.Y)
		}
	case 0x7A:
		if c.x8() {
			c.setYr(uint16(c.pull()))
		} else {
			c.setYr(c.pull16())
		}
	case 0x08:
		c.push(c.P)
	case 0x28:
		c.setP(c.pull())
	case 0x8B:
		c.push(c.DB)
	case 0xAB:
		c.DB = c.pull()
		c.nz8(c.DB)
	case 0x4B:
		c.push(c.PB)
	case 0x0B:
		c.push16(c.D)
	case 0x2B:
		c.D = c.pull16()
		c.nz16(c.D)
	case 0xF4:
		c.push16(c.fetch16())
	case 0xD4:
		p := c.aDP()
		c.push16(c.rd16(p))
	case 0x62:
		off := int16(c.fetch16())
		c.push16(uint16(int32(c.PC) + int32(off)))

	// ---- flags ----
	case 0x18:
		c.P &^= fC
	case 0x38:
		c.P |= fC
	case 0x58:
		c.P &^= fI
	case 0x78:
		c.P |= fI
	case 0xD8:
		c.P &^= fD
	case 0xF8:
		c.P |= fD
	case 0xB8:
		c.P &^= fV
	case 0xC2:
		c.setP(c.P &^ c.fetch())
	case 0xE2:
		c.setP(c.P | c.fetch())
	case 0xFB:
		cf := c.P&fC != 0
		c.P &^= fC
		if c.E {
			c.P |= fC
		}
		c.E = cf
		if c.E {
			c.setP(c.P)
			c.S = 0x100 | c.S&0xFF
		}

	// ---- branches / jumps ----
	case 0x10:
		c.branch(c.P&fN == 0)
	case 0x30:
		c.branch(c.P&fN != 0)
	case 0x50:
		c.branch(c.P&fV == 0)
	case 0x70:
		c.branch(c.P&fV != 0)
	case 0x90:
		c.branch(c.P&fC == 0)
	case 0xB0:
		c.branch(c.P&fC != 0)
	case 0xD0:
		c.branch(c.P&fZ == 0)
	case 0xF0:
		c.branch(c.P&fZ != 0)
	case 0x80:
		c.branch(true)
	case 0x82:
		off := int16(c.fetch16())
		c.PC = uint16(int32(c.PC) + int32(off))
	case 0x4C:
		c.PC = c.fetch16()
	case 0x5C:
		a := c.fetch24()
		c.PB = uint8(a >> 16)
		c.PC = uint16(a)
	case 0x6C:
		p := c.fetch16()
		c.PC = c.rd16(uint32(p))
	case 0x7C:
		p := c.fetch16() + c.X
		c.PC = c.rd16(uint32(c.PB)<<16 | uint32(p))
	case 0xDC:
		p := uint32(c.fetch16())
		c.PC = c.rd16(p)
		c.PB = c.rd(p + 2)
	case 0x20:
		t := c.fetch16()
		c.push16(c.PC - 1)
		c.PC = t
	case 0xFC:
		p := c.fetch16() + c.X
		c.push16(c.PC - 1)
		c.PC = c.rd16(uint32(c.PB)<<16 | uint32(p))
	case 0x22:
		t := c.fetch24()
		c.push(c.PB)
		c.push16(c.PC - 1)
		c.PB = uint8(t >> 16)
		c.PC = uint16(t)
	case 0x60:
		c.PC = c.pull16() + 1
	case 0x6B:
		c.PC = c.pull16() + 1
		c.PB = c.pull()
	case 0x40:
		c.setP(c.pull())
		c.PC = c.pull16()
		if !c.E {
			c.PB = c.pull()
		}

	// ---- block move ----
	case 0x54, 0x44:
		dst := c.fetch()
		src := c.fetch()
		c.DB = dst
		v := c.rd(uint32(src)<<16 | uint32(c.X))
		c.wr(uint32(dst)<<16|uint32(c.Y), v)
		if op == 0x54 {
			c.X++
			c.Y++
		} else {
			c.X--
			c.Y--
		}
		if c.x8() {
			c.X &= 0xFF
			c.Y &= 0xFF
		}
		c.A--
		if c.A != 0xFFFF {
			c.PC -= 3
		}

	// ---- misc ----
	case 0xEA:
	case 0x42:
		c.fetch()
	case 0xCB:
		c.Waiting = true
	case 0xDB:
		c.Stopped = true
	case 0x00:
		c.fetch()
		c.interrupt(0xFFE6, 0xFFFE)
	case 0x02:
		c.fetch()
		c.interrupt(0xFFE4, 0xFFF4)
	default:
		panic(fmt.Sprintf("unimplemented opcode %02X at %02X:%04X", op, c.PB, c.PC-1))
	}
}

func (c *CPU) maskM(v uint16) uint16 {
	if c.m8() {
		return v & 0xFF
	}
	return v
}
func (c *CPU) accM() uint16 {
	if c.m8() {
		return c.A & 0xFF
	}
	return c.A
}

func (c *CPU) rmwAddr(op uint8) uint32 {
	switch op & 0x1F {
	case 0x06:
		return c.aDP()
	case 0x16:
		return c.aDPX()
	case 0x0E:
		return c.aABS()
	default:
		return c.aABSX()
	}
}

// aluOperand decodes the standard ORA/AND/EOR/ADC/SBC/CMP group by low bits.
func (c *CPU) aluOperand(op uint8) uint16 {
	switch op & 0x1F {
	case 0x09:
		return c.immM()
	case 0x05:
		return c.ldM(c.aDP())
	case 0x15:
		return c.ldM(c.aDPX())
	case 0x0D:
		return c.ldM(c.aABS())
	case 0x1D:
		return c.ldM(c.aABSX())
	case 0x19:
		return c.ldM(c.aABSY())
	case 0x0F:
		return c.ldM(c.aABSL())
	case 0x1F:
		return c.ldM(c.aABSLX())
	case 0x12:
		return c.ldM(c.aIDP())
	case 0x01:
		return c.ldM(c.aIDX())
	case 0x11:
		return c.ldM(c.aIDY())
	case 0x07:
		return c.ldM(c.aIDL())
	case 0x17:
		return c.ldM(c.aIDLY())
	case 0x03:
		return c.ldM(c.aSR())
	case 0x13:
		return c.ldM(c.aSRY())
	}
	panic("alu")
}
