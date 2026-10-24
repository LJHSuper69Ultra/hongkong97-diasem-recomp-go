package hw

import "hk97/ppu"

// HW is the SNES memory map and CPU-side I/O used by Hong Kong 97:
// LoROM, WRAM, PPU ports, DMA, multiply/divide, auto-joypad, APU ports.
type HW struct {
	PPU  *ppu.PPU
	ROM  []byte
	WRAM [0x20000]byte

	Joy1 uint16 // SNES bit layout: B Y Sel Start U D L R A X L R 0 0 0 0

	nmitimen uint8
	rdnmi    uint8
	dma      [8][11]uint8
	wramAddr uint32
	m7a      uint16
	m7latch  uint8
	mulRes   int32
	wrmpya   uint8
	wrdiv    uint16
	rddiv    uint16
	rdmpy    uint16

	apuOut    [4]uint8
	apuKick   int // 0 none, 1 pending echo, 2 driver running
	iplState  int
	iplExpect uint8
	vLatch    uint16
	opvctHi   bool

	// Scanline reports the current V counter; DMACost is told how many bytes a DMA moved.
	Scanline func() uint16
	DMACost  func(n int)
	InVblank bool
	// APU, if set, is the emulated audio unit behind ports $2140-$2143;
	// otherwise a minimal stand-in answers the boot upload handshake.
	APU interface {
		CPURead(p int) uint8
		CPUWrite(p int, v uint8)
	}
	// OnDMARead, if set, sees every A-bus address a DMA reads from.
	OnDMARead func(addr uint32)
}

func New(rom []byte) *HW {
	s := &HW{ROM: rom, PPU: ppu.New()}
	s.apuOut = [4]uint8{0xAA, 0xBB, 0, 0}
	s.Scanline = func() uint16 { return 0 }
	s.DMACost = func(int) {}
	return s
}

// NMIFlag sets RDNMI ($4210 bit 7); NMIEnabled reports NMITIMEN bit 7.
func (s *HW) NMIFlag()         { s.rdnmi = 0x80 }
func (s *HW) NMIEnabled() bool { return s.nmitimen&0x80 != 0 }

func (s *HW) romRead(bank uint8, a uint16) uint8 {
	o := int(bank&0x7F)*0x8000 + int(a&0x7FFF)
	if o < len(s.ROM) {
		return s.ROM[o]
	}
	return 0
}

func (s *HW) Read(addr uint32) uint8 {
	bank := uint8(addr >> 16)
	a := uint16(addr)
	if bank == 0x7E || bank == 0x7F {
		return s.WRAM[addr-0x7E0000]
	}
	if bank&0x40 == 0 && a < 0x8000 { // system area
		switch {
		case a < 0x2000:
			return s.WRAM[a]
		case a == 0x2137:
			s.vLatch = s.Scanline()
			return 0
		case a == 0x213D:
			s.opvctHi = !s.opvctHi
			if s.opvctHi {
				return uint8(s.vLatch)
			}
			return uint8(s.vLatch>>8) & 1
		case a == 0x213F:
			s.opvctHi = false
			return 0x01
		case a >= 0x2134 && a <= 0x2136:
			return uint8(s.mulRes >> ((a - 0x2134) * 8))
		case a >= 0x2100 && a < 0x2140:
			return s.PPU.Read(a)
		case a >= 0x2140 && a < 0x2180:
			return s.apuRead(a & 3)
		case a == 0x2180:
			v := s.WRAM[s.wramAddr&0x1FFFF]
			s.wramAddr++
			return v
		case a == 0x4210:
			v := s.rdnmi | 0x02
			s.rdnmi = 0
			return v
		case a == 0x4211:
			return 0
		case a == 0x4212:
			if s.InVblank {
				return 0x80
			}
			return 0
		case a == 0x4214:
			return uint8(s.rddiv)
		case a == 0x4215:
			return uint8(s.rddiv >> 8)
		case a == 0x4216:
			return uint8(s.rdmpy)
		case a == 0x4217:
			return uint8(s.rdmpy >> 8)
		case a == 0x4218:
			return uint8(s.Joy1)
		case a == 0x4219:
			return uint8(s.Joy1 >> 8)
		case a >= 0x421A && a <= 0x421F:
			return 0
		case a >= 0x4300 && a < 0x4380:
			if a&0xF < 11 {
				return s.dma[(a>>4)&7][a&0xF]
			}
			return 0
		}
		return 0
	}
	return s.romRead(bank, a)
}

func (s *HW) Write(addr uint32, v uint8) {
	bank := uint8(addr >> 16)
	a := uint16(addr)
	if bank == 0x7E || bank == 0x7F {
		s.WRAM[addr-0x7E0000] = v
		return
	}
	if bank&0x40 != 0 || a >= 0x8000 {
		return
	}
	switch {
	case a < 0x2000:
		s.WRAM[a] = v
	case a == 0x211B:
		s.m7a = uint16(v)<<8 | uint16(s.m7latch)
		s.m7latch = v
	case a == 0x211C:
		s.mulRes = int32(int16(s.m7a)) * int32(int8(v))
		s.m7latch = v
	case a >= 0x2100 && a < 0x2140:
		s.PPU.Write(a, v)
	case a >= 0x2140 && a < 0x2180:
		s.apuWrite(a&3, v)
	case a == 0x2180:
		s.WRAM[s.wramAddr&0x1FFFF] = v
		s.wramAddr++
	case a == 0x2181:
		s.wramAddr = s.wramAddr&0x1FF00 | uint32(v)
	case a == 0x2182:
		s.wramAddr = s.wramAddr&0x100FF | uint32(v)<<8
	case a == 0x2183:
		s.wramAddr = s.wramAddr&0xFFFF | uint32(v&1)<<16
	case a == 0x4200:
		s.nmitimen = v
	case a == 0x4202:
		s.wrmpya = v
	case a == 0x4203:
		s.rdmpy = uint16(s.wrmpya) * uint16(v)
	case a == 0x4204:
		s.wrdiv = s.wrdiv&0xFF00 | uint16(v)
	case a == 0x4205:
		s.wrdiv = s.wrdiv&0x00FF | uint16(v)<<8
	case a == 0x4206:
		if v == 0 {
			s.rddiv, s.rdmpy = 0xFFFF, s.wrdiv
		} else {
			s.rddiv, s.rdmpy = s.wrdiv/uint16(v), s.wrdiv%uint16(v)
		}
	case a == 0x420B:
		for ch := 0; ch < 8; ch++ {
			if v&(1<<uint(ch)) != 0 {
				s.runDMA(ch)
			}
		}
	case a >= 0x4300 && a < 0x4380:
		r := a & 0xF
		if r < 11 {
			s.dma[(a>>4)&7][r] = v
		}
	}
}

// ---- APU: high-level stand-in for the IPL upload handshake ----
func (s *HW) apuRead(p uint16) uint8 {
	if s.APU != nil {
		return s.APU.CPURead(int(p))
	}
	if p == 0 {
		switch s.apuKick {
		case 1:
			s.apuKick = 2
			return s.apuOut[0]
		case 2:
			return 0
		}
	}
	return s.apuOut[p]
}

func (s *HW) apuWrite(p uint16, v uint8) {
	if s.APU != nil {
		s.APU.CPUWrite(int(p), v)
		return
	}
	if s.apuKick == 2 {
		return
	}
	if p == 0 {
		switch s.iplState {
		case 0: // waiting for $CC start command
			s.iplState, s.iplExpect = 1, 0
		case 1:
			if v == s.iplExpect {
				s.iplExpect++
			} else if s.apuOut[1] == 0 {
				s.apuKick = 1 // execute command
			} else {
				s.iplExpect = 0 // next block
			}
		}
	}
	s.apuOut[p] = v
}

func (s *HW) runDMA(ch int) {
	r := s.dma[ch]
	ctrl := r[0]
	bAddr := uint16(0x2100) | uint16(r[1])
	src := uint32(r[2]) | uint32(r[3])<<8
	bank := uint32(r[4]) << 16
	n := int(r[5]) | int(r[6])<<8
	if n == 0 {
		n = 0x10000
	}
	mode := ctrl & 7
	fixed := ctrl&0x08 != 0
	dec := ctrl&0x10 != 0
	toCPU := ctrl&0x80 != 0
	pattern := map[uint8][]uint16{0: {0}, 1: {0, 1}, 2: {0, 0}, 3: {0, 0, 1, 1}, 4: {0, 1, 2, 3}, 5: {0, 1, 0, 1}, 6: {0, 0}, 7: {0, 0, 1, 1}}[mode]
	for i := 0; i < n; i++ {
		b := bAddr + pattern[i%len(pattern)]
		aa := bank | src
		if s.OnDMARead != nil && !toCPU {
			s.OnDMARead(aa)
		}
		if toCPU {
			s.Write(aa, s.Read(uint32(b)))
		} else {
			s.Write(uint32(b), s.Read(aa))
		}
		if !fixed {
			if dec {
				src = (src - 1) & 0xFFFF
			} else {
				src = (src + 1) & 0xFFFF
			}
		}
	}
	s.dma[ch][5], s.dma[ch][6] = 0, 0
	s.dma[ch][2], s.dma[ch][3] = uint8(src), uint8(src>>8)
	s.DMACost(n)
}
