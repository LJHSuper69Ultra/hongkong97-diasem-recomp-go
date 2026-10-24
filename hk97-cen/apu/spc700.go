package apu

// SPC700: the SNES sound CPU. Every opcode is implemented with its cycle
// count; memory accesses go through APU.read/write so that the I/O registers
// at $F0-$FF (DSP port, timers, CPU ports) behave as on hardware.

const (
	pC = 0x01
	pZ = 0x02
	pI = 0x04
	pH = 0x08
	pB = 0x10
	pP = 0x20
	pV = 0x40
	pN = 0x80
)

type spc struct {
	a, x, y, sp uint8
	pc          uint16
	psw         uint8
	halted      bool
}

func (a *APU) rd(addr uint16) uint8    { return a.read(addr) }
func (a *APU) wr(addr uint16, v uint8) { a.write(addr, v) }
func (a *APU) rd16(addr uint16) uint16 { return uint16(a.rd(addr)) | uint16(a.rd(addr+1))<<8 }
func (a *APU) dpAddr(d uint8) uint16   { return uint16(d) | uint16(a.c.psw&pP)<<3 }
func (a *APU) fetch() uint8            { v := a.rd(a.c.pc); a.c.pc++; return v }
func (a *APU) fetch16() uint16         { lo := a.fetch(); return uint16(lo) | uint16(a.fetch())<<8 }
func (a *APU) push(v uint8)            { a.ram[0x100|uint16(a.c.sp)] = v; a.c.sp-- }
func (a *APU) pop() uint8              { a.c.sp++; return a.ram[0x100|uint16(a.c.sp)] }
func (a *APU) push16(v uint16)         { a.push(uint8(v >> 8)); a.push(uint8(v)) }
func (a *APU) pop16() uint16           { lo := a.pop(); return uint16(lo) | uint16(a.pop())<<8 }

// dp 16-bit word read/write (wraps within the page)
func (a *APU) rdw(d uint8) uint16 {
	return uint16(a.rd(a.dpAddr(d))) | uint16(a.rd(a.dpAddr(d+1)))<<8
}
func (a *APU) wrw(d uint8, v uint16) {
	a.wr(a.dpAddr(d), uint8(v))
	a.wr(a.dpAddr(d+1), uint8(v>>8))
}

func (a *APU) nz(v uint8) {
	a.c.psw &^= pN | pZ
	if v == 0 {
		a.c.psw |= pZ
	}
	a.c.psw |= v & pN
}
func (a *APU) nz16(v uint16) {
	a.c.psw &^= pN | pZ
	if v == 0 {
		a.c.psw |= pZ
	}
	if v&0x8000 != 0 {
		a.c.psw |= pN
	}
}
func (a *APU) setC(b bool) {
	if b {
		a.c.psw |= pC
	} else {
		a.c.psw &^= pC
	}
}
func (a *APU) flag(f uint8, b bool) {
	if b {
		a.c.psw |= f
	} else {
		a.c.psw &^= f
	}
}

func (a *APU) adc(x, y uint8) uint8 {
	c := uint16(a.c.psw & pC)
	r := uint16(x) + uint16(y) + c
	a.flag(pV, (^(x^y)&(x^uint8(r)))&0x80 != 0)
	a.flag(pH, (x&0x0F)+(y&0x0F)+uint8(c) > 0x0F)
	a.setC(r > 0xFF)
	a.nz(uint8(r))
	return uint8(r)
}
func (a *APU) sbc(x, y uint8) uint8 { return a.adc(x, ^y) }
func (a *APU) cmp(x, y uint8) {
	r := int(x) - int(y)
	a.setC(r >= 0)
	a.nz(uint8(r))
}

func (a *APU) asl(v uint8) uint8 { a.setC(v&0x80 != 0); v <<= 1; a.nz(v); return v }
func (a *APU) lsr(v uint8) uint8 { a.setC(v&1 != 0); v >>= 1; a.nz(v); return v }
func (a *APU) rol(v uint8) uint8 {
	c := a.c.psw & pC
	a.setC(v&0x80 != 0)
	v = v<<1 | c
	a.nz(v)
	return v
}
func (a *APU) ror(v uint8) uint8 {
	c := a.c.psw & pC
	a.setC(v&1 != 0)
	v = v>>1 | c<<7
	a.nz(v)
	return v
}

// operand address helpers
func (a *APU) aDP() uint16   { return a.dpAddr(a.fetch()) }
func (a *APU) aDPX() uint16  { return a.dpAddr(a.fetch() + a.c.x) }
func (a *APU) aDPY() uint16  { return a.dpAddr(a.fetch() + a.c.y) }
func (a *APU) aABS() uint16  { return a.fetch16() }
func (a *APU) aABSX() uint16 { return a.fetch16() + uint16(a.c.x) }
func (a *APU) aABSY() uint16 { return a.fetch16() + uint16(a.c.y) }
func (a *APU) aIX() uint16   { return a.dpAddr(a.c.x) }
func (a *APU) aIY() uint16   { return a.dpAddr(a.c.y) }
func (a *APU) aIDX() uint16  { return a.rdw(a.fetch() + a.c.x) }         // [d+X]
func (a *APU) aIDY() uint16  { return a.rdw(a.fetch()) + uint16(a.c.y) } // [d]+Y
func (a *APU) aBit() (uint16, uint8) {
	w := a.fetch16()
	return w & 0x1FFF, uint8(w >> 13)
}

func (a *APU) branch(cond bool) int {
	off := int8(a.fetch())
	if cond {
		a.c.pc = uint16(int(a.c.pc) + int(off))
		return 2
	}
	return 0
}

// step executes one instruction and returns its cycle count.
func (a *APU) step() int {
	if a.c.halted {
		return 2
	}
	op := a.fetch()
	cyc := int(cycles[op])
	c := &a.c
	switch op {
	// ---------------------------------------------------------------- ALU
	case 0x04, 0x05, 0x06, 0x07, 0x08, 0x14, 0x15, 0x16, 0x17,
		0x24, 0x25, 0x26, 0x27, 0x28, 0x34, 0x35, 0x36, 0x37,
		0x44, 0x45, 0x46, 0x47, 0x48, 0x54, 0x55, 0x56, 0x57,
		0x64, 0x65, 0x66, 0x67, 0x68, 0x74, 0x75, 0x76, 0x77,
		0x84, 0x85, 0x86, 0x87, 0x88, 0x94, 0x95, 0x96, 0x97,
		0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xB4, 0xB5, 0xB6, 0xB7:
		var v uint8
		switch op & 0x1F {
		case 0x04:
			v = a.rd(a.aDP())
		case 0x05:
			v = a.rd(a.aABS())
		case 0x06:
			v = a.rd(a.aIX())
		case 0x07:
			v = a.rd(a.aIDX())
		case 0x08:
			v = a.fetch()
		case 0x14:
			v = a.rd(a.aDPX())
		case 0x15:
			v = a.rd(a.aABSX())
		case 0x16:
			v = a.rd(a.aABSY())
		case 0x17:
			v = a.rd(a.aIDY())
		}
		a.alu(op>>5, &c.a, v)
	case 0x09, 0x29, 0x49, 0x69, 0x89, 0xA9: // op dd,ds
		s := a.rd(a.aDP())
		d := a.aDP()
		dv := a.rd(d)
		if a.alu(op>>5, &dv, s) {
			a.wr(d, dv)
		}
	case 0x18, 0x38, 0x58, 0x78, 0x98, 0xB8: // op d,#i
		i := a.fetch()
		d := a.aDP()
		dv := a.rd(d)
		if a.alu(op>>5, &dv, i) {
			a.wr(d, dv)
		}
	case 0x19, 0x39, 0x59, 0x79, 0x99, 0xB9: // op (X),(Y)
		s := a.rd(a.aIY())
		d := a.aIX()
		dv := a.rd(d)
		if a.alu(op>>5, &dv, s) {
			a.wr(d, dv)
		}

	// compares with X/Y
	case 0xC8:
		a.cmp(c.x, a.fetch())
	case 0x3E:
		a.cmp(c.x, a.rd(a.aDP()))
	case 0x1E:
		a.cmp(c.x, a.rd(a.aABS()))
	case 0xAD:
		a.cmp(c.y, a.fetch())
	case 0x7E:
		a.cmp(c.y, a.rd(a.aDP()))
	case 0x5E:
		a.cmp(c.y, a.rd(a.aABS()))

	// ------------------------------------------------------------- shifts
	case 0x0B, 0x0C, 0x1B, 0x2B, 0x2C, 0x3B, 0x4B, 0x4C, 0x5B, 0x6B, 0x6C, 0x7B:
		var ad uint16
		switch op & 0x1F {
		case 0x0B:
			ad = a.aDP()
		case 0x0C:
			ad = a.aABS()
		case 0x1B:
			ad = a.aDPX()
		}
		v := a.rd(ad)
		switch op >> 5 {
		case 0:
			v = a.asl(v)
		case 1:
			v = a.rol(v)
		case 2:
			v = a.lsr(v)
		case 3:
			v = a.ror(v)
		}
		a.wr(ad, v)
	case 0x1C:
		c.a = a.asl(c.a)
	case 0x3C:
		c.a = a.rol(c.a)
	case 0x5C:
		c.a = a.lsr(c.a)
	case 0x7C:
		c.a = a.ror(c.a)

	// ------------------------------------------------------------ inc/dec
	case 0x8B, 0x8C, 0x9B, 0xAB, 0xAC, 0xBB:
		var ad uint16
		switch op {
		case 0x8B, 0xAB:
			ad = a.aDP()
		case 0x8C, 0xAC:
			ad = a.aABS()
		default:
			ad = a.aDPX()
		}
		v := a.rd(ad)
		if op >= 0xAB {
			v++
		} else {
			v--
		}
		a.nz(v)
		a.wr(ad, v)
	case 0xBC:
		c.a++
		a.nz(c.a)
	case 0x9C:
		c.a--
		a.nz(c.a)
	case 0x3D:
		c.x++
		a.nz(c.x)
	case 0x1D:
		c.x--
		a.nz(c.x)
	case 0xFC:
		c.y++
		a.nz(c.y)
	case 0xDC:
		c.y--
		a.nz(c.y)

	// --------------------------------------------------------- 16-bit ops
	case 0x3A, 0x1A: // INCW / DECW d
		d := a.fetch()
		v := a.rdw(d)
		if op == 0x3A {
			v++
		} else {
			v--
		}
		a.wrw(d, v)
		a.nz16(v)
	case 0x7A, 0x9A: // ADDW / SUBW YA,d
		v := a.rdw(a.fetch())
		ya := uint16(c.y)<<8 | uint16(c.a)
		var r uint32
		if op == 0x7A {
			r = uint32(ya) + uint32(v)
			a.flag(pH, (ya&0x0FFF)+(v&0x0FFF) > 0x0FFF)
			a.setC(r > 0xFFFF)
			a.flag(pV, (^(ya^v)&(ya^uint16(r)))&0x8000 != 0)
		} else {
			r = uint32(ya) - uint32(v)
			a.flag(pH, (ya&0x0FFF) >= (v&0x0FFF))
			a.setC(int32(ya)-int32(v) >= 0)
			a.flag(pV, ((ya^v)&(ya^uint16(r)))&0x8000 != 0)
		}
		c.a, c.y = uint8(r), uint8(r>>8)
		a.nz16(uint16(r))
	case 0x5A: // CMPW YA,d
		v := a.rdw(a.fetch())
		ya := uint16(c.y)<<8 | uint16(c.a)
		a.setC(ya >= v)
		a.nz16(ya - v)
	case 0xBA: // MOVW YA,d
		v := a.rdw(a.fetch())
		c.a, c.y = uint8(v), uint8(v>>8)
		a.nz16(v)
	case 0xDA: // MOVW d,YA
		a.wrw(a.fetch(), uint16(c.y)<<8|uint16(c.a))
	case 0xCF: // MUL YA
		r := uint16(c.y) * uint16(c.a)
		c.a, c.y = uint8(r), uint8(r>>8)
		a.nz(c.y)
	case 0x9E: // DIV YA,X
		ya := uint32(c.y)<<8 | uint32(c.a)
		x := uint32(c.x)
		a.flag(pH, (c.y&0x0F) >= (c.x&0x0F))
		a.flag(pV, uint32(c.y) >= x)
		if uint32(c.y) < x<<1 {
			if x == 0 {
				c.a, c.y = 0xFF, uint8(ya>>8)
			} else {
				c.a, c.y = uint8(ya/x), uint8(ya%x)
			}
		} else {
			c.a = uint8(255 - (ya-(x<<9))/(256-x))
			c.y = uint8(x + (ya-(x<<9))%(256-x))
		}
		a.nz(c.a)
	case 0xDF: // DAA
		if c.psw&pC != 0 || c.a > 0x99 {
			c.a += 0x60
			c.psw |= pC
		}
		if c.psw&pH != 0 || c.a&0x0F > 9 {
			c.a += 6
		}
		a.nz(c.a)
	case 0xBE: // DAS
		if c.psw&pC == 0 || c.a > 0x99 {
			c.a -= 0x60
			c.psw &^= pC
		}
		if c.psw&pH == 0 || c.a&0x0F > 9 {
			c.a -= 6
		}
		a.nz(c.a)
	case 0x9F: // XCN
		c.a = c.a>>4 | c.a<<4
		a.nz(c.a)

	// -------------------------------------------------------------- moves
	case 0xE8:
		c.a = a.fetch()
		a.nz(c.a)
	case 0xE4:
		c.a = a.rd(a.aDP())
		a.nz(c.a)
	case 0xE5:
		c.a = a.rd(a.aABS())
		a.nz(c.a)
	case 0xE6:
		c.a = a.rd(a.aIX())
		a.nz(c.a)
	case 0xE7:
		c.a = a.rd(a.aIDX())
		a.nz(c.a)
	case 0xF4:
		c.a = a.rd(a.aDPX())
		a.nz(c.a)
	case 0xF5:
		c.a = a.rd(a.aABSX())
		a.nz(c.a)
	case 0xF6:
		c.a = a.rd(a.aABSY())
		a.nz(c.a)
	case 0xF7:
		c.a = a.rd(a.aIDY())
		a.nz(c.a)
	case 0xBF: // MOV A,(X)+
		c.a = a.rd(a.aIX())
		c.x++
		a.nz(c.a)
	case 0xCD:
		c.x = a.fetch()
		a.nz(c.x)
	case 0xF8:
		c.x = a.rd(a.aDP())
		a.nz(c.x)
	case 0xF9:
		c.x = a.rd(a.aDPY())
		a.nz(c.x)
	case 0xE9:
		c.x = a.rd(a.aABS())
		a.nz(c.x)
	case 0x8D:
		c.y = a.fetch()
		a.nz(c.y)
	case 0xEB:
		c.y = a.rd(a.aDP())
		a.nz(c.y)
	case 0xFB:
		c.y = a.rd(a.aDPX())
		a.nz(c.y)
	case 0xEC:
		c.y = a.rd(a.aABS())
		a.nz(c.y)
	case 0xC4:
		a.wr(a.aDP(), c.a)
	case 0xD4:
		a.wr(a.aDPX(), c.a)
	case 0xC5:
		a.wr(a.aABS(), c.a)
	case 0xD5:
		a.wr(a.aABSX(), c.a)
	case 0xD6:
		a.wr(a.aABSY(), c.a)
	case 0xC6:
		a.wr(a.aIX(), c.a)
	case 0xAF: // MOV (X)+,A
		a.wr(a.aIX(), c.a)
		c.x++
	case 0xC7:
		a.wr(a.aIDX(), c.a)
	case 0xD7:
		a.wr(a.aIDY(), c.a)
	case 0xD8:
		a.wr(a.aDP(), c.x)
	case 0xD9:
		a.wr(a.aDPY(), c.x)
	case 0xC9:
		a.wr(a.aABS(), c.x)
	case 0xCB:
		a.wr(a.aDP(), c.y)
	case 0xDB:
		a.wr(a.aDPX(), c.y)
	case 0xCC:
		a.wr(a.aABS(), c.y)
	case 0xFA: // MOV dd,ds
		v := a.rd(a.aDP())
		a.wr(a.aDP(), v)
	case 0x8F: // MOV d,#i
		i := a.fetch()
		a.wr(a.aDP(), i)
	case 0x7D:
		c.a = c.x
		a.nz(c.a)
	case 0xDD:
		c.a = c.y
		a.nz(c.a)
	case 0x5D:
		c.x = c.a
		a.nz(c.x)
	case 0xFD:
		c.y = c.a
		a.nz(c.y)
	case 0x9D:
		c.x = c.sp
		a.nz(c.x)
	case 0xBD:
		c.sp = c.x

	// -------------------------------------------------------------- stack
	case 0x2D:
		a.push(c.a)
	case 0x4D:
		a.push(c.x)
	case 0x6D:
		a.push(c.y)
	case 0x0D:
		a.push(c.psw)
	case 0xAE:
		c.a = a.pop()
	case 0xCE:
		c.x = a.pop()
	case 0xEE:
		c.y = a.pop()
	case 0x8E:
		c.psw = a.pop()

	// --------------------------------------------------------------- bits
	case 0x02, 0x22, 0x42, 0x62, 0x82, 0xA2, 0xC2, 0xE2,
		0x12, 0x32, 0x52, 0x72, 0x92, 0xB2, 0xD2, 0xF2:
		ad := a.aDP()
		bit := uint8(1) << (op >> 5)
		v := a.rd(ad)
		if op&0x10 == 0 {
			v |= bit
		} else {
			v &^= bit
		}
		a.wr(ad, v)
	case 0x03, 0x23, 0x43, 0x63, 0x83, 0xA3, 0xC3, 0xE3,
		0x13, 0x33, 0x53, 0x73, 0x93, 0xB3, 0xD3, 0xF3:
		v := a.rd(a.aDP())
		set := v&(1<<(op>>5)) != 0
		cyc += a.branch(set == (op&0x10 == 0))
	case 0x0E, 0x4E: // TSET1/TCLR1 !a
		ad := a.aABS()
		v := a.rd(ad)
		a.nz(c.a - v)
		if op == 0x0E {
			v |= c.a
		} else {
			v &^= c.a
		}
		a.wr(ad, v)
	case 0x0A, 0x2A, 0x4A, 0x6A, 0x8A, 0xAA: // OR1/AND1/EOR1/MOV1 C,(/)m.b
		ad, b := a.aBit()
		bit := a.rd(ad)>>b&1 != 0
		cf := c.psw&pC != 0
		switch op {
		case 0x0A:
			a.setC(cf || bit)
		case 0x2A:
			a.setC(cf || !bit)
		case 0x4A:
			a.setC(cf && bit)
		case 0x6A:
			a.setC(cf && !bit)
		case 0x8A:
			a.setC(cf != bit)
		case 0xAA:
			a.setC(bit)
		}
	case 0xCA: // MOV1 m.b,C
		ad, b := a.aBit()
		v := a.rd(ad) &^ (1 << b)
		v |= (c.psw & pC) << b
		a.wr(ad, v)
	case 0xEA: // NOT1 m.b
		ad, b := a.aBit()
		a.wr(ad, a.rd(ad)^(1<<b))

	// -------------------------------------------------------------- flags
	case 0x60:
		c.psw &^= pC
	case 0x80:
		c.psw |= pC
	case 0xED:
		c.psw ^= pC
	case 0xE0:
		c.psw &^= pV | pH
	case 0x20:
		c.psw &^= pP
	case 0x40:
		c.psw |= pP
	case 0xA0:
		c.psw |= pI
	case 0xC0:
		c.psw &^= pI

	// ----------------------------------------------------- branches/jumps
	case 0x2F:
		a.branch(true)
	case 0x10:
		cyc += a.branch(c.psw&pN == 0)
	case 0x30:
		cyc += a.branch(c.psw&pN != 0)
	case 0x50:
		cyc += a.branch(c.psw&pV == 0)
	case 0x70:
		cyc += a.branch(c.psw&pV != 0)
	case 0x90:
		cyc += a.branch(c.psw&pC == 0)
	case 0xB0:
		cyc += a.branch(c.psw&pC != 0)
	case 0xD0:
		cyc += a.branch(c.psw&pZ == 0)
	case 0xF0:
		cyc += a.branch(c.psw&pZ != 0)
	case 0x2E: // CBNE d,r
		v := a.rd(a.aDP())
		cyc += a.branch(c.a != v)
	case 0xDE: // CBNE d+X,r
		v := a.rd(a.aDPX())
		cyc += a.branch(c.a != v)
	case 0x6E: // DBNZ d,r
		ad := a.aDP()
		v := a.rd(ad) - 1
		a.wr(ad, v)
		cyc += a.branch(v != 0)
	case 0xFE: // DBNZ Y,r
		c.y--
		cyc += a.branch(c.y != 0)
	case 0x5F:
		c.pc = a.fetch16()
	case 0x1F: // JMP [!a+X]
		c.pc = a.rd16(a.fetch16() + uint16(c.x))
	case 0x3F: // CALL
		t := a.fetch16()
		a.push16(c.pc)
		c.pc = t
	case 0x4F: // PCALL
		t := a.fetch()
		a.push16(c.pc)
		c.pc = 0xFF00 | uint16(t)
	case 0x01, 0x11, 0x21, 0x31, 0x41, 0x51, 0x61, 0x71,
		0x81, 0x91, 0xA1, 0xB1, 0xC1, 0xD1, 0xE1, 0xF1: // TCALL n
		a.push16(c.pc)
		c.pc = a.rd16(0xFFDE - 2*uint16(op>>4))
	case 0x0F: // BRK
		a.push16(c.pc)
		a.push(c.psw)
		c.psw |= pB
		c.psw &^= pI
		c.pc = a.rd16(0xFFDE)
	case 0x6F: // RET
		c.pc = a.pop16()
	case 0x7F: // RETI
		c.psw = a.pop()
		c.pc = a.pop16()
	case 0x00: // NOP
	case 0xEF, 0xFF: // SLEEP, STOP
		c.halted = true
	}
	return cyc
}

// alu applies OR/AND/EOR/CMP/ADC/SBC (selected by op>>5 = 0..5) to *d.
// It reports whether the result must be written back (false for CMP).
func (a *APU) alu(kind uint8, d *uint8, v uint8) bool {
	switch kind {
	case 0:
		*d |= v
		a.nz(*d)
	case 1:
		*d &= v
		a.nz(*d)
	case 2:
		*d ^= v
		a.nz(*d)
	case 3:
		a.cmp(*d, v)
		return false
	case 4:
		*d = a.adc(*d, v)
	case 5:
		*d = a.sbc(*d, v)
	}
	return true
}

// cycles per opcode (taken branches add 2).
var cycles = [256]uint8{
	//0 1  2  3  4  5  6  7  8  9  A  B  C  D  E   F
	2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 5, 4, 5, 4, 6, 8, // 0
	2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 6, 5, 2, 2, 4, 6, // 1
	2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 5, 4, 5, 4, 5, 4, // 2
	2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 6, 5, 2, 2, 3, 8, // 3
	2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 4, 4, 5, 4, 6, 6, // 4
	2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 4, 5, 2, 2, 4, 3, // 5
	2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 4, 4, 5, 4, 5, 5, // 6
	2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 5, 5, 2, 2, 3, 6, // 7
	2, 8, 4, 5, 3, 4, 3, 6, 2, 6, 5, 4, 5, 2, 4, 5, // 8
	2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 5, 5, 2, 2, 12, 5, // 9
	3, 8, 4, 5, 3, 4, 3, 6, 2, 6, 4, 4, 5, 2, 4, 4, // A
	2, 8, 4, 5, 4, 5, 5, 6, 5, 5, 5, 5, 2, 2, 3, 4, // B
	3, 8, 4, 5, 4, 5, 4, 7, 2, 5, 6, 4, 5, 2, 4, 9, // C
	2, 8, 4, 5, 5, 6, 6, 7, 4, 5, 5, 5, 2, 2, 6, 3, // D
	2, 8, 4, 5, 3, 4, 3, 6, 2, 4, 5, 3, 4, 3, 4, 3, // E
	2, 8, 4, 5, 4, 5, 5, 6, 3, 4, 5, 4, 2, 2, 4, 3, // F
}
