package assetfmt

import (
	"encoding/hex"
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"
)

const ROMSize = 0x80000

// Manifest lists every asset and where its data lives in the game's
// address space. It is the single source of truth for tools/pack.
type Manifest struct {
	Comment string  `json:"comment"`
	Items   []*Item `json:"items"`
}

// Item kinds:
//
//	table       JSON fixed-layout records (see Table)
//	text        UTF-8 text, Renderer "8x8" or "16"
//	sprites     JSON sprite animation bank (see Sprites)
//	font        2bpp tile sheet PNG, 16 tiles wide
//	lz_picture  256x224 indexed PNG = 32x28 tiles in screen order, 4bpp, compressed
//	lz_tiles    indexed PNG tile sheet, 16 tiles wide, 4bpp, compressed
//	lz_tilemap  JSON 32x32 BG tilemap, compressed
//	lz_palette  JSON colour list, compressed
//	spc         JSON list of SPC700 upload blocks (+ .bin files)
//	header      JSON cartridge header and vectors
//	raw         binary file, copied as is
type Item struct {
	Name     string `json:"name"`
	Kind     string `json:"kind"`
	Addr     Addr   `json:"addr,omitempty"`
	Slot     int    `json:"slot,omitempty"`
	File     string `json:"file"`
	Renderer string `json:"renderer,omitempty"`
	Palette  string `json:"preview_palette,omitempty"`
	// Place: "fixed" (must stay at addr), "bank80" (may move within bank $80),
	// "anywhere" (may move to any free space; compressed data). Code refers
	// to movable assets by name, so tools/pack can relocate them.
	Place string `json:"place"`
	// New marks assets that are not in the original game (no original
	// address unless fixed); -verify and the recompiler skip them.
	New bool `json:"new,omitempty"`
	// Chars (font items): glyph list file naming the character of each
	// 16x16 glyph in the sheet (see ReadGlyphList).
	Chars   string `json:"chars,omitempty"`
	Comment string `json:"comment,omitempty"`
}

func (it *Item) Compressed() bool { return strings.HasPrefix(it.Kind, "lz_") }

func LoadManifest(dir string) (*Manifest, error) {
	b, err := os.ReadFile(filepath.Join(dir, "manifest.json"))
	if err != nil {
		return nil, err
	}
	var m Manifest
	if err := json.Unmarshal(b, &m); err != nil {
		return nil, fmt.Errorf("manifest.json: %v", err)
	}
	return &m, nil
}

func readJSON(path string, v any) error {
	b, err := os.ReadFile(path)
	if err != nil {
		return err
	}
	if err := json.Unmarshal(b, v); err != nil {
		return fmt.Errorf("%s: %v", path, err)
	}
	return nil
}

func WriteJSON(path string, v any) error {
	b, err := json.Marshal(v)
	if err != nil {
		return err
	}
	if b, err = PrettyJSON(b, 100); err != nil {
		return err
	}
	return os.WriteFile(path, b, 0o644)
}

// Tilemap file format.
type Tilemap struct {
	Comment string   `json:"comment"`
	Rows    []string `json:"rows"` // 32 rows of 32 hex words "vhopppcc cccccccc"
}

type Palette struct {
	Comment string   `json:"comment"`
	Colors  []string `json:"colors"`
}

type SPC struct {
	Comment string     `json:"comment"`
	Entry   string     `json:"entry"`
	Blocks  []SPCBlock `json:"blocks"`
}

type SPCBlock struct {
	Dest string `json:"dest"`
	File string `json:"file"`
}

type Header struct {
	Comment       string `json:"comment"`
	MakerArea     string `json:"maker_area"`
	Title         string `json:"title"`
	MapMode       string `json:"map_mode"`
	CartType      string `json:"cartridge_type"`
	ROMSize       string `json:"rom_size"`
	RAMSize       string `json:"ram_size"`
	Region        string `json:"region"`
	Developer     string `json:"developer"`
	Version       string `json:"version"`
	ChecksumCompl string `json:"checksum_complement"`
	Checksum      string `json:"checksum"`
	Vectors       string `json:"vectors"`
}

func hexByte(s string) (byte, error) {
	v, err := num(s)
	return byte(v), err
}

// EncodeItem produces the bytes an item contributes (compressed for lz_*).
func EncodeItem(dir string, it *Item) ([]byte, error) {
	path := filepath.Join(dir, it.File)
	var raw []byte
	switch it.Kind {
	case "table":
		var t Table
		if err := readJSON(path, &t); err != nil {
			return nil, err
		}
		b, err := t.Encode()
		if err != nil {
			return nil, fmt.Errorf("%s: %v", it.File, err)
		}
		raw = b
	case "text":
		src, err := os.ReadFile(path)
		if err != nil {
			return nil, err
		}
		b, err := EncodeText(string(src), it.Renderer)
		if err != nil {
			return nil, fmt.Errorf("%s: %v", it.File, err)
		}
		raw = b
	case "sprites":
		var s Sprites
		if err := readJSON(path, &s); err != nil {
			return nil, err
		}
		b, err := s.Encode()
		if err != nil {
			return nil, err
		}
		raw = b
	case "font":
		pix, w, h, err := ReadPNG(path)
		if err != nil {
			return nil, err
		}
		raw = EncodeTiles(pix, w, 2, w/8, (w/8)*(h/8))
	case "lz_picture":
		pix, w, h, err := ReadPNG(path)
		if err != nil {
			return nil, err
		}
		if w != 256 || h != 224 {
			return nil, fmt.Errorf("%s: picture must be 256x224, is %dx%d", it.File, w, h)
		}
		raw = EncodeTiles(pix, w, 4, 32, 32*28)
	case "lz_tiles":
		pix, w, h, err := ReadPNG(path)
		if err != nil {
			return nil, err
		}
		raw = EncodeTiles(pix, w, 4, w/8, (w/8)*(h/8))
	case "lz_tilemap":
		var t Tilemap
		if err := readJSON(path, &t); err != nil {
			return nil, err
		}
		for r, row := range t.Rows {
			for _, f := range strings.Fields(row) {
				v, err := num(f)
				if err != nil {
					return nil, fmt.Errorf("%s row %d: %v", it.File, r, err)
				}
				raw = append(raw, byte(v), byte(v>>8))
			}
		}
	case "lz_palette":
		var p Palette
		if err := readJSON(path, &p); err != nil {
			return nil, err
		}
		for _, c := range p.Colors {
			v, err := ParseColorHex(c)
			if err != nil {
				return nil, fmt.Errorf("%s: %v", it.File, err)
			}
			raw = append(raw, byte(v), byte(v>>8))
		}
	case "spc":
		var s SPC
		if err := readJSON(path, &s); err != nil {
			return nil, err
		}
		for _, bl := range s.Blocks {
			d, err := os.ReadFile(filepath.Join(dir, bl.File))
			if err != nil {
				return nil, err
			}
			dest, err := num(bl.Dest)
			if err != nil {
				return nil, err
			}
			raw = append(raw, byte(len(d)), byte(len(d)>>8), byte(dest), byte(dest>>8))
			raw = append(raw, d...)
		}
		e, err := num(s.Entry)
		if err != nil {
			return nil, err
		}
		raw = append(raw, 0, 0, byte(e), byte(e>>8))
	case "header":
		var h Header
		if err := readJSON(path, &h); err != nil {
			return nil, err
		}
		ma, err := hex.DecodeString(h.MakerArea)
		if err != nil || len(ma) != 16 {
			return nil, fmt.Errorf("header: maker_area must be 16 hex bytes")
		}
		raw = append(raw, ma...)
		t := []byte(h.Title)
		if len(t) > 21 {
			return nil, fmt.Errorf("header: title longer than 21 characters")
		}
		for len(t) < 21 {
			t = append(t, ' ')
		}
		raw = append(raw, t...)
		for _, s := range []string{h.MapMode, h.CartType, h.ROMSize, h.RAMSize, h.Region, h.Developer, h.Version} {
			v, err := hexByte(s)
			if err != nil {
				return nil, err
			}
			raw = append(raw, v)
		}
		for _, s := range []string{h.ChecksumCompl, h.Checksum} {
			v, err := num(s)
			if err != nil {
				return nil, err
			}
			raw = append(raw, byte(v), byte(v>>8))
		}
		vec, err := hex.DecodeString(h.Vectors)
		if err != nil || len(vec) != 32 {
			return nil, fmt.Errorf("header: vectors must be 32 hex bytes")
		}
		raw = append(raw, vec...)
	case "raw":
		b, err := os.ReadFile(path)
		if err != nil {
			return nil, err
		}
		raw = b
	default:
		return nil, fmt.Errorf("%s: unknown kind %q", it.Name, it.Kind)
	}
	if it.Compressed() {
		return Compress(raw), nil
	}
	return raw, nil
}

// Layout is the result of Pack: the data image and each asset's address.
type Layout struct {
	Image []byte
	Addr  map[string]Addr
	Moved []string // assets that did not fit their original slot
	Free  int      // bytes of free space left
}

// Pack builds the game's data image from the assets in dir. Code is not
// part of the image (it lives in recomp/); codeRanges marks the bytes the
// original program occupied, which are never used for data.
func Pack(dir string, codeRanges [][2]int) (*Layout, *Manifest, error) {
	m, err := LoadManifest(dir)
	if err != nil {
		return nil, nil, err
	}
	used := make([]bool, ROMSize)
	for _, r := range codeRanges {
		for i := r[0]; i < r[1] && i < ROMSize; i++ {
			used[i] = true
		}
	}
	out := &Layout{Image: make([]byte, ROMSize), Addr: map[string]Addr{}}
	if err := RegisterFontGlyphs(dir, m); err != nil {
		return nil, nil, err
	}
	enc := make([][]byte, len(m.Items))
	for i, it := range m.Items {
		b, err := EncodeItem(dir, it)
		if err != nil {
			return nil, nil, fmt.Errorf("%s: %v", it.Name, err)
		}
		enc[i] = b
	}
	place := func(it *Item, b []byte, o int) {
		copy(out.Image[o:], b)
		for k := o; k < o+len(b); k++ {
			used[k] = true
		}
		out.Addr[it.Name] = AddrOf(o)
	}
	fits := func(o, n int) bool {
		if o+n > ROMSize {
			return false
		}
		for k := o; k < o+n; k++ {
			if used[k] {
				return false
			}
		}
		return true
	}
	// 1. everything that still fits where it was
	var later []int
	for i, it := range m.Items {
		o := it.Addr.Offset()
		switch {
		case it.New && it.Place != "fixed":
			later = append(later, i) // no original place
		case len(enc[i]) <= it.Slot && fits(o, len(enc[i])):
			place(it, enc[i], o)
		case it.Place == "fixed" || it.Place == "":
			return nil, nil, fmt.Errorf("%s: %d bytes do not fit its %d-byte slot at %s, and it cannot be moved", it.Name, len(enc[i]), it.Slot, it.Addr)
		default:
			later = append(later, i)
		}
	}
	// 2. move the rest into free space (first fit)
	for _, i := range later {
		it, b := m.Items[i], enc[i]
		lo, hi := 0x20000, ROMSize // compressed data: banks $84 and up
		if it.Place == "bank80" {
			lo, hi = 0, 0x8000
		}
		found := -1
		for o := lo; o+len(b) <= hi; o++ {
			if fits(o, len(b)) {
				found = o
				break
			}
		}
		if found < 0 {
			return nil, nil, fmt.Errorf("%s: no free space for %d bytes", it.Name, len(b))
		}
		place(it, b, found)
		if it.New {
			continue
		}
		out.Moved = append(out.Moved, fmt.Sprintf("%s: %s -> %s", it.Name, it.Addr, AddrOf(found)))
	}
	for _, u := range used {
		if !u {
			out.Free++
		}
	}
	return out, m, nil
}

var registered = map[string]bool{}

// RegisterFontGlyphs adds the glyphs listed by font items (Chars) to the
// 16x16 character table, so text can use them.
func RegisterFontGlyphs(dir string, m *Manifest) error {
	for _, it := range m.Items {
		if it.Chars == "" || registered[filepath.Join(dir, it.Chars)] {
			continue
		}
		src, err := os.ReadFile(filepath.Join(dir, it.Chars))
		if err != nil {
			return err
		}
		first, chars, err := ReadGlyphList(string(src))
		if err != nil {
			return fmt.Errorf("%s: %v", it.Chars, err)
		}
		if err := RegisterGlyphs(first, chars); err != nil {
			return fmt.Errorf("%s: %v", it.Chars, err)
		}
		registered[filepath.Join(dir, it.Chars)] = true
	}
	return nil
}
