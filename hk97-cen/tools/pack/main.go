// pack builds the game's data image from the asset files.
//
//	go run ./tools/pack -assets assets -o cmd/hk97/romdata.bin
//
// With -verify ROM it also checks the result against an original ROM:
// every data byte must match, compressed blocks must decompress to the
// same bytes, and only code (which lives in recomp/) may differ.
package main

import (
	"bufio"
	"bytes"
	"flag"
	"fmt"
	"os"
	"strings"

	af "hk97/assetfmt"
)

func main() {
	dir := flag.String("assets", "assets", "assets directory")
	out := flag.String("o", "romdata.bin", "output data image")
	symsOut := flag.String("syms", "", "output asset address table (default: <o without .bin>syms.json)")
	verify := flag.String("verify", "", "original ROM to compare against (optional)")
	codemap := flag.String("codemap", "recomp/codemap.txt", "code byte ranges of the original program")
	flag.Parse()
	ranges, err := readCodemap(*codemap)
	if err != nil {
		fmt.Fprintln(os.Stderr, "pack:", err)
		os.Exit(1)
	}
	lay, m, err := af.Pack(*dir, ranges)
	if err != nil {
		fmt.Fprintln(os.Stderr, "pack:", err)
		os.Exit(1)
	}
	img := lay.Image
	if *symsOut == "" {
		*symsOut = strings.TrimSuffix(*out, ".bin") + "syms.json"
	}
	syms := map[string]string{}
	for k, v := range lay.Addr {
		syms[k] = v.String()
	}
	if err := af.WriteJSON(*symsOut, syms); err != nil {
		fmt.Fprintln(os.Stderr, "pack:", err)
		os.Exit(1)
	}
	if err := os.WriteFile(*out, img, 0o644); err != nil {
		fmt.Fprintln(os.Stderr, "pack:", err)
		os.Exit(1)
	}
	fmt.Printf("pack: %d assets -> %s (+ %s), %d bytes free\n", len(m.Items), *out, *symsOut, lay.Free)
	for _, mv := range lay.Moved {
		fmt.Println("  moved", mv)
	}
	if *verify != "" {
		if err := verifyAgainst(img, lay, m, *dir, *verify); err != nil {
			fmt.Fprintln(os.Stderr, "verify:", err)
			os.Exit(1)
		}
	}
}

func readCodemap(path string) ([][2]int, error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer f.Close()
	var r [][2]int
	sc := bufio.NewScanner(f)
	for sc.Scan() {
		if l := sc.Text(); !strings.HasPrefix(l, "#") {
			var a, b int
			if n, _ := fmt.Sscanf(l, "%x %x", &a, &b); n == 2 {
				r = append(r, [2]int{a, b})
			}
		}
	}
	return r, sc.Err()
}

func verifyAgainst(img []byte, lay *af.Layout, m *af.Manifest, dir, romPath string) error {
	rom, err := os.ReadFile(romPath)
	if err != nil {
		return err
	}
	if len(rom)%0x400 == 0x200 {
		rom = rom[0x200:]
	}
	// Every original asset is compared with the ROM: compressed ones after
	// decompression, the rest byte for byte (at wherever pack put it).
	same, nlz := 0, 0
	var changed []string
	for _, it := range m.Items {
		if it.New {
			continue
		}
		o, p := it.Addr.Offset(), lay.Addr[it.Name].Offset()
		if it.Compressed() {
			a, _, err := af.Decompress(img[p:])
			if err != nil {
				return fmt.Errorf("%s: %v", it.Name, err)
			}
			b, _, err := af.Decompress(rom[o:])
			if err != nil {
				return fmt.Errorf("%s (original): %v", it.Name, err)
			}
			if !bytes.Equal(a, b) {
				changed = append(changed, it.Name)
				continue
			}
			nlz++
			same += len(b)
			continue
		}
		enc, err := af.EncodeItem(dir, it)
		if err != nil {
			return err
		}
		n := len(enc)
		if !bytes.Equal(img[p:p+n], rom[o:o+n]) {
			changed = append(changed, it.Name)
			continue
		}
		same += n
	}
	fmt.Printf("verify: %d original assets identical to the ROM (%d compressed blocks compared after decompression, %d bytes)\n", len(m.Items)-len(changed)-countNew(m), nlz, same)
	if len(changed) > 0 {
		fmt.Printf("verify: %d edited assets differ from the original: %s\n", len(changed), strings.Join(changed, ", "))
	}
	return nil
}

func countNew(m *af.Manifest) int {
	n := 0
	for _, it := range m.Items {
		if it.New {
			n++
		}
	}
	return n
}
