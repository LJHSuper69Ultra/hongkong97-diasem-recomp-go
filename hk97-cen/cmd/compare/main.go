// compare runs the reference emulator and the recompiled port side by side
// and reports the first logical frame where game RAM or PPU memory differs.
package main

import (
	"flag"
	"fmt"
	"os"
	"strconv"
	"strings"

	"encoding/json"
	"hk97/internal/bot"
	"hk97/oracle"
	"hk97/recomp"
)

func main() {
	romPath := flag.String("rom", "", "rom")
	portData := flag.String("data", "", "data image for the port (default: the ROM)")
	symsPath := flag.String("syms", "", "asset address table for -data (from tools/pack)")
	n := flag.Int("n", 2000, "logical frames")
	script := flag.String("in", "", "frame:mask,...")
	ignore := flag.String("ignore", "1E00-1FFF,9F,A0,A8", "WRAM ranges to ignore")
	maxDiff := flag.Int("max", 3, "stop after this many differing frames")
	botFrom := flag.Int("bot", 0, "autoplay from logical frame")
	godUntil := flag.Int("god", 0, "invincible until logical frame")
	flag.Parse()
	rom, _ := os.ReadFile(*romPath)

	ign := make([]bool, 0x20000)
	for _, r := range strings.Split(*ignore, ",") {
		p := strings.Split(r, "-")
		a, _ := strconv.ParseUint(p[0], 16, 32)
		b := a
		if len(p) > 1 {
			b, _ = strconv.ParseUint(p[1], 16, 32)
		}
		for i := a; i <= b; i++ {
			ign[i] = true
		}
	}
	inputs := map[int]uint16{}
	for _, p := range strings.Split(*script, ",") {
		if p == "" {
			continue
		}
		kv := strings.Split(p, ":")
		f, _ := strconv.Atoi(kv[0])
		v, _ := strconv.ParseUint(kv[1], 16, 16)
		inputs[f] = uint16(v)
	}

	o := oracle.NewSystem(rom)
	pd := rom
	if *portData != "" {
		pd, _ = os.ReadFile(*portData)
	}
	var syms map[string]uint32
	if *symsPath != "" {
		syms = loadSyms(*symsPath)
	}
	m := recomp.New(pd, syms)
	bch, goch := make(chan struct{}), make(chan struct{})
	m.OnBoundary = func() { bch <- struct{}{}; <-goch }
	go func() {
		defer func() {
			if r := recover(); r != nil {
				fmt.Println("PORT PANIC:", r)
				os.Exit(1)
			}
		}()
		m.Run()
	}()

	var joy uint16
	diffs := 0
	ppuDiffFrames := 0
	for f := 0; f < *n; f++ {
		if !o.StepUntilNext(0x0083C3, 600) {
			fmt.Println("oracle: no boundary", f)
			return
		}
		<-bch
		// inputs for the next logical frame, set while both sides are paused
		if v, ok := inputs[f+1]; ok {
			joy = v
		}
		o.Joy1, m.Joy1 = joy, joy
		if *botFrom > 0 && f >= *botFrom {
			j := bot.Input(o.WRAM[:], f)
			o.Joy1, m.Joy1 = j, j
			for _, w := range [][]byte{o.WRAM[:], m.WRAM[:]} {
				if f < *godUntil && w[0x0ED6] == 0 {
					w[0x0ED6] = 2
				}
				if f < *godUntil && w[0x0ED6] == 2 {
					w[0x0EDC], w[0x0EDD] = 0, 1
				}
			}
		}
		// compare WRAM
		var bad []string
		for i := 0; i < 0x20000; i++ {
			if ign[i] {
				continue
			}
			if o.WRAM[i] != m.WRAM[i] {
				bad = append(bad, fmt.Sprintf("%05X:%02X/%02X", i, o.WRAM[i], m.WRAM[i]))
			}
		}
		pv, pc, po := 0, 0, 0
		for i := range o.PPU.VRAM {
			if o.PPU.VRAM[i] != m.PPU.VRAM[i] {
				pv++
			}
		}
		for i := range o.PPU.CGRAM {
			if o.PPU.CGRAM[i] != m.PPU.CGRAM[i] {
				pc++
			}
		}
		for i := range o.PPU.OAM {
			if o.PPU.OAM[i] != m.PPU.OAM[i] {
				po++
			}
		}
		if pv+pc+po > 0 {
			ppuDiffFrames++
			if ppuDiffFrames <= 5 || f%1000 == 0 {
				fmt.Printf("frame %d: PPU diffs vram=%d cgram=%d oam=%d\n", f, pv, pc, po)
			}
		}
		if len(bad) > 0 {
			diffs++
			if len(bad) > 40 {
				bad = append(bad[:40], fmt.Sprintf("...(%d)", len(bad)))
			}
			fmt.Printf("frame %d: oracle PC %02X:%04X  %d WRAM diffs: %s\n", f, o.CPU.PB, o.CPU.PC, len(bad), strings.Join(bad, " "))
			if diffs >= *maxDiff {
				return
			}
		}
		goch <- struct{}{}
	}
	fmt.Println("no WRAM differences for", *n, "frames; frames with PPU memory differences:", ppuDiffFrames)
}

func loadSyms(path string) map[string]uint32 {
	b, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}
	var raw map[string]string
	if err := json.Unmarshal(b, &raw); err != nil {
		panic(err)
	}
	syms := map[string]uint32{}
	for k, v := range raw {
		var bk, a uint32
		fmt.Sscanf(v, "%x:%x", &bk, &a)
		syms[k] = bk<<16 | a
	}
	return syms
}
