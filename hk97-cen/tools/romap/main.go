// romap runs the reference emulator through several scripted sessions and
// records how every ROM byte is used: executed as code, read as data by the
// CPU (and by which instruction), or streamed by DMA. It also logs every call
// of the decompressor ($80:9DA6) with source, destination and extent.
package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"sort"

	"hk97/internal/bot"
	"hk97/oracle"
)

type decomp struct {
	Src, Dst, End uint32
	Size          int
	Caller        uint32
}

type result struct {
	Usage   []byte            `json:"-"`
	Readers map[int][]uint32  `json:"-"`
	Decomp  map[uint32]decomp `json:"-"`
}

func romOff(a uint32) (int, bool) {
	bank, lo := (a>>16)&0xFF, a&0xFFFF
	if bank == 0x7E || bank == 0x7F {
		return 0, false
	}
	if bank&0x40 == 0 && lo < 0x8000 {
		return 0, false
	}
	return int(bank&0x7F)*0x8000 + int(lo&0x7FFF), true
}

func main() {
	romPath := flag.String("rom", "", "rom")
	out := flag.String("o", "romap.json", "output")
	flag.Parse()
	rom, _ := os.ReadFile(*romPath)
	usage := make([]byte, len(rom))
	readers := map[int]map[uint32]bool{}
	decs := map[uint32]decomp{}
	dmaq := map[string]bool{}

	scenario := func(lang int, attract int, play int, god int) {
		s := oracle.NewSystem(rom)
		var cur decomp
		s.CPU.OnRead = func(a uint32, fetch bool) {
			o, ok := romOff(a)
			if !ok || o >= len(rom) {
				return
			}
			if fetch {
				usage[o] |= 1
			} else {
				usage[o] |= 2
				pc := s.CPU.InstrPC & 0x7FFFFF
				if readers[o] == nil {
					readers[o] = map[uint32]bool{}
				}
				readers[o][pc] = true
			}
		}
		s.HW.OnDMARead = func(a uint32) {
			if o, ok := romOff(a); ok && o < len(rom) {
				usage[o] |= 4
			}
		}
		s.TraceExec = func(pc uint32) {
			switch pc & 0x7FFFFF {
			case 0x009DA6:
				w := s.WRAM[:]
				cur = decomp{
					Src:    uint32(w[0x0E])<<16 | uint32(w[0x0C]) | uint32(w[0x0D])<<8,
					Dst:    uint32(w[0x11])<<16 | uint32(w[0x0F]) | uint32(w[0x10])<<8,
					Caller: uint32(s.WRAM[uint32(s.CPU.S)+1]) | uint32(s.WRAM[uint32(s.CPU.S)+2])<<8,
				}
				cur.Size = int(s.Read(cur.Src)) | int(s.Read(cur.Src+1))<<8
			case 0x0082ED:
				w := s.WRAM[:]
				q := fmt.Sprintf("mode=%02X vmain=%02X reg=21%02X src=%02X:%02X%02X vram=%02X%02X size=%02X%02X last=%06X caller=%04X",
					w[0x29], w[0x2A], w[0x2B], w[0x2C], w[0x2E], w[0x2D], w[0x30], w[0x2F], w[0x32], w[0x31], cur.Src&0x7FFFFF,
					uint32(s.WRAM[uint32(s.CPU.S)+1])|uint32(s.WRAM[uint32(s.CPU.S)+2])<<8)
				dmaq[q] = true
			case 0x009DBA:
				w := s.WRAM[:]
				cur.End = uint32(w[0x0E])<<16 | uint32(w[0x0C]) | uint32(w[0x0D])<<8
				decs[cur.Src&0x7FFFFF] = cur
			}
		}
		// language select: move down `lang` times, confirm with A
		script := map[int]uint16{}
		f := 130
		for i := 0; i < lang; i++ {
			script[f], script[f+8] = 0x0400, 0
			f += 20
		}
		script[f], script[f+8] = 0x0080, 0
		total := f + 40 + attract + play
		for fr := 0; fr < total; fr++ {
			if v, ok := script[fr]; ok {
				s.Joy1 = v
			}
			if fr >= f+40+attract {
				s.Joy1 = bot.Input(s.WRAM[:], fr)
				if fr < f+40+attract+god {
					if s.WRAM[0x0ED6] == 0 {
						s.WRAM[0x0ED6] = 2
					}
					if s.WRAM[0x0ED6] == 2 {
						s.WRAM[0x0EDC], s.WRAM[0x0EDD] = 0, 1
					}
				}
			}
			s.RunFrame()
		}
		fmt.Printf("scenario lang=%d attract=%d play=%d done\n", lang, attract, play)
	}
	for lang := 0; lang < 3; lang++ {
		scenario(lang, 4000, 0, 0)      // info screens, title, attract loop
		scenario(lang, 0, 12000, 10000) // play through several stages, then die
	}
	scenario(2, 0, 30000, 0) // die repeatedly: every new game uses the next background

	// write results
	type rd struct {
		Off     int      `json:"off"`
		Readers []string `json:"readers"`
	}
	var dl []decomp
	for _, d := range decs {
		dl = append(dl, d)
	}
	sort.Slice(dl, func(i, j int) bool { return dl[i].Src < dl[j].Src })
	rdr := map[string][]string{}
	for o, m := range readers {
		var ps []string
		for pc := range m {
			ps = append(ps, fmt.Sprintf("%06X", pc))
		}
		sort.Strings(ps)
		rdr[fmt.Sprint(o)] = ps
	}
	var ql []string
	for q := range dmaq {
		ql = append(ql, q)
	}
	sort.Strings(ql)
	j, _ := json.Marshal(map[string]any{"usage": usage, "readers": rdr, "decomp": dl, "dma": ql})
	os.WriteFile(*out, j, 0o644)
	fmt.Println("decompress blocks:", len(dl))
}
