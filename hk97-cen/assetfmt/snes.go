package assetfmt

import (
	"bytes"
	"encoding/hex"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"os"
	"strings"
)

// ---------------------------------------------------------------- tiles ---

// DecodeTiles turns SNES planar tiles (bpp 2 or 4) into one colour index
// per pixel, laid out as a sheet `cols` tiles wide.
func DecodeTiles(data []byte, bpp, cols int) (pix []uint8, w, h int) {
	tb := 8 * bpp
	n := len(data) / tb
	rows := (n + cols - 1) / cols
	w, h = cols*8, rows*8
	pix = make([]uint8, w*h)
	for t := 0; t < n; t++ {
		tx, ty := t%cols*8, t/cols*8
		d := data[t*tb:]
		for y := 0; y < 8; y++ {
			for x := 0; x < 8; x++ {
				bit := uint(7 - x)
				v := (d[2*y]>>bit)&1 | (d[2*y+1]>>bit&1)<<1
				if bpp == 4 {
					v |= (d[16+2*y]>>bit&1)<<2 | (d[16+2*y+1]>>bit&1)<<3
				}
				pix[(ty+y)*w+tx+x] = v
			}
		}
	}
	return pix, w, h
}

// EncodeTiles is the inverse of DecodeTiles for `n` tiles.
func EncodeTiles(pix []uint8, w, bpp, cols, n int) []byte {
	tb := 8 * bpp
	out := make([]byte, n*tb)
	mask := uint8(1<<uint(bpp) - 1)
	for t := 0; t < n; t++ {
		tx, ty := t%cols*8, t/cols*8
		d := out[t*tb:]
		for y := 0; y < 8; y++ {
			for x := 0; x < 8; x++ {
				v := pix[(ty+y)*w+tx+x] & mask
				bit := uint(7 - x)
				d[2*y] |= (v & 1) << bit
				d[2*y+1] |= (v >> 1 & 1) << bit
				if bpp == 4 {
					d[16+2*y] |= (v >> 2 & 1) << bit
					d[16+2*y+1] |= (v >> 3 & 1) << bit
				}
			}
		}
	}
	return out
}

// --------------------------------------------------------------- colours ---

// BGR555 <-> "#RRGGBB" (each 5-bit channel expanded as c<<3|c>>2, so the
// conversion is exact in both directions).
func ColorHex(c uint16) string {
	r, g, b := c&31, c>>5&31, c>>10&31
	return fmt.Sprintf("#%02X%02X%02X", r<<3|r>>2, g<<3|g>>2, b<<3|b>>2)
}

func ParseColorHex(s string) (uint16, error) {
	s = strings.TrimPrefix(strings.TrimSpace(s), "#")
	b, err := hex.DecodeString(s)
	if err != nil || len(b) != 3 {
		return 0, fmt.Errorf("bad colour %q", s)
	}
	r, g, bl := uint16(b[0]>>3), uint16(b[1]>>3), uint16(b[2]>>3)
	return r | g<<5 | bl<<10, nil
}

func RGBA(c uint16) color.RGBA {
	r, g, b := uint8(c&31), uint8(c>>5&31), uint8(c>>10&31)
	return color.RGBA{r<<3 | r>>2, g<<3 | g>>2, b<<3 | b>>2, 255}
}

// ------------------------------------------------------------------- png ---

// WritePNG saves an indexed image. pal is padded to 256 entries when
// shorter, so any pixel value is representable.
func WritePNG(path string, pix []uint8, w, h int, pal []color.Color) error {
	p := make(color.Palette, 0, 256)
	p = append(p, pal...)
	for len(p) < 256 {
		p = append(p, color.RGBA{255, 0, 255, 255})
	}
	img := &image.Paletted{Pix: pix, Stride: w, Rect: image.Rect(0, 0, w, h), Palette: p}
	var buf bytes.Buffer
	if err := (&png.Encoder{CompressionLevel: png.BestCompression}).Encode(&buf, img); err != nil {
		return err
	}
	return os.WriteFile(path, buf.Bytes(), 0o644)
}

// ReadPNG loads an indexed (palette) PNG and returns its pixel indices.
func ReadPNG(path string) ([]uint8, int, int, error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, 0, 0, err
	}
	defer f.Close()
	img, err := png.Decode(f)
	if err != nil {
		return nil, 0, 0, fmt.Errorf("%s: %v", path, err)
	}
	p, ok := img.(*image.Paletted)
	if !ok {
		return nil, 0, 0, fmt.Errorf("%s: must be an indexed-colour (palette) PNG", path)
	}
	b := p.Bounds()
	w, h := b.Dx(), b.Dy()
	pix := make([]uint8, w*h)
	for y := 0; y < h; y++ {
		copy(pix[y*w:], p.Pix[(y)*p.Stride:(y)*p.Stride+w])
	}
	return pix, w, h, nil
}

// -------------------------------------------------------------- addresses ---

// Addr is a LoROM CPU address such as "84:A829".
type Addr uint32

func (a Addr) String() string { return fmt.Sprintf("%02X:%04X", uint32(a)>>16, uint32(a)&0xFFFF) }

func (a Addr) Offset() int { return int(uint32(a)>>16&0x7F)*0x8000 + int(uint32(a)&0x7FFF) }

func AddrOf(off int) Addr { return Addr(uint32(0x80+off/0x8000)<<16 | uint32(0x8000+off%0x8000)) }

func ParseAddr(s string) (Addr, error) {
	var b, a uint32
	if _, err := fmt.Sscanf(s, "%x:%x", &b, &a); err != nil {
		return 0, fmt.Errorf("bad address %q", s)
	}
	return Addr(b<<16 | a), nil
}

func (a Addr) MarshalText() ([]byte, error) { return []byte(a.String()), nil }
func (a *Addr) UnmarshalText(b []byte) error {
	v, err := ParseAddr(string(b))
	*a = v
	return err
}
