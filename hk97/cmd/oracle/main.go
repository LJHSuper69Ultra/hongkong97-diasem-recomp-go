package main

import (
	"flag"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"os"
	"strconv"
	"strings"

	"hk97/internal/bot"
	"hk97/oracle"
)

// input script: "frame:buttons,frame:buttons" where buttons = hex SNES mask held from that frame
func main() {
	romPath := flag.String("rom", "", "rom")
	frames := flag.Int("n", 600, "frames")
	shots := flag.String("shots", "", "comma separated frame numbers to dump")
	script := flag.String("in", "", "input script")
	out := flag.String("o", "out", "out dir")
	cov := flag.String("cov", "", "coverage file")
	botFrom := flag.Int("bot", 0, "autoplay from this frame (0=off)")
	godUntil := flag.Int("god", 0, "keep invincible until this frame")
	flag.Parse()
	rom, err := os.ReadFile(*romPath)
	if err != nil {
		panic(err)
	}
	sys := oracle.NewSystem(rom)
	seen := map[uint32]bool{}
	if *cov != "" {
		sys.TraceExec = func(pc uint32) { seen[(pc&0x7FFFFF)|uint32(sys.CPU.P&0x30)<<24] = true }
	}
	defer func() {
		if *cov != "" {
			f, _ := os.Create(*cov)
			for pc := range seen {
				fmt.Fprintf(f, "%06X %02X\n", pc&0xFFFFFF, pc>>24)
			}
			f.Close()
		}
	}()
	want := map[int]bool{}
	for _, f := range strings.Split(*shots, ",") {
		if n, err := strconv.Atoi(f); err == nil {
			want[n] = true
		}
	}
	type ev struct {
		f int
		m uint16
	}
	var evs []ev
	for _, p := range strings.Split(*script, ",") {
		if p == "" {
			continue
		}
		kv := strings.Split(p, ":")
		f, _ := strconv.Atoi(kv[0])
		m, _ := strconv.ParseUint(kv[1], 16, 16)
		evs = append(evs, ev{f, uint16(m)})
	}
	os.MkdirAll(*out, 0755)
	for f := 0; f < *frames; f++ {
		for _, e := range evs {
			if e.f == f {
				sys.Joy1 = e.m
			}
		}
		if *botFrom > 0 && f >= *botFrom {
			sys.Joy1 = bot.Input(sys.WRAM[:], f)
			if f < *godUntil && sys.WRAM[0x0ED6] == 0 {
				sys.WRAM[0x0ED6] = 2
			}
			if f < *godUntil && sys.WRAM[0x0ED6] == 2 {
				sys.WRAM[0x0EDC], sys.WRAM[0x0EDD] = 0, 1
			}
		}
		sys.RunFrame()
		if want[f] {
			img := image.NewRGBA(image.Rect(0, 0, 256, 224))
			for i, c := range sys.PPU.Frame {
				img.Set(i%256, i/256, color.RGBA{uint8(c >> 16), uint8(c >> 8), uint8(c), 255})
			}
			fh, _ := os.Create(fmt.Sprintf("%s/f%05d.png", *out, f))
			png.Encode(fh, img)
			fh.Close()
			fmt.Printf("frame %d pc=%02X:%04X\n", f, sys.CPU.PB, sys.CPU.PC)
		}
	}
}
