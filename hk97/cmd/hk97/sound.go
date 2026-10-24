package main

import (
	"sync"
	"time"

	"github.com/hajimehoshi/ebiten/v2/audio"

	"hk97/apu"
)

const outRate = 48000

// stream carries audio from the game goroutine to the audio player,
// converting the S-DSP's 32 kHz output to 48 kHz.
type stream struct {
	mu    sync.Mutex
	buf   []int16 // interleaved stereo at outRate
	pos   float64 // resampler position within the input
	lastL int32
	lastR int32
	muted bool
}

// push appends one frame of 32 kHz samples.
func (s *stream) push(in []int16) {
	step := float64(apu.SampleRate) / outRate
	n := len(in) / 2
	s.mu.Lock()
	defer s.mu.Unlock()
	for ; s.pos < float64(n); s.pos += step {
		i := int(s.pos)
		f := s.pos - float64(i)
		var l0, r0 int32
		if i == 0 {
			l0, r0 = s.lastL, s.lastR
		} else {
			l0, r0 = int32(in[2*i-2]), int32(in[2*i-1])
		}
		l1, r1 := int32(in[2*i]), int32(in[2*i+1])
		l := float64(l0) + (float64(l1-l0))*f
		r := float64(r0) + (float64(r1-r0))*f
		s.buf = append(s.buf, int16(l), int16(r))
	}
	s.pos -= float64(n)
	if n > 0 {
		s.lastL, s.lastR = int32(in[2*n-2]), int32(in[2*n-1])
	}
	// keep latency bounded: drop the oldest audio beyond ~150 ms
	if max := outRate * 2 * 150 / 1000; len(s.buf) > max {
		s.buf = append(s.buf[:0], s.buf[len(s.buf)-max:]...)
	}
}

// Read implements io.Reader for the audio player (16-bit LE stereo). It
// returns what is available; with nothing queued it waits a little and
// then supplies a short piece of silence.
func (s *stream) Read(p []byte) (int, error) {
	n := len(p) / 4 * 4
	for wait := 0; ; wait++ {
		s.mu.Lock()
		if len(s.buf) >= 2 || wait >= 10 {
			break
		}
		s.mu.Unlock()
		time.Sleep(2 * time.Millisecond)
	}
	defer s.mu.Unlock()
	if len(s.buf) < 2 {
		k := min(n, 256*4)
		clear(p[:k])
		return k, nil
	}
	k := 0
	for ; k+3 < n && len(s.buf) >= 2; k += 4 {
		l, r := s.buf[0], s.buf[1]
		if s.muted {
			l, r = 0, 0
		}
		p[k], p[k+1], p[k+2], p[k+3] = byte(l), byte(uint16(l)>>8), byte(r), byte(uint16(r)>>8)
		s.buf = s.buf[2:]
	}
	return k, nil
}

func startAudio(s *stream) {
	ctx := audio.NewContext(outRate)
	p, err := ctx.NewPlayer(s)
	if err != nil {
		return // no audio device: play silently
	}
	p.SetBufferSize(50 * time.Millisecond)
	p.Play()
}
