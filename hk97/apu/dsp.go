package apu

// S-DSP: 8 BRR sample voices with ADSR/GAIN envelopes, gaussian
// interpolation, noise, pitch modulation and an 8-tap FIR echo, producing
// one stereo sample every 32 SPC700 cycles (32 kHz).

const (
	envRelease = iota
	envAttack
	envDecay
	envSustain
)

// global register numbers
const (
	rMVOLL = 0x0C
	rMVOLR = 0x1C
	rEVOLL = 0x2C
	rEVOLR = 0x3C
	rKON   = 0x4C
	rKOFF  = 0x5C
	rFLG   = 0x6C
	rENDX  = 0x7C
	rEFB   = 0x0D
	rPMON  = 0x2D
	rNON   = 0x3D
	rEON   = 0x4D
	rDIR   = 0x5D
	rESA   = 0x6D
	rEDL   = 0x7D
)

const counterRange = 2048 * 5 * 3

var counterRates = [32]int{
	counterRange + 1, // never fires
	2048, 1536, 1280, 1024, 768, 640, 512, 384, 320, 256, 192, 160, 128, 96, 80,
	64, 48, 40, 32, 24, 20, 16, 12, 10, 8, 6, 5, 4, 3, 2, 1,
}

var counterOffsets = [32]int{
	1, 0, 1040, 536, 0, 1040, 536, 0, 1040, 536, 0, 1040, 536, 0, 1040, 536,
	0, 1040, 536, 0, 1040, 536, 0, 1040, 536, 0, 1040, 536, 0, 1040, 0, 0,
}

type voice struct {
	buf       [24]int32 // 12 decoded samples, stored twice to avoid wrap checks
	bufPos    int
	interpPos int
	brrAddr   uint16
	brrOffset int
	konDelay  int
	envMode   int
	env       int
	hiddenEnv int
}

type dsp struct {
	regs       [128]uint8
	v          [8]voice
	counter    int
	everyOther bool
	newKon     uint8
	kon        uint8
	koff       uint8
	noise      int
	lastOut    int32 // previous voice's output, for pitch modulation
	echoOff    int
	echoLen    int
	hist       [8][2]int32 // FIR history, oldest first
}

func clamp16(v int32) int32 {
	if v < -32768 {
		return -32768
	}
	if v > 32767 {
		return 32767
	}
	return v
}

func (d *dsp) reset() {
	*d = dsp{}
	d.regs[rFLG] = 0xE0
	d.noise = 0x4000
	d.counter = 0
}

func (d *dsp) read(addr uint8) uint8 { return d.regs[addr&0x7F] }

func (d *dsp) write(addr, v uint8) {
	if addr >= 0x80 {
		return
	}
	d.regs[addr] = v
	switch addr {
	case rKON:
		d.newKon = v
	case rENDX:
		d.regs[rENDX] = 0 // any write clears it
	}
}

func (d *dsp) readCounter(rate int) bool {
	return (d.counter+counterOffsets[rate])%counterRates[rate] == 0
}

// decodeBRR decodes the next 4 samples of a voice into its buffer.
func (a *APU) decodeBRR(v *voice) {
	header := a.ram[v.brrAddr]
	o := v.brrAddr + uint16(v.brrOffset)
	nyb := uint16(a.ram[o])<<8 | uint16(a.ram[o+1])
	shift := uint(header >> 4)
	filter := header & 0x0C
	for k := 0; k < 4; k++ {
		s := int32(int16(nyb)) >> 12
		nyb <<= 4
		s = (s << shift) >> 1
		if shift >= 0xD {
			if s < 0 {
				s = -0x800
			} else {
				s = 0
			}
		}
		pos := v.bufPos
		p1 := v.buf[(pos+11)%12]
		p2 := v.buf[(pos+10)%12] >> 1
		switch {
		case filter == 8:
			s += p1 - p2 + p2>>4 + (p1*-3)>>6
		case filter == 12:
			s += p1 - p2 + (p1*-13)>>7 + (p2*3)>>4
		case filter == 4:
			s += p1>>1 + (-p1)>>5
		}
		s = int32(int16(clamp16(s) * 2))
		v.buf[pos], v.buf[pos+12] = s, s
		v.bufPos = (pos + 1) % 12
	}
}

// sample runs the DSP for one 32 kHz output sample.
func (a *APU) sample() (int32, int32) {
	d := &a.dsp
	r := &d.regs
	d.counter--
	if d.counter < 0 {
		d.counter = counterRange - 1
	}
	// key on / key off are latched every other sample
	d.everyOther = !d.everyOther
	if d.everyOther {
		d.kon = d.newKon
		d.newKon &^= d.kon
		d.koff = r[rKOFF]
	}
	flg := r[rFLG]
	if d.readCounter(int(flg & 0x1F)) {
		fb := (d.noise<<13 ^ d.noise<<14) & 0x4000
		d.noise = fb ^ d.noise>>1
	}
	dir := uint16(r[rDIR]) << 8
	var mainL, mainR, echoL, echoR int32
	d.lastOut = 0
	for i := 0; i < 8; i++ {
		v := &d.v[i]
		vr := r[i<<4 : i<<4+10]
		bit := uint8(1) << uint(i)

		if d.everyOther {
			if d.koff&bit != 0 {
				v.envMode = envRelease
			}
			if d.kon&bit != 0 {
				v.konDelay = 5
				v.envMode = envAttack
				r[rENDX] &^= bit
			}
			if flg&0x80 != 0 {
				v.envMode = envRelease
				v.env = 0
			}
		}

		pitch := int(vr[2]) | int(vr[3]&0x3F)<<8
		if i > 0 && r[rPMON]&bit != 0 {
			pitch += int((d.lastOut>>5)*int32(pitch)) >> 10
		}

		if v.konDelay > 0 {
			if v.konDelay == 5 {
				src := dir + uint16(vr[4])*4
				v.brrAddr = uint16(a.ram[src]) | uint16(a.ram[src+1])<<8
				v.brrOffset = 1
				v.bufPos = 0
			}
			v.env, v.hiddenEnv = 0, 0
			v.interpPos = 0
			v.konDelay--
			if v.konDelay&3 != 0 {
				v.interpPos = 0x4000
			}
			pitch = 0
		}

		// interpolated (or noise) output
		var out int32
		if r[rNON]&bit != 0 {
			out = int32(int16(d.noise * 2))
		} else {
			ofs := v.interpPos >> 4 & 0xFF
			base := v.interpPos>>12 + v.bufPos
			out = (gauss[255-ofs] * v.buf[base]) >> 11
			out += (gauss[511-ofs] * v.buf[base+1]) >> 11
			out += (gauss[256+ofs] * v.buf[base+2]) >> 11
			out = int32(int16(out))
			out += (gauss[ofs] * v.buf[base+3]) >> 11
			out = clamp16(out) &^ 1
		}
		out = (out * int32(v.env)) >> 11 &^ 1
		vr[8] = uint8(v.env >> 4)
		vr[9] = uint8(out >> 8)
		d.lastOut = out

		a.runEnvelope(v, vr)

		// BRR decoding when the interpolation window advances
		if v.interpPos >= 0x4000 {
			a.decodeBRR(v)
			v.brrOffset += 2
			if v.brrOffset >= 9 {
				header := a.ram[v.brrAddr]
				v.brrAddr += 9
				if header&1 != 0 {
					src := dir + uint16(vr[4])*4
					v.brrAddr = uint16(a.ram[src+2]) | uint16(a.ram[src+3])<<8
					r[rENDX] |= bit
					if header&2 == 0 {
						v.envMode = envRelease
						v.env = 0
					}
				}
				v.brrOffset = 1
			}
		}
		v.interpPos = v.interpPos&0x3FFF + pitch
		if v.interpPos > 0x7FFF {
			v.interpPos = 0x7FFF
		}

		l := (out * int32(int8(vr[0]))) >> 7
		rr := (out * int32(int8(vr[1]))) >> 7
		mainL = clamp16(mainL + l)
		mainR = clamp16(mainR + rr)
		if r[rEON]&bit != 0 {
			echoL = clamp16(echoL + l)
			echoR = clamp16(echoR + rr)
		}
	}

	// echo: read the delayed sample, filter, feed back, write
	if d.echoOff == 0 {
		d.echoLen = int(r[rEDL]&0x0F) * 0x800
	}
	ea := uint16(r[rESA])<<8 + uint16(d.echoOff)
	copy(d.hist[:7], d.hist[1:])
	d.hist[7][0] = int32(int16(uint16(a.ram[ea])|uint16(a.ram[ea+1])<<8)) >> 1
	d.hist[7][1] = int32(int16(uint16(a.ram[ea+2])|uint16(a.ram[ea+3])<<8)) >> 1
	var fir [2]int32
	for ch := 0; ch < 2; ch++ {
		var s int32
		for k := 0; k < 7; k++ {
			s += (d.hist[k][ch] * int32(int8(r[k<<4|0x0F]))) >> 6
		}
		s = int32(int16(s))
		s += (d.hist[7][ch] * int32(int8(r[0x7F]))) >> 6
		fir[ch] = clamp16(s) &^ 1
	}
	efb := int32(int8(r[rEFB]))
	echoL = clamp16(echoL + (fir[0]*efb)>>7)
	echoR = clamp16(echoR + (fir[1]*efb)>>7)
	if flg&0x20 == 0 {
		a.ram[ea], a.ram[ea+1] = uint8(echoL&^1), uint8((echoL&^1)>>8)
		a.ram[ea+2], a.ram[ea+3] = uint8(echoR&^1), uint8((echoR&^1)>>8)
	}
	d.echoOff += 4
	if d.echoOff >= d.echoLen {
		d.echoOff = 0
	}

	outL := clamp16((mainL*int32(int8(r[rMVOLL])))>>7 + (fir[0]*int32(int8(r[rEVOLL])))>>7)
	outR := clamp16((mainR*int32(int8(r[rMVOLR])))>>7 + (fir[1]*int32(int8(r[rEVOLR])))>>7)
	if flg&0x40 != 0 {
		outL, outR = 0, 0
	}
	return outL, outR
}

func (a *APU) runEnvelope(v *voice, vr []uint8) {
	d := &a.dsp
	env := v.env
	if v.envMode == envRelease {
		env -= 8
		if env < 0 {
			env = 0
		}
		v.env = env
		return
	}
	var rate int
	adsr0 := vr[5]
	envData := int(vr[6])
	if adsr0&0x80 != 0 {
		if v.envMode >= envDecay {
			env--
			env -= env >> 8
			rate = envData & 0x1F
			if v.envMode == envDecay {
				rate = int(adsr0>>3&0x0E) + 0x10
			}
		} else {
			rate = int(adsr0&0x0F)*2 + 1
			if rate < 31 {
				env += 0x20
			} else {
				env += 0x400
			}
		}
	} else {
		envData = int(vr[7])
		mode := envData >> 5
		if mode < 4 {
			env = envData * 0x10
			rate = 31
		} else {
			rate = envData & 0x1F
			switch {
			case mode == 4:
				env -= 0x20
			case mode < 6:
				env--
				env -= env >> 8
			default:
				env += 0x20
				if mode > 6 && uint(v.hiddenEnv) >= 0x600 {
					env += 0x8 - 0x20
				}
			}
		}
	}
	if env>>8 == envData>>5 && v.envMode == envDecay {
		v.envMode = envSustain
	}
	v.hiddenEnv = env
	if uint(env) > 0x7FF {
		if env < 0 {
			env = 0
		} else {
			env = 0x7FF
		}
		if v.envMode == envAttack {
			v.envMode = envDecay
		}
	}
	if d.readCounter(rate) {
		v.env = env
	}
}
