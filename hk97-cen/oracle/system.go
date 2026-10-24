package oracle

import (
	"hk97/hw"
)

// System = interpreted 65816 CPU + shared hardware model. Development only.
type System struct {
	*hw.HW
	CPU        *CPU
	Frames     int
	TraceExec  func(pc uint32)
	frameStart uint64
}

func NewSystem(rom []byte) *System {
	s := &System{HW: hw.New(rom)}
	s.CPU = NewCPU(s.HW)
	s.HW.Scanline = s.scanline
	s.HW.DMACost = func(n int) { s.CPU.Cycles += uint64(n) }
	return s
}

const (
	cyclesPerLine  = 213
	cyclesPerFrame = 262 * cyclesPerLine
	cyclesActive   = 225 * cyclesPerLine
)

func (s *System) scanline() uint16 {
	return uint16((s.CPU.Cycles - s.frameStart) / cyclesPerLine % 262)
}

// RunFrame runs one video frame; the picture is rendered at vblank start.
func (s *System) RunFrame() {
	start := s.CPU.Cycles
	s.frameStart = start
	s.InVblank = false
	for s.CPU.Cycles-start < cyclesActive {
		s.step()
	}
	s.PPU.Render()
	s.InVblank = true
	s.NMIFlag()
	if s.NMIEnabled() {
		s.CPU.NMI()
	}
	for s.CPU.Cycles-start < cyclesPerFrame {
		s.step()
	}
	s.Frames++
}

func (s *System) step() {
	if s.TraceExec != nil {
		s.TraceExec(uint32(s.CPU.PB)<<16 | uint32(s.CPU.PC))
	}
	s.CPU.Step()
}

// StepUntil runs instructions (with frame timing, rendering and NMIs) until
// the program counter reaches stop. It returns false if maxFrames elapse first.
func (s *System) StepUntil(stop uint32, maxFrames int) bool {
	frames := 0
	for {
		pc := uint32(s.CPU.PB&0x7F)<<16 | uint32(s.CPU.PC)
		if pc == stop {
			return true
		}
		s.step()
		el := s.CPU.Cycles - s.frameStart
		if !s.InVblank && el >= cyclesActive {
			s.PPU.Render()
			s.InVblank = true
			s.NMIFlag()
			if s.NMIEnabled() {
				s.CPU.NMI()
			}
		}
		if el >= cyclesPerFrame {
			s.frameStart += cyclesPerFrame
			s.InVblank = false
			s.Frames++
			frames++
			if frames > maxFrames {
				return false
			}
		}
	}
}

// StepUntilNext steps at least one instruction, then runs to stop.
func (s *System) StepUntilNext(stop uint32, maxFrames int) bool {
	s.step()
	return s.StepUntil(stop, maxFrames)
}
