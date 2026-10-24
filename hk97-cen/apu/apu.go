// Package apu emulates the SNES audio unit: the SPC700 sound CPU, its
// timers and I/O, and the S-DSP. The game uploads its sound program (from
// assets/sound via the data image) through the usual boot handshake, which
// is handled here at a high level instead of running the boot ROM.
package apu

const (
	CPUClock   = 1024000 // SPC700 cycles per second
	SampleRate = 32000
)

type timer struct {
	enabled bool
	stage   int // cycles until next tick
	period  int // 128 (8 kHz) or 16 (64 kHz)
	div     int // internal divider
	target  int
	counter uint8
}

type APU struct {
	ram  [0x10000]uint8
	c    spc
	dsp  dsp
	t    [3]timer
	in   [4]uint8 // written by the S-CPU, read by the SPC700
	out  [4]uint8 // written by the SPC700, read by the S-CPU
	cyc  int      // cycles towards the next DSP sample
	dspA uint8

	running bool // sound program started

	// boot upload handshake (stand-in for the SPC700 boot ROM)
	iplState  int
	iplExpect uint8
	iplDest   uint16
	iplIndex  uint16 // bytes stored in the current block
	pending   int    // counter value whose data byte is still to be stored, or -1

	// OnCommand, if set, is called after each S-CPU write once the sound
	// program runs (tools use it to snapshot the state).
	OnCommand func(p int, v uint8)

	// output
	samples []int16 // interleaved stereo at 32 kHz
	budget  float64
	mark    int
}

func New() *APU {
	a := &APU{}
	a.dsp.reset()
	a.out = [4]uint8{0xAA, 0xBB, 0, 0}
	a.t[0].period, a.t[1].period, a.t[2].period = 128, 128, 16
	a.pending = -1
	return a
}

// ---------------------------------------------------------- SPC700 side ---

func (a *APU) read(addr uint16) uint8 {
	if addr >= 0xF0 && addr <= 0xFF {
		switch addr {
		case 0xF2:
			return a.dspA
		case 0xF3:
			return a.dsp.read(a.dspA)
		case 0xF4, 0xF5, 0xF6, 0xF7:
			return a.in[addr-0xF4]
		case 0xF8, 0xF9:
			return a.ram[addr]
		case 0xFD, 0xFE, 0xFF:
			t := &a.t[addr-0xFD]
			v := t.counter
			t.counter = 0
			return v
		}
		return 0
	}
	return a.ram[addr]
}

func (a *APU) write(addr uint16, v uint8) {
	a.ram[addr] = v
	if addr < 0xF0 || addr > 0xFF {
		return
	}
	switch addr {
	case 0xF1:
		for i := 0; i < 3; i++ {
			on := v&(1<<uint(i)) != 0
			if on && !a.t[i].enabled {
				a.t[i].div, a.t[i].counter = 0, 0
			}
			a.t[i].enabled = on
		}
		if v&0x10 != 0 {
			a.in[0], a.in[1] = 0, 0
		}
		if v&0x20 != 0 {
			a.in[2], a.in[3] = 0, 0
		}
	case 0xF2:
		a.dspA = v
	case 0xF3:
		a.dsp.write(a.dspA, v)
	case 0xF4, 0xF5, 0xF6, 0xF7:
		a.out[addr-0xF4] = v
	case 0xFA, 0xFB, 0xFC:
		t := int(v)
		if t == 0 {
			t = 256
		}
		a.t[addr-0xFA].target = t
	}
}

// run advances the sound CPU, timers and DSP by about n cycles.
func (a *APU) run(n int) {
	for n > 0 {
		c := a.step()
		n -= c
		for i := range a.t {
			t := &a.t[i]
			t.stage -= c
			for t.stage <= 0 {
				t.stage += t.period
				if t.enabled {
					t.div++
					if t.div >= t.target {
						t.div = 0
						t.counter = (t.counter + 1) & 0x0F
					}
				}
			}
		}
		a.cyc += c
		for a.cyc >= 32 {
			a.cyc -= 32
			l, r := a.sample()
			a.samples = append(a.samples, int16(l), int16(r))
		}
	}
}

// ------------------------------------------------------------ S-CPU side ---

// CPURead returns what the S-CPU sees at $2140+p.
func (a *APU) CPURead(p int) uint8 {
	if a.running {
		a.run(64) // let a waiting program make progress
		a.budget -= 64
		return a.out[p]
	}
	a.commit()
	return a.out[p]
}

// CPUWrite handles an S-CPU write to $2140+p.
func (a *APU) CPUWrite(p int, v uint8) {
	if a.running {
		a.in[p] = v
		if a.OnCommand != nil {
			a.OnCommand(p, v)
		}
		return
	}
	if p != 0 {
		a.in[p] = v
		if p == 1 {
			a.commit() // the data byte for the counter just written to port 0
		}
		return
	}
	a.commit()
	a.in[0] = v
	switch {
	case a.iplState == 0 && v == 0xCC: // first command
		a.command(v)
	case a.iplState == 1 && v == a.iplExpect: // data byte: port1 arrives next
		a.pending = int(a.iplIndex)
		a.iplIndex++
		a.iplExpect++
		a.out[0] = v
	case a.iplState == 1:
		a.command(v)
	}
}

func (a *APU) command(v uint8) {
	dest := uint16(a.in[2]) | uint16(a.in[3])<<8
	a.out[0] = v
	if a.iplState == 1 && a.in[1] == 0 { // execute
		a.start(dest)
		return
	}
	a.iplState, a.iplExpect, a.iplDest, a.iplIndex = 1, 0, dest, 0
}

// commit stores the data byte of the last handshake step (the S-CPU
// writes the counter to port 0 and the byte to port 1 in one 16-bit store).
func (a *APU) commit() {
	if a.pending >= 0 {
		a.ram[a.iplDest+uint16(a.pending)] = a.in[1]
		a.pending = -1
	}
}

func (a *APU) start(entry uint16) {
	a.running = true
	a.c = spc{pc: entry, sp: 0xEF, psw: 0x02}
	a.in = [4]uint8{}
	a.write(0xF1, 0x00)
}

// Frame runs the audio unit for one video frame (1/60.0988 s) and returns
// the stereo samples produced (interleaved int16 at 32 kHz).
func (a *APU) Frame() []int16 {
	a.samples = a.samples[:0]
	if !a.running {
		// silence while the program is not uploaded yet
		a.budget += SampleRate / 60.0988
		n := int(a.budget)
		a.budget -= float64(n)
		for i := 0; i < n; i++ {
			a.samples = append(a.samples, 0, 0)
		}
		return a.samples
	}
	a.budget += CPUClock / 60.0988
	n := int(a.budget)
	a.budget -= float64(n)
	if n > 0 {
		a.run(n)
	}
	return a.samples
}

// Running reports whether the sound program has been started.
func (a *APU) Running() bool { return a.running }

// RAM exposes the sound CPU's memory (for tools and tests).
func (a *APU) RAM() []uint8 { return a.ram[:] }

// SnapshotSPC returns the current state as an .spc file (v0.30 layout),
// for listening in other players or comparing implementations.
func (a *APU) SnapshotSPC() []byte {
	f := make([]byte, 0x10200)
	copy(f, "SNES-SPC700 Sound File Data v0.30")
	f[0x21], f[0x22], f[0x23], f[0x24] = 0x1A, 0x1A, 0x1B, 30
	f[0x25], f[0x26] = uint8(a.c.pc), uint8(a.c.pc>>8)
	f[0x27], f[0x28], f[0x29], f[0x2A], f[0x2B] = a.c.a, a.c.x, a.c.y, a.c.psw, a.c.sp
	copy(f[0x100:], a.ram[:])
	for i := 0; i < 4; i++ {
		f[0x100+0xF4+i] = a.in[i]
	}
	for i := 0; i < 3; i++ {
		f[0x100+0xFD+i] = a.t[i].counter
	}
	copy(f[0x10100:], a.dsp.regs[:])
	return f
}

// ResetOutput marks the current point in the sample stream; SinceReset
// returns the samples produced in this frame after that point.
func (a *APU) ResetOutput() { a.mark = len(a.samples) }

func (a *APU) SinceReset() []int16 {
	if a.mark > len(a.samples) {
		return nil
	}
	return a.samples[a.mark:]
}
