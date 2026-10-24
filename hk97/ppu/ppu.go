// Package ppu is a small SNES PPU model: VRAM/CGRAM/OAM plus the registers
// Hong Kong 97 uses, and a scanline-free renderer for BG mode 1 + sprites
// with basic colour math and master brightness.
package ppu

const W, H = 256, 224

type PPU struct {
	VRAM  [0x8000]uint16
	CGRAM [256]uint16
	OAM   [544]uint8

	// registers
	Inidisp uint8 // b7 forced blank, b0-3 brightness
	Obsel   uint8
	Bgmode  uint8
	BgSC    [4]uint8
	Bg12nba uint8
	Bg34nba uint8
	HOfs    [4]uint16
	VOfs    [4]uint16
	TM, TS  uint8
	Cgwsel  uint8
	Cgadsub uint8
	FixedR  uint8
	FixedG  uint8
	FixedB  uint8

	// register-port state
	VAddr    uint16
	VMain    uint8
	vReadBuf uint16
	CGAddr   uint16 // byte address 0..511
	cgLatch  uint8
	OAMAddr  uint16
	oamLatch uint8
	ofsLatch uint8
	hofsPrev uint8

	Frame [W * H]uint32 // 0xAARRGGBB
}

func New() *PPU { return &PPU{Inidisp: 0x80} }

// ---------------- register writes (CPU side) ----------------

func (p *PPU) vinc() uint16 {
	switch p.VMain & 3 {
	case 0:
		return 1
	case 1:
		return 32
	default:
		return 128
	}
}

func (p *PPU) Write(reg uint16, v uint8) {
	switch reg {
	case 0x2100:
		p.Inidisp = v
	case 0x2101:
		p.Obsel = v
	case 0x2102:
		p.OAMAddr = (p.OAMAddr & 0x200) | uint16(v)<<1
	case 0x2103:
		p.OAMAddr = (p.OAMAddr & 0x1FE) | uint16(v&1)<<9
	case 0x2104:
		a := p.OAMAddr & 0x3FF
		if a >= 0x200 {
			if int(a-0x200+0x200) < len(p.OAM) {
				p.OAM[0x200+(a&0x1F)] = v
			}
		} else if a&1 == 0 {
			p.oamLatch = v
		} else {
			p.OAM[a-1] = p.oamLatch
			p.OAM[a] = v
		}
		p.OAMAddr = (p.OAMAddr + 1) & 0x3FF
	case 0x2105:
		p.Bgmode = v
	case 0x2107, 0x2108, 0x2109, 0x210A:
		p.BgSC[reg-0x2107] = v
	case 0x210B:
		p.Bg12nba = v
	case 0x210C:
		p.Bg34nba = v
	case 0x210D, 0x210F, 0x2111, 0x2113:
		i := (reg - 0x210D) / 2
		p.HOfs[i] = (uint16(v)<<8 | uint16(p.ofsLatch&^7) | uint16(p.hofsPrev&7)) & 0x3FF
		p.ofsLatch = v
		p.hofsPrev = v
	case 0x210E, 0x2110, 0x2112, 0x2114:
		i := (reg - 0x210E) / 2
		p.VOfs[i] = (uint16(v)<<8 | uint16(p.ofsLatch)) & 0x3FF
		p.ofsLatch = v
	case 0x2115:
		p.VMain = v
	case 0x2116:
		p.VAddr = p.VAddr&0xFF00 | uint16(v)
		p.vReadBuf = p.VRAM[p.VAddr&0x7FFF]
	case 0x2117:
		p.VAddr = p.VAddr&0x00FF | uint16(v)<<8
		p.vReadBuf = p.VRAM[p.VAddr&0x7FFF]
	case 0x2118:
		a := p.VAddr & 0x7FFF
		p.VRAM[a] = p.VRAM[a]&0xFF00 | uint16(v)
		if p.VMain&0x80 == 0 {
			p.VAddr += p.vinc()
		}
	case 0x2119:
		a := p.VAddr & 0x7FFF
		p.VRAM[a] = p.VRAM[a]&0x00FF | uint16(v)<<8
		if p.VMain&0x80 != 0 {
			p.VAddr += p.vinc()
		}
	case 0x2121:
		p.CGAddr = uint16(v) << 1
	case 0x2122:
		if p.CGAddr&1 == 0 {
			p.cgLatch = v
		} else {
			p.CGRAM[(p.CGAddr>>1)&0xFF] = (uint16(v)<<8 | uint16(p.cgLatch)) & 0x7FFF
		}
		p.CGAddr = (p.CGAddr + 1) & 0x1FF
	case 0x212C:
		p.TM = v
	case 0x212D:
		p.TS = v
	case 0x2130:
		p.Cgwsel = v
	case 0x2131:
		p.Cgadsub = v
	case 0x2132:
		in := v & 0x1F
		if v&0x20 != 0 {
			p.FixedR = in
		}
		if v&0x40 != 0 {
			p.FixedG = in
		}
		if v&0x80 != 0 {
			p.FixedB = in
		}
	}
}

func (p *PPU) Read(reg uint16) uint8 {
	switch reg {
	case 0x2139:
		v := uint8(p.vReadBuf)
		if p.VMain&0x80 == 0 {
			p.vReadBuf = p.VRAM[p.VAddr&0x7FFF]
			p.VAddr += p.vinc()
		}
		return v
	case 0x213A:
		v := uint8(p.vReadBuf >> 8)
		if p.VMain&0x80 != 0 {
			p.vReadBuf = p.VRAM[p.VAddr&0x7FFF]
			p.VAddr += p.vinc()
		}
		return v
	}
	return 0
}

// ---------------- rendering ----------------

type pix struct {
	color  uint16
	layer  uint8 // 0..3 BG, 4 OBJ, 5 backdrop
	opaque bool
	objPal bool // OBJ palette 4-7 (participates in colour math)
}

var sizeTab = [8][2][2]int{
	{{8, 8}, {16, 16}}, {{8, 8}, {32, 32}}, {{8, 8}, {64, 64}}, {{16, 16}, {32, 32}},
	{{16, 16}, {64, 64}}, {{32, 32}, {64, 64}}, {{16, 32}, {32, 64}}, {{16, 32}, {32, 32}},
}

// bgPixel returns colour index (0 = transparent), palette base and priority.
func (p *PPU) bgPixel(bg int, bpp int, x, y int) (uint16, bool, uint8) {
	sc := p.BgSC[bg]
	mapBase := uint16(sc&0xFC) << 8
	hx := (x + int(p.HOfs[bg])) & 0x3FF
	vy := (y + int(p.VOfs[bg])) & 0x3FF
	tx, ty := hx>>3, vy>>3
	off := uint16(0)
	if tx >= 32 && sc&1 != 0 {
		off += 0x400
	}
	if ty >= 32 && sc&2 != 0 {
		if sc&1 != 0 {
			off += 0x800
		} else {
			off += 0x400
		}
	}
	entry := p.VRAM[(mapBase+off+uint16((ty&31)*32+(tx&31)))&0x7FFF]
	tile := entry & 0x3FF
	pal := (entry >> 10) & 7
	prio := uint8(entry>>13) & 1
	fx, fy := hx&7, vy&7
	if entry&0x4000 != 0 {
		fx = 7 - fx
	}
	if entry&0x8000 != 0 {
		fy = 7 - fy
	}
	var chrBase uint16
	switch bg {
	case 0:
		chrBase = uint16(p.Bg12nba&0xF) << 12
	case 1:
		chrBase = uint16(p.Bg12nba>>4) << 12
	case 2:
		chrBase = uint16(p.Bg34nba&0xF) << 12
	default:
		chrBase = uint16(p.Bg34nba>>4) << 12
	}
	words := uint16(bpp * 4)
	a := chrBase + tile*words + uint16(fy)
	bit := uint(7 - fx)
	var ci uint16
	w0 := p.VRAM[a&0x7FFF]
	ci = (w0>>bit)&1 | ((w0>>(bit+8))&1)<<1
	if bpp == 4 {
		w1 := p.VRAM[(a+8)&0x7FFF]
		ci |= ((w1>>bit)&1)<<2 | ((w1>>(bit+8))&1)<<3
	}
	if ci == 0 {
		return 0, false, 0
	}
	if bpp == 2 {
		return p.CGRAM[pal*4+ci], true, prio
	}
	return p.CGRAM[pal*16+ci], true, prio
}

type objLine struct {
	color [W]uint16
	prio  [W]int8 // -1 none
	hiPal [W]bool
}

func (p *PPU) renderObjLine(y int, ol *objLine) {
	for i := range ol.prio {
		ol.prio[i] = -1
	}
	sz := sizeTab[p.Obsel>>5]
	nameBase := uint16(p.Obsel&7) << 13
	nameSel := (uint16(p.Obsel>>3)&3 + 1) << 12
	// lower index = higher priority among sprites; draw from 127 down so 0 wins
	for i := 127; i >= 0; i-- {
		o := p.OAM[i*4 : i*4+4]
		hi := p.OAM[0x200+i/4] >> (uint(i%4) * 2)
		x := int(o[0]) | int(hi&1)<<8
		if x >= 256 {
			x -= 512
		}
		big := int((hi >> 1) & 1)
		w, h := sz[big][0], sz[big][1]
		sy := int(o[1])
		dy := (y - sy) & 0xFF
		if dy >= h {
			continue
		}
		attr := o[3]
		tile := uint16(o[2]) | uint16(attr&1)<<8
		pal := uint16(attr>>1) & 7
		prio := int8(attr>>4) & 3
		if attr&0x80 != 0 {
			dy = h - 1 - dy
		}
		for dx := 0; dx < w; dx++ {
			sx := x + dx
			if sx < 0 || sx >= W {
				continue
			}
			fx := dx
			if attr&0x40 != 0 {
				fx = w - 1 - dx
			}
			t := tile
			col := (uint16(t&0xF) + uint16(fx>>3)) & 0xF
			row := (uint16(t>>4&0xF) + uint16(dy>>3)) & 0xF
			t = t&0x100 | row<<4 | col
			base := nameBase
			if t&0x100 != 0 {
				base += nameSel
			}
			a := base + (t&0xFF)*16 + uint16(dy&7)
			bit := uint(7 - fx&7)
			w0 := p.VRAM[a&0x7FFF]
			w1 := p.VRAM[(a+8)&0x7FFF]
			ci := (w0>>bit)&1 | ((w0>>(bit+8))&1)<<1 | ((w1>>bit)&1)<<2 | ((w1>>(bit+8))&1)<<3
			if ci == 0 {
				continue
			}
			ol.color[sx] = p.CGRAM[128+pal*16+ci]
			ol.prio[sx] = prio
			ol.hiPal[sx] = pal >= 4
		}
	}
}

// screenPixel composes one screen (main or sub) from the enabled-layer mask.
func (p *PPU) screenPixel(mask uint8, x, y int, ol *objLine) pix {
	bg3prio := p.Bgmode&8 != 0
	type cand struct {
		ok   bool
		c    uint16
		prio uint8
	}
	var bgs [3]cand
	bpps := [3]int{4, 4, 2}
	for i := 0; i < 3; i++ {
		if mask&(1<<uint(i)) == 0 {
			continue
		}
		c, ok, pr := p.bgPixel(i, bpps[i], x, y)
		bgs[i] = cand{ok, c, pr}
	}
	objOK := mask&0x10 != 0 && ol.prio[x] >= 0
	op := ol.prio[x]
	pick := func(layer uint8, c uint16) pix {
		return pix{color: c, layer: layer, opaque: true, objPal: layer == 4 && ol.hiPal[x]}
	}
	// mode 1 priority order
	if bg3prio && bgs[2].ok && bgs[2].prio == 1 {
		return pick(2, bgs[2].c)
	}
	if objOK && op == 3 {
		return pick(4, ol.color[x])
	}
	if bgs[0].ok && bgs[0].prio == 1 {
		return pick(0, bgs[0].c)
	}
	if bgs[1].ok && bgs[1].prio == 1 {
		return pick(1, bgs[1].c)
	}
	if objOK && op == 2 {
		return pick(4, ol.color[x])
	}
	if bgs[0].ok && bgs[0].prio == 0 {
		return pick(0, bgs[0].c)
	}
	if bgs[1].ok && bgs[1].prio == 0 {
		return pick(1, bgs[1].c)
	}
	if objOK && op == 1 {
		return pick(4, ol.color[x])
	}
	if !bg3prio && bgs[2].ok && bgs[2].prio == 1 {
		return pick(2, bgs[2].c)
	}
	if objOK && op == 0 {
		return pick(4, ol.color[x])
	}
	if bgs[2].ok && bgs[2].prio == 0 {
		return pick(2, bgs[2].c)
	}
	return pix{color: p.CGRAM[0], layer: 5}
}

func rgb(c uint16) (int, int, int) { return int(c & 31), int(c >> 5 & 31), int(c >> 10 & 31) }

func (p *PPU) Render() {
	bright := int(p.Inidisp & 0xF)
	if p.Inidisp&0x80 != 0 {
		bright = -1
	}
	var ol objLine
	for y := 0; y < H; y++ {
		if bright < 0 {
			for x := 0; x < W; x++ {
				p.Frame[y*W+x] = 0xFF000000
			}
			continue
		}
		line := y + 1                // the SNES shows scanlines 1..224
		p.renderObjLine(line-1, &ol) // OAM Y=n is displayed from line n+1
		for x := 0; x < W; x++ {
			m := p.screenPixel(p.TM, x, line, &ol)
			r, g, b := rgb(m.color)
			layerBit := uint8(0x20)
			if m.layer < 5 {
				layerBit = 1 << m.layer
			}
			doMath := p.Cgadsub&layerBit != 0
			if m.layer == 4 && !m.objPal {
				doMath = false
			}
			if doMath {
				var sr, sg, sb int
				half := p.Cgadsub&0x40 != 0
				if p.Cgwsel&2 != 0 {
					s := p.screenPixel(p.TS, x, line, &ol)
					if s.layer == 5 {
						sr, sg, sb = int(p.FixedR), int(p.FixedG), int(p.FixedB)
						half = false
					} else {
						sr, sg, sb = rgb(s.color)
					}
				} else {
					sr, sg, sb = int(p.FixedR), int(p.FixedG), int(p.FixedB)
				}
				if p.Cgadsub&0x80 != 0 {
					r, g, b = r-sr, g-sg, b-sb
				} else {
					r, g, b = r+sr, g+sg, b+sb
				}
				if half {
					r, g, b = r>>1, g>>1, b>>1
				}
				r, g, b = clamp(r), clamp(g), clamp(b)
			}
			r = r * bright / 15
			g = g * bright / 15
			b = b * bright / 15
			p.Frame[y*W+x] = 0xFF000000 | uint32(expand(r))<<16 | uint32(expand(g))<<8 | uint32(expand(b))
		}
	}
}

func clamp(v int) int {
	if v < 0 {
		return 0
	}
	if v > 31 {
		return 31
	}
	return v
}
func expand(v int) uint8 { return uint8(v<<3 | v>>2) }
