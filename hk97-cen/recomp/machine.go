// Package recomp holds Hong Kong 97's game code statically recompiled from
// the ROM's 65816 machine code into Go (gen.go, generated), plus the small
// runtime it needs: registers, effective-address and ALU helpers, and the
// frame/NMI hand-off with the host. There is no instruction interpreter:
// every original instruction became Go code at build time. ROM data
// (graphics, text, tables) is read from the user's ROM file at run time.
package recomp

import (
	"fmt"

	"hk97/hw"
)

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

type Machine struct {
	*hw.HW
	A, X, Y, S, D uint16
	DB, PB        uint8
	P             uint8
	E             bool

	// Frame hand-off: Frame is called each time the game waits for vblank.
	Frame func()
	// Hooks for verification harnesses (optional).
	OnBoundary func() // at entry of the vblank wait ($83C3)
	nmiBytes   int
	relv       []uint32 // resolved asset addresses for relocated operands
	lineBase   uint16
	inNMI      bool

	syms map[string]uint32 // asset addresses (nil: original ROM layout)
}

type reloc struct {
	Name string
	Off  int
	Orig uint32 // the asset's address in the original ROM
}

// New creates a machine over a data image (the packed assets, or an
// original ROM). syms gives the final address of each asset as chosen by
// tools/pack; nil means the original ROM layout. Code tables that belong
// to the recompiled program are applied on top of the image.
func New(data []byte, syms map[string]uint32) *Machine {
	img := make([]byte, len(data))
	copy(img, data)
	for _, c := range codeData {
		o := int(c.Addr>>16&0x7F)*0x8000 + int(c.Addr&0x7FFF)
		copy(img[o:], c.Data)
	}
	m := &Machine{HW: hw.New(img), syms: syms}
	m.relv = make([]uint32, len(relocs))
	for i, r := range relocs {
		base := r.Orig
		if syms != nil {
			a, ok := syms[r.Name]
			if !ok {
				panic("recomp: no address for asset " + r.Name)
			}
			base = a
		}
		m.relv[i] = uint32(int64(base) + int64(r.Off))
	}
	m.HW.Scanline = m.scanline
	m.HW.DMACost = func(n int) { m.nmiBytes += n }
	m.E = true
	m.P = fM | fX | fI
	m.S = 0x01FF
	return m
}

// V counter model used only by the NMI handler's timing checks: it advances
// one line per read pair and by DMA volume, matching the reference model.
func (m *Machine) scanline() uint16 {
	if !m.inNMI {
		return 0
	}
	m.lineBase++
	return 225 + m.lineBase + uint16(m.nmiBytes/1024)
}

// Run starts the game at the reset vector and never returns.
func (m *Machine) Run() { m.run(0x008000) }

func (m *Machine) m8() bool { return m.P&fM != 0 }
func (m *Machine) x8() bool { return m.P&fX != 0 }

func (m *Machine) rd(a uint32) uint8       { return m.HW.Read(a & 0xFFFFFF) }
func (m *Machine) wr(a uint32, v uint8)    { m.HW.Write(a&0xFFFFFF, v) }
func (m *Machine) rd16(a uint32) uint16    { return uint16(m.rd(a)) | uint16(m.rd(a+1))<<8 }
func (m *Machine) wr16(a uint32, v uint16) { m.wr(a, uint8(v)); m.wr(a+1, uint8(v>>8)) }

func (m *Machine) push(v uint8) {
	m.wr(uint32(m.S), v)
	m.S--
	if m.E {
		m.S = 0x0100 | (m.S & 0xFF)
	}
}
func (m *Machine) pull() uint8 {
	m.S++
	if m.E {
		m.S = 0x0100 | (m.S & 0xFF)
	}
	return m.rd(uint32(m.S))
}
func (m *Machine) push16(v uint16) { m.push(uint8(v >> 8)); m.push(uint8(v)) }
func (m *Machine) pull16() uint16  { lo := m.pull(); return uint16(lo) | uint16(m.pull())<<8 }

func (m *Machine) setP(v uint8) {
	m.P = v
	if m.E {
		m.P |= fM | fX
	}
	if m.P&fX != 0 {
		m.X &= 0xFF
		m.Y &= 0xFF
	}
}

func (m *Machine) nz8(v uint8) {
	m.P &^= fN | fZ
	if v == 0 {
		m.P |= fZ
	}
	m.P |= v & 0x80
}
func (m *Machine) nz16(v uint16) {
	m.P &^= fN | fZ
	if v == 0 {
		m.P |= fZ
	}
	if v&0x8000 != 0 {
		m.P |= fN
	}
}

// ---- effective addresses (operands are compile-time constants) ----
func (m *Machine) eDP(o uint16) uint32  { return uint32(m.D + o) }
func (m *Machine) eDPX(o uint16) uint32 { return uint32(m.D + o + m.X) }
func (m *Machine) eDPY(o uint16) uint32 { return uint32(m.D + o + m.Y) }
func (m *Machine) eABS(o uint16) uint32 { return uint32(m.DB)<<16 | uint32(o) }
func (m *Machine) eABSX(o uint16) uint32 {
	return (uint32(m.DB)<<16 + uint32(o) + uint32(m.X)) & 0xFFFFFF
}
func (m *Machine) eABSY(o uint16) uint32 {
	return (uint32(m.DB)<<16 + uint32(o) + uint32(m.Y)) & 0xFFFFFF
}
func (m *Machine) eABSLX(o uint32) uint32 {
	return (o + uint32(m.X)) & 0xFFFFFF
}
func (m *Machine) eIDP(o uint16) uint32 {
	return uint32(m.DB)<<16 | uint32(m.rd16(uint32(m.D+o)))
}
func (m *Machine) eIDX(o uint16) uint32 {
	return uint32(m.DB)<<16 | uint32(m.rd16(uint32(m.D+o+m.X)))
}
func (m *Machine) eIDY(o uint16) uint32 {
	return (uint32(m.DB)<<16 | uint32(m.rd16(uint32(m.D+o)))) + uint32(m.Y)&0xFFFFFF
}
func (m *Machine) eIDL(o uint16) uint32 {
	p := uint32(m.D + o)
	return uint32(m.rd16(p)) | uint32(m.rd(p+2))<<16
}
func (m *Machine) eIDLY(o uint16) uint32 {
	return (m.eIDL(o) + uint32(m.Y)) & 0xFFFFFF
}
func (m *Machine) eSR(o uint16) uint32 { return uint32(m.S + o) }
func (m *Machine) eSRY(o uint16) uint32 {
	return (uint32(m.DB)<<16 | uint32(m.rd16(uint32(m.S+o)))) + uint32(m.Y)&0xFFFFFF
}

// ---- width-aware access ----
func (m *Machine) ldM(a uint32) uint16 {
	if m.m8() {
		return uint16(m.rd(a))
	}
	return m.rd16(a)
}
func (m *Machine) ldX(a uint32) uint16 {
	if m.x8() {
		return uint16(m.rd(a))
	}
	return m.rd16(a)
}
func (m *Machine) stM(a uint32, v uint16) {
	if m.m8() {
		m.wr(a, uint8(v))
	} else {
		m.wr16(a, v)
	}
}
func (m *Machine) stX(a uint32, v uint16) {
	if m.x8() {
		m.wr(a, uint8(v))
	} else {
		m.wr16(a, v)
	}
}

func (m *Machine) setA(v uint16) {
	if m.m8() {
		m.A = m.A&0xFF00 | v&0xFF
		m.nz8(uint8(v))
	} else {
		m.A = v
		m.nz16(v)
	}
}
func (m *Machine) setXr(v uint16) {
	if m.x8() {
		m.X = v & 0xFF
		m.nz8(uint8(v))
	} else {
		m.X = v
		m.nz16(v)
	}
}
func (m *Machine) setYr(v uint16) {
	if m.x8() {
		m.Y = v & 0xFF
		m.nz8(uint8(v))
	} else {
		m.Y = v
		m.nz16(v)
	}
}
func (m *Machine) nzM(v uint16) {
	if m.m8() {
		m.nz8(uint8(v))
	} else {
		m.nz16(v)
	}
}
func (m *Machine) maskM(v uint16) uint16 {
	if m.m8() {
		return v & 0xFF
	}
	return v
}
func (m *Machine) accM() uint16 { return m.maskM(m.A) }

func (m *Machine) and(v uint16) {
	if m.m8() {
		m.setA(m.A & (v | 0xFF00))
	} else {
		m.setA(m.A & v)
	}
}

func (m *Machine) adc(v uint16) {
	cin := uint32(m.P & fC)
	if m.P&fD != 0 {
		m.adcDec(v, cin)
		return
	}
	if m.m8() {
		a := uint32(m.A & 0xFF)
		r := a + uint32(v&0xFF) + cin
		m.P &^= fV | fC
		if (^(a^uint32(v&0xFF))&(a^r))&0x80 != 0 {
			m.P |= fV
		}
		if r > 0xFF {
			m.P |= fC
		}
		m.setA(uint16(r))
		return
	}
	a := uint32(m.A)
	r := a + uint32(v) + cin
	m.P &^= fV | fC
	if (^(a^uint32(v))&(a^r))&0x8000 != 0 {
		m.P |= fV
	}
	if r > 0xFFFF {
		m.P |= fC
	}
	m.setA(uint16(r))
}

func (m *Machine) adcDec(v uint16, cin uint32) {
	digits := 2
	if !m.m8() {
		digits = 4
	}
	a := uint32(m.accM())
	res, c := uint32(0), cin
	for i := 0; i < digits; i++ {
		s := uint(i * 4)
		d := (a>>s)&0xF + (uint32(v)>>s)&0xF + c
		c = 0
		if d > 9 {
			d += 6
			c = 1
		}
		res |= (d & 0xF) << s
	}
	m.P &^= fC | fV
	if c != 0 {
		m.P |= fC
	}
	m.setA(uint16(res))
}

func (m *Machine) sbc(v uint16) {
	if m.P&fD == 0 {
		if m.m8() {
			m.adc(^v & 0xFF)
		} else {
			m.adc(^v)
		}
		return
	}
	digits := 2
	if !m.m8() {
		digits = 4
	}
	a := uint32(m.accM())
	borrow := int(1 - m.P&fC)
	res := uint32(0)
	for i := 0; i < digits; i++ {
		s := uint(i * 4)
		d := int((a>>s)&0xF) - int((uint32(v)>>s)&0xF) - borrow
		borrow = 0
		if d < 0 {
			d += 10
			borrow = 1
		}
		res |= uint32(d&0xF) << s
	}
	m.P &^= fC | fV
	if borrow == 0 {
		m.P |= fC
	}
	m.setA(uint16(res))
}

func (m *Machine) cmp(r, v uint16, eight bool) {
	if eight {
		r &= 0xFF
		v &= 0xFF
	}
	t := uint32(r) - uint32(v)
	m.P &^= fC
	if r >= v {
		m.P |= fC
	}
	if eight {
		m.nz8(uint8(t))
	} else {
		m.nz16(uint16(t))
	}
}
func (m *Machine) cmpA(v uint16) { m.cmp(m.A, v, m.m8()) }
func (m *Machine) cpx(v uint16)  { m.cmp(m.X, v, m.x8()) }
func (m *Machine) cpy(v uint16)  { m.cmp(m.Y, v, m.x8()) }

func (m *Machine) bitImm(v uint16) {
	r := m.A & v
	if m.m8() {
		r &= 0xFF
	}
	m.P &^= fZ
	if r == 0 {
		m.P |= fZ
	}
}
func (m *Machine) bitMem(a uint32) {
	v := m.ldM(a)
	m.P &^= fZ | fN | fV
	if m.m8() {
		if uint8(m.A)&uint8(v) == 0 {
			m.P |= fZ
		}
		m.P |= uint8(v) & 0xC0
	} else {
		if m.A&v == 0 {
			m.P |= fZ
		}
		m.P |= uint8(v>>8) & 0xC0
	}
}
func (m *Machine) tsb(a uint32, set bool) {
	v := m.ldM(a)
	acc := m.accM()
	m.P &^= fZ
	if v&acc == 0 {
		m.P |= fZ
	}
	if set {
		m.stM(a, v|acc)
	} else {
		m.stM(a, v&^acc)
	}
}

func (m *Machine) asl(v uint16) uint16 {
	m.P &^= fC
	if m.m8() {
		if v&0x80 != 0 {
			m.P |= fC
		}
		return (v << 1) & 0xFF
	}
	if v&0x8000 != 0 {
		m.P |= fC
	}
	return v << 1
}
func (m *Machine) lsr(v uint16) uint16 {
	m.P &^= fC
	m.P |= uint8(v & 1)
	return v >> 1
}
func (m *Machine) rol(v uint16) uint16 {
	cin := uint16(m.P & fC)
	m.P &^= fC
	if m.m8() {
		if v&0x80 != 0 {
			m.P |= fC
		}
		return (v<<1 | cin) & 0xFF
	}
	if v&0x8000 != 0 {
		m.P |= fC
	}
	return v<<1 | cin
}
func (m *Machine) ror(v uint16) uint16 {
	cin := uint16(m.P & fC)
	m.P &^= fC
	m.P |= uint8(v & 1)
	if m.m8() {
		return (v >> 1) | cin<<7
	}
	return (v >> 1) | cin<<15
}
func (m *Machine) inc(v uint16) uint16 { return m.maskM(v + 1) }
func (m *Machine) dec(v uint16) uint16 { return m.maskM(v - 1) }

func (m *Machine) rmw(a uint32, f func(uint16) uint16) {
	r := f(m.ldM(a))
	m.stM(a, r)
	m.nzM(r)
}

func (m *Machine) pushM(v uint16) {
	if m.m8() {
		m.push(uint8(v))
	} else {
		m.push16(v)
	}
}
func (m *Machine) pushX(v uint16) {
	if m.x8() {
		m.push(uint8(v))
	} else {
		m.push16(v)
	}
}
func (m *Machine) pullM() uint16 {
	if m.m8() {
		return uint16(m.pull())
	}
	return m.pull16()
}
func (m *Machine) pullX() uint16 {
	if m.x8() {
		return uint16(m.pull())
	}
	return m.pull16()
}

func (m *Machine) xce() {
	cf := m.P&fC != 0
	m.P &^= fC
	if m.E {
		m.P |= fC
	}
	m.E = cf
	if m.E {
		m.setP(m.P)
		m.S = 0x100 | m.S&0xFF
	}
}

func (m *Machine) tcs() {
	m.S = m.A
	if m.E {
		m.S = 0x100 | m.S&0xFF
	}
}
func (m *Machine) txs() {
	m.S = m.X
	if m.E {
		m.S = 0x100 | m.S&0xFF
	}
}

func (m *Machine) mvn(dst, src uint8, step uint16) {
	m.DB = dst
	for {
		v := m.rd(uint32(src)<<16 | uint32(m.X))
		m.wr(uint32(dst)<<16|uint32(m.Y), v)
		m.X += step
		m.Y += step
		if m.x8() {
			m.X &= 0xFF
			m.Y &= 0xFF
		}
		m.A--
		if m.A == 0xFFFF {
			return
		}
	}
}

// nmi runs the original NMI handler ($80:83DC) as an interrupt and returns
// when it executes RTI.
func (m *Machine) nmi(resume uint32) {
	m.NMIFlag()
	m.inNMI, m.nmiBytes, m.lineBase = true, 0, 0
	if !m.E {
		m.push(m.PB)
	}
	m.push16(uint16(resume))
	m.push(m.P)
	m.P |= fI
	m.P &^= fD
	m.PB = 0
	m.run(0x0083DC)
	m.inNMI = false
}

// vblank is reached where the original busy-waits for the NMI counter ($9F)
// to change. The host gets the finished frame, then the NMI handler runs.
func (m *Machine) vblank(resume uint32) {
	if m.Frame != nil {
		m.Frame()
	}
	m.nmi(resume)
}

func badTarget(pc uint32) {
	panic(fmt.Sprintf("recomp: no code at %06X", pc))
}

// Relocated operands (see relocs in gen.go).
func (m *Machine) rel16(i int) uint16  { return uint16(m.relv[i]) }
func (m *Machine) rel24(i int) uint32  { return m.relv[i] }
func (m *Machine) relBank(i int) uint8 { return uint8(m.relv[i] >> 16) }
