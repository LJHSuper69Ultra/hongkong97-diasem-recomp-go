// shot runs the game headless on a data image and saves chosen frames as
// PNG files: a quick way to see the effect of an asset change.
//
//	go run ./tools/shot -data cmd/hk97/romdata.bin -in "130:0400,138:0,150:0400,158:0,170:0080,178:0" -at 600,900
package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"os"
	"strconv"
	"strings"

	"hk97/apu"
	"hk97/recomp"
)

func main() {
	data := flag.String("data", "cmd/hk97/romdata.bin", "data image")
	symsPath := flag.String("syms", "", "asset address table (default: <data without .bin>syms.json)")
	script := flag.String("in", "", "input: frame:hexmask,...")
	at := flag.String("at", "", "frames to save, comma separated")
	out := flag.String("o", "shots", "output directory")
	wav := flag.String("wav", "", "also record the sound to this WAV file")
	spcAt := flag.Int("spc", -1, "save the sound state as an .spc file at this frame (-2: at the game's first sound command)")
	flag.Parse()
	img, err := os.ReadFile(*data)
	if err != nil {
		panic(err)
	}
	inputs := map[int]uint16{}
	for _, p := range strings.Split(*script, ",") {
		if kv := strings.Split(p, ":"); len(kv) == 2 {
			f, _ := strconv.Atoi(kv[0])
			v, _ := strconv.ParseUint(kv[1], 16, 16)
			inputs[f] = uint16(v)
		}
	}
	want, last := map[int]bool{}, 0
	for _, s := range strings.Split(*at, ",") {
		if f, err := strconv.Atoi(s); err == nil {
			want[f] = true
			if f > last {
				last = f
			}
		}
	}
	os.MkdirAll(*out, 0o755)
	if *symsPath == "" {
		*symsPath = strings.TrimSuffix(*data, ".bin") + "syms.json"
	}
	sb, err := os.ReadFile(*symsPath)
	if err != nil {
		panic(err)
	}
	var raw map[string]string
	if err := json.Unmarshal(sb, &raw); err != nil {
		panic(err)
	}
	syms := map[string]uint32{}
	for k, v := range raw {
		var b, a uint32
		fmt.Sscanf(v, "%x:%x", &b, &a)
		syms[k] = b<<16 | a
	}
	m := recomp.New(img, syms)
	snd := apu.New()
	m.HW.APU = snd
	cmdSnap := false
	if *spcAt == -2 { // snapshot at the first command the game sends
		snd.OnCommand = func(p int, v uint8) {
			if !cmdSnap {
				cmdSnap = true
				os.WriteFile(*out+"/snapshot.spc", snd.SnapshotSPC(), 0o644)
				snd.ResetOutput()
			}
		}
	}
	var pcm []int16
	started := false
	frame := 0
	var joy uint16
	done := make(chan struct{})
	m.Frame = func() {
		if frame == *spcAt {
			os.WriteFile(*out+"/snapshot.spc", snd.SnapshotSPC(), 0o644)
			pcm = pcm[:0] // the recording starts at the snapshot
		}
		f := snd.Frame()
		if cmdSnap && !started {
			started = true
			pcm = pcm[:0]
			f = snd.SinceReset()
		}
		pcm = append(pcm, f...)
		if want[frame] {
			m.PPU.Render()
			pic := image.NewRGBA(image.Rect(0, 0, 256, 224))
			for i, c := range m.PPU.Frame {
				pic.Set(i%256, i/256, color.RGBA{uint8(c >> 16), uint8(c >> 8), uint8(c), 255})
			}
			f, _ := os.Create(fmt.Sprintf("%s/frame%05d.png", *out, frame))
			png.Encode(f, pic)
			f.Close()
		}
		if frame >= last {
			if *wav != "" {
				writeWAV(*wav, pcm)
			}
			close(done)
			select {}
		}
		frame++
		if v, ok := inputs[frame]; ok {
			joy = v
		}
		m.Joy1 = joy
	}
	go m.Run()
	<-done
}

func writeWAV(path string, pcm []int16) {
	f, err := os.Create(path)
	if err != nil {
		panic(err)
	}
	defer f.Close()
	n := len(pcm) * 2
	le32 := func(v int) []byte { return []byte{byte(v), byte(v >> 8), byte(v >> 16), byte(v >> 24)} }
	f.Write([]byte("RIFF"))
	f.Write(le32(36 + n))
	f.Write([]byte("WAVEfmt "))
	f.Write(le32(16))
	f.Write([]byte{1, 0, 2, 0})
	f.Write(le32(apu.SampleRate))
	f.Write(le32(apu.SampleRate * 4))
	f.Write([]byte{4, 0, 16, 0})
	f.Write([]byte("data"))
	f.Write(le32(n))
	b := make([]byte, n)
	for i, v := range pcm {
		b[2*i], b[2*i+1] = byte(v), byte(uint16(v)>>8)
	}
	f.Write(b)
}
