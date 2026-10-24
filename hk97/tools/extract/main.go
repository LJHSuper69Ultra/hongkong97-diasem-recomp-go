// extract turns a Hong Kong 97 ROM into this project's asset files
// (assets/manifest.json plus PNG/JSON/text/binary files). It is a one-time
// tool: the game is built from the assets, not from the ROM.
//
//	go run ./tools/extract -rom hongkong97.sfc -o assets
package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"flag"
	"fmt"
	"image/color"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"strings"

	af "hk97/assetfmt"
)

var (
	rom []byte
	out string
	man = &af.Manifest{Comment: "Every piece of Hong Kong 97 data, where it lives in the game's address space, and the file it is built from. tools/pack reads this. 'slot' is the space reserved at 'addr'; an edited asset must still fit."}
)

func r8(a uint32) int  { return int(rom[af.Addr(a).Offset()]) }
func r16(a uint32) int { o := af.Addr(a).Offset(); return int(rom[o]) | int(rom[o+1])<<8 }
func bytesAt(a uint32, n int) []byte {
	o := af.Addr(a).Offset()
	return rom[o : o+n]
}

func must(err error) {
	if err != nil {
		fmt.Fprintln(os.Stderr, "extract:", err)
		os.Exit(1)
	}
}

func path(rel string) string {
	p := filepath.Join(out, rel)
	must(os.MkdirAll(filepath.Dir(p), 0o755))
	return p
}

func add(it *af.Item) { man.Items = append(man.Items, it) }

// ------------------------------------------------------------------ tables ---

func table(name, file string, addr uint32, comment string, fields [][2]string, n int, term []byte) {
	sz := 0
	for _, f := range fields {
		if f[1] == "u16" || f[1] == "s16" || f[1] == "x16" {
			sz += 2
		} else {
			sz++
		}
	}
	total := sz*n + len(term)
	t, err := af.DecodeTable(bytesAt(addr, total), comment, fields, n, term)
	must(err)
	if !bytes.Equal(bytesAt(addr+uint32(sz*n), len(term)), term) {
		must(fmt.Errorf("%s: terminator mismatch", name))
	}
	must(af.WriteJSON(path(file), t))
	add(&af.Item{Name: name, Kind: "table", Addr: af.Addr(addr), Slot: total, File: file})
}

// columnTable: parallel arrays (one array per field), stored as rows.
func columnTable(name, file string, addr uint32, comment string, fields []string, n int) {
	t := &af.Table{Comment: comment, Layout: "columns"}
	for _, f := range fields {
		t.Fields = append(t.Fields, [2]string{f, "x8"})
	}
	for i := 0; i < n; i++ {
		row := map[string]any{}
		for k, f := range fields {
			row[f] = fmt.Sprintf("0x%02X", r8(addr+uint32(k*n+i)))
		}
		t.Rows = append(t.Rows, row)
	}
	must(af.WriteJSON(path(file), t))
	add(&af.Item{Name: name, Kind: "table", Addr: af.Addr(addr), Slot: n * len(fields), File: file})
}

// ------------------------------------------------------------------- text ---

func text(name, file string, addr uint32, renderer, comment string) {
	o := af.Addr(addr).Offset()
	s, n, err := af.DecodeText(rom[o:], renderer)
	must(err)
	hdr := "# " + comment + "\n# Each line: @x,y text   (x,y in 8-pixel tiles).\n"
	must(os.WriteFile(path(file), []byte(hdr+s), 0o644))
	add(&af.Item{Name: name, Kind: "text", Addr: af.Addr(addr), Slot: n, File: file, Renderer: renderer})
}

// --------------------------------------------------------------- graphics ---

type lzBlock struct {
	addr     uint32
	name     string
	kind     string
	file     string
	palette  string // name of the palette block used for the preview colours
	comment  string
	plain    []byte
	consumed int
}

var blocks = map[string]*lzBlock{}

func lz(addr uint32, name, kind, file, palette, comment string) *lzBlock {
	o := af.Addr(addr).Offset()
	plain, n, err := af.Decompress(rom[o:])
	must(err)
	b := &lzBlock{addr, name, kind, file, palette, comment, plain, n}
	blocks[name] = b
	return b
}

func paletteColors(name string) []uint16 {
	b := blocks[name]
	var c []uint16
	for i := 0; i+1 < len(b.plain); i += 2 {
		c = append(c, uint16(b.plain[i])|uint16(b.plain[i+1])<<8)
	}
	return c
}

// previewPalette builds a 256-entry PNG palette: sub-palette p occupies
// entries p*16..p*16+15. `colors` are placed starting at entry `first`.
func previewPalette(colors []uint16, first int) []color.Color {
	pal := make([]color.Color, 256)
	for i := range pal {
		pal[i] = color.RGBA{0, 0, 0, 255}
	}
	for i, c := range colors {
		if first+i < 256 {
			pal[first+i] = af.RGBA(c)
		}
	}
	return pal
}

func writeBlocks(order []*lzBlock, tileHints map[string][]int) {
	for _, b := range order {
		var err error
		switch b.kind {
		case "lz_palette":
			p := &af.Palette{Comment: b.comment + " Colours are 15-bit (#RRGGBB with 5 significant bits per channel)."}
			for i := 0; i+1 < len(b.plain); i += 2 {
				p.Colors = append(p.Colors, af.ColorHex(uint16(b.plain[i])|uint16(b.plain[i+1])<<8))
			}
			err = af.WriteJSON(path(b.file), p)
		case "lz_tilemap":
			t := &af.Tilemap{Comment: b.comment + " Entry bits: vhopppcc cccccccc (v/h flip, priority, palette, tile)."}
			for r := 0; r < 32; r++ {
				var f []string
				for c := 0; c < 32; c++ {
					i := (r*32 + c) * 2
					f = append(f, fmt.Sprintf("%04X", int(b.plain[i])|int(b.plain[i+1])<<8))
				}
				t.Rows = append(t.Rows, strings.Join(f, " "))
			}
			err = af.WriteJSON(path(b.file), t)
		case "lz_picture", "lz_tiles":
			cols := 16
			if b.kind == "lz_picture" {
				cols = 32
			}
			pix, w, h := af.DecodeTiles(b.plain, 4, cols)
			// sub-palette per tile for nicer previews (ignored by the packer)
			hint := tileHints[b.name]
			for t := 0; t < len(b.plain)/32; t++ {
				p := 0
				if t < len(hint) {
					p = hint[t]
				}
				tx, ty := t%cols*8, t/cols*8
				for y := 0; y < 8; y++ {
					for x := 0; x < 8; x++ {
						pix[(ty+y)*w+tx+x] |= uint8(p << 4)
					}
				}
			}
			colors := paletteColors(b.palette)
			first := 16 // pictures' palettes are loaded at CGRAM 16 ($0BE0)
			if len(colors) >= 128 {
				first = 0
			}
			err = af.WritePNG(path(b.file), pix, w, h, previewPalette(colors, first))
		}
		must(err)
		add(&af.Item{Name: b.name, Kind: b.kind, Addr: af.Addr(b.addr), Slot: b.consumed, File: b.file, Palette: b.palette, Comment: b.comment})
	}
}

// layoutPalettes: sub-palette per screen tile from a $B722 layout list.
func layoutPalettes(addr uint32) []int {
	pal := make([]int, 32*28)
	for a := addr; r16(a) != 0xFFFF; a += 10 {
		x, y, w, h, base := r16(a), r16(a+2), r16(a+4), r16(a+6), r16(a+8)
		for ty := y; ty < y+h && ty < 28; ty++ {
			for tx := x; tx < x+w && tx < 32; tx++ {
				pal[ty*32+tx] = base >> 10 & 7
			}
		}
	}
	return pal
}

func tilemapPalettes(mapName string, ntiles int) []int {
	b := blocks[mapName]
	pal := make([]int, ntiles)
	seen := make([]bool, ntiles)
	for i := 0; i+1 < len(b.plain); i += 2 {
		e := int(b.plain[i]) | int(b.plain[i+1])<<8
		t := e & 0x3FF
		if t < ntiles && !seen[t] {
			pal[t], seen[t] = e>>10&7, true
		}
	}
	return pal
}

// ------------------------------------------------------------------ main ---

func main() {
	romPath := flag.String("rom", "", "Hong Kong 97 ROM (.sfc/.smc)")
	flag.StringVar(&out, "o", "assets", "output directory")
	codemap := flag.String("codemap", "recomp/codemap.txt", "code byte ranges from tools/recompile.py")
	flag.Parse()
	var err error
	rom, err = os.ReadFile(*romPath)
	must(err)
	if len(rom)%0x400 == 0x200 {
		rom = rom[0x200:]
	}
	if len(rom) != af.ROMSize {
		must(fmt.Errorf("unexpected ROM size %d", len(rom)))
	}

	// ---- cartridge header ----
	h := &af.Header{
		Comment:       "Cartridge header ($80:FFB0-FFFF). Interrupt vectors are listed for completeness; the recompiled game does not use them.",
		MakerArea:     fmt.Sprintf("%X", bytesAt(0x80FFB0, 16)),
		Title:         strings.TrimRight(string(bytesAt(0x80FFC0, 21)), " "),
		MapMode:       fmt.Sprintf("0x%02X", r8(0x80FFD5)),
		CartType:      fmt.Sprintf("0x%02X", r8(0x80FFD6)),
		ROMSize:       fmt.Sprintf("0x%02X", r8(0x80FFD7)),
		RAMSize:       fmt.Sprintf("0x%02X", r8(0x80FFD8)),
		Region:        fmt.Sprintf("0x%02X", r8(0x80FFD9)),
		Developer:     fmt.Sprintf("0x%02X", r8(0x80FFDA)),
		Version:       fmt.Sprintf("0x%02X", r8(0x80FFDB)),
		ChecksumCompl: fmt.Sprintf("0x%04X", r16(0x80FFDC)),
		Checksum:      fmt.Sprintf("0x%04X", r16(0x80FFDE)),
		Vectors:       fmt.Sprintf("%X", bytesAt(0x80FFE0, 32)),
	}
	must(af.WriteJSON(path("header.json"), h))
	add(&af.Item{Name: "header", Kind: "header", Addr: 0x80FFB0, Slot: 0x50, File: "header.json"})

	// ---- engine and game tables (bank $80) ----
	table("ppu_init", "engine/ppu_init.json", 0x808039, "Hardware registers written at power-on by $80:801F (value, register).",
		[][2]string{{"value", "x8"}, {"register", "x16"}}, 15, nil)
	table("oam_size_masks", "engine/oam_size_masks.json", 0x8087B6, "Bit masks for the 4 sprites sharing one OAM high-table byte ($80:8788).",
		[][2]string{{"mask", "x8"}}, 4, nil)
	columnTable("object_types", "objects/object_types.json", 0x808A15,
		"Per object type (rows 0-14): sprite descriptor pointer (bank/lo/hi -> $82:8000 for all), seven unused graphics-streaming parameters, and an OAM attribute base. Stored as parallel arrays.",
		[]string{"descriptor_bank", "descriptor_lo", "descriptor_hi", "stream_0", "stream_1", "stream_2", "stream_3", "stream_4", "stream_5", "stream_6", "oam_attr"}, 15)
	table("object_ram_animations", "objects/ram_animation_tables.json", 0x808AE7,
		"Per object type: optional animation table in RAM bank $7E (0 = use the ROM descriptor). All zero.",
		[][2]string{{"address", "x16"}}, 15, nil)
	table("explosion_offsets", "objects/explosion_offsets.json", 0x80A0EA,
		"Big explosion (type 13): position offsets for each of its 24 particles, indexed by countdown 24..1 (row 0 unused).",
		[][2]string{{"x", "s16"}, {"y", "s16"}}, 25, nil)
	table("boss_dive", "objects/boss_dive.json", 0x80A4A5,
		"Boss dive attack: pixels per frame while diving, by frame (last value repeats).",
		[][2]string{{"speed", "u8"}}, 17, nil)
	table("shooter_speed", "objects/shooter_speed.json", 0x80A6B2,
		"Shooter enemy (type 3): horizontal speed by steering value 0..27.",
		[][2]string{{"speed", "u8"}}, 28, nil)
	table("wobble", "objects/wobble.json", 0x80A72D,
		"Sideways wobble per frame for type 4 enemies and the boss's bobbing; 0 restarts the cycle.",
		[][2]string{{"dx", "s16"}}, 41, nil)
	table("side_enemy_y", "stage/side_enemy_y.json", 0x80AA2E,
		"Rows (Y) at which side-entering enemies (type 9) appear, used in turn.",
		[][2]string{{"y", "u16"}}, 9, []byte{0xFF, 0xFF})
	table("spawn_x", "stage/spawn_x.json", 0x80AA42,
		"Columns (X) at which falling enemies appear, used in turn.",
		[][2]string{{"x", "u8"}}, 18, []byte{0xFF})
	table("waves", "stage/waves.json", 0x80AA55,
		"Enemy schedule, looped: wait `delay` frames, then spawn `kind` (0-2 = enemy types 2-4, 9 = side enemy). The boss appears after 30 kills.",
		[][2]string{{"delay", "u8"}, {"kind", "u8"}}, 30, []byte{0xFF})
	table("touch_kind", "objects/touch_kind.json", 0x80AD50,
		"What touching each object type does to the player: 0 nothing, 1 instant game over, 2 death animation, 3 invincibility item, 4 boss (only while active).",
		[][2]string{{"kind", "u8"}}, 15, nil)
	table("drops", "objects/drops.json", 0x80AF2F,
		"What a killed enemy drops, in turn: 0 nothing, 1 deadly falling object (type 7), 2 invincibility item (type 8).",
		[][2]string{{"drop", "u8"}}, 40, []byte{0xFF})
	table("shot_kind", "objects/shot_kind.json", 0x80AF58,
		"How player shots affect each object type: 0 no effect, 1 one-hit enemy (+5), 2 side enemy with 8 HP (+50), 3 boss with 32 HP (+100).",
		[][2]string{{"kind", "u8"}}, 15, nil)
	table("score_digit_pos", "hud/score_digit_positions.json", 0x80B5DD,
		"Score display: tile position of each of the 9 digits (ones digit first).",
		[][2]string{{"x", "u8"}, {"y", "u8"}}, 9, nil)
	table("score_digit_tiles", "hud/score_digit_tiles.json", 0x80B5EF,
		"Score display: the four BG tile entries (2x2) drawn for digit values 0-8 (Chinese numerals).",
		[][2]string{{"top_left", "x16"}, {"top_right", "x16"}, {"bottom_left", "x16"}, {"bottom_right", "x16"}}, 9, nil)
	table("language_cursor", "menu/language_cursor.json", 0x80BCDB,
		"Language menu cursor: first row = (columns, rows), then the cursor's pixel position for each entry.",
		[][2]string{{"a", "u8"}, {"b", "u8"}}, 4, nil)
	layout := func(name string, addr uint32, n int, what string) {
		table(name, "screens/"+name+".json", addr, "Picture layout for "+what+": rectangles (in tiles) of the BG2 picture to show; tile_base adds palette/priority bits.",
			[][2]string{{"x", "u16"}, {"y", "u16"}, {"w", "u16"}, {"h", "u16"}, {"tile_base", "x16"}}, n, []byte{0xFF, 0xFF})
	}
	layout("layout_stage", 0x80BDBF, 1, "the stage background")
	layout("layout_title", 0x80C4E6, 2, "the title screen")
	layout("layout_story1", 0x80C4FC, 1, "story page 1")
	layout("layout_story2", 0x80C508, 1, "story page 2")
	layout("layout_story3", 0x80C514, 1, "story page 3")
	layout("layout_story4", 0x80C520, 1, "story page 4")
	layout("layout_gameover", 0x80C6DF, 1, "the game over screen")

	// ---- text ($80:8B05-9BD1) ----
	type tx struct {
		addr       uint32
		file, rend string
		what       string
	}
	for _, t := range []tx{
		{0x808B05, "text/language_select.txt", "16", "Power-on screen: publisher and language menu."},
		{0x808BA7, "text/jp/address.txt", "16", "Publisher address (Japanese)."},
		{0x808C0B, "text/jp/games_wanted.txt", "16", "'Games wanted' notice (Japanese)."},
		{0x808D69, "text/jp/dealers.txt", "16", "Dealer notice (Japanese)."},
		{0x808EAB, "text/jp/story1.txt", "16", "Story page 1 (Japanese)."},
		{0x808F11, "text/jp/story2.txt", "16", "Story page 2 (Japanese)."},
		{0x808F77, "text/jp/story3.txt", "16", "Story page 3 (Japanese)."},
		{0x808FD5, "text/jp/story4.txt", "16", "Story page 4 (Japanese)."},
		{0x809033, "text/cn/address.txt", "16", "Publisher address (Chinese)."},
		{0x809089, "text/cn/games_wanted.txt", "16", "'Games wanted' notice (Chinese)."},
		{0x809123, "text/cn/dealers.txt", "16", "Dealer notice (Chinese)."},
		{0x8091A1, "text/cn/story1.txt", "16", "Story page 1 (Chinese)."},
		{0x8091DB, "text/cn/story2.txt", "16", "Story page 2 (Chinese)."},
		{0x80923B, "text/cn/story3.txt", "16", "Story page 3 (Chinese)."},
		{0x809295, "text/cn/story4.txt", "16", "Story page 4 (Chinese)."},
		{0x8092DD, "text/credits1.txt", "16", "Credits page 1 (after game over)."},
		{0x809387, "text/credits2.txt", "16", "Credits page 2."},
		{0x80941F, "text/en/story1.txt", "8x8", "Story page 1 (English)."},
		{0x8094DF, "text/en/story2.txt", "8x8", "Story page 2 (English)."},
		{0x8095D9, "text/en/story3.txt", "8x8", "Story page 3 (English)."},
		{0x8096BB, "text/en/story4.txt", "8x8", "Story page 4 (English)."},
		{0x8097F3, "text/en/address.txt", "8x8", "Publisher address (English)."},
		{0x809895, "text/en/games_wanted.txt", "8x8", "'Games wanted' notice (English)."},
		{0x809A5D, "text/en/dealers.txt", "8x8", "Dealer notice (English)."},
	} {
		name := strings.TrimSuffix(strings.ReplaceAll(strings.TrimPrefix(t.file, "text/"), "/", "_"), ".txt")
		text("text_"+name, t.file, t.addr, t.rend, t.what)
	}

	// ---- sprite animation bank ($82) ----
	{
		base := af.Addr(0x828000)
		s, n, err := af.DecodeSprites(rom[base.Offset():base.Offset()+0x8000], base)
		must(err)
		must(af.WriteJSON(path("sprites/animations.json"), s))
		add(&af.Item{Name: "sprite_animations", Kind: "sprites", Addr: base, Slot: n, File: "sprites/animations.json"})
	}

	// ---- font ($83:8000-$84:85FF, 2bpp) ----
	{
		o := af.Addr(0x838000).Offset()
		n := af.Addr(0x848600).Offset() - o
		pix, w, hh := af.DecodeTiles(rom[o:o+n], 2, 16)
		gray := []color.Color{color.RGBA{255, 255, 255, 255}, color.RGBA{170, 170, 170, 255}, color.RGBA{85, 85, 85, 255}, color.RGBA{0, 0, 0, 255}}
		must(af.WritePNG(path("font/font.png"), pix, w, hh, gray))
		add(&af.Item{Name: "font", Kind: "font", Addr: 0x838000, Slot: n, File: "font/font.png",
			Comment: "2bpp glyphs. 8x8 English text: glyph c at tile c. 16x16 glyphs: code c at tile column (c%8)*2, row (c/8)*2. Character tables: assetfmt/text.go and assetfmt/cjk_gen.go."})
	}

	// ---- compressed graphics ----
	order := []*lzBlock{
		lz(0x848600, "game_tiles", "lz_tiles", "graphics/game_tiles.png", "game_palette", "Sprites and HUD tiles (VRAM $0000)."),
		lz(0x84A725, "game_palette", "lz_palette", "graphics/game_palette.json", "", "Gameplay BG and sprite palettes (128 colours)."),
		lz(0x84A829, "title", "lz_picture", "graphics/title.png", "title_palette", "Title screen picture."),
		lz(0x84D483, "title_palette", "lz_palette", "graphics/title_palette.json", "", "Title screen palettes 1-3."),
		lz(0x84D4E7, "base_palette", "lz_palette", "graphics/base_palette.json", "", "Palette 0 (text and backdrop)."),
		lz(0x84D4F3, "story1_palette", "lz_palette", "graphics/story1_palette.json", "", "Story page 1 palette."),
		lz(0x84D516, "story1", "lz_picture", "graphics/story1.png", "story1_palette", "Story page 1 picture (parade)."),
		lz(0x8599ED, "story2_palette", "lz_palette", "graphics/story2_palette.json", "", "Story page 2 palettes 1-3."),
		lz(0x859A51, "story2_layer_tiles", "lz_tiles", "graphics/story2_layer_tiles.png", "story2_palette", "Story page 2 foreground layer tiles (BG1)."),
		lz(0x85AA58, "story2_layer_map", "lz_tilemap", "graphics/story2_layer_map.json", "", "Story page 2 foreground layer tilemap (BG1)."),
		lz(0x85AD0D, "story2", "lz_picture", "graphics/story2.png", "story2_palette", "Story page 2 picture."),
		lz(0x85ECA9, "story3_palette", "lz_palette", "graphics/story3_palette.json", "", "Story page 3 palettes 1-2."),
		lz(0x85ECED, "story3_layer_tiles", "lz_tiles", "graphics/story3_layer_tiles.png", "story3_palette", "Story page 3 foreground layer tiles (BG1)."),
		lz(0x868289, "story3_layer_map", "lz_tilemap", "graphics/story3_layer_map.json", "", "Story page 3 foreground layer tilemap (BG1)."),
		lz(0x8684B5, "story3", "lz_picture", "graphics/story3.png", "story3_palette", "Story page 3 picture."),
		lz(0x86CB5E, "story4_palette", "lz_palette", "graphics/story4_palette.json", "", "Story page 4 palette."),
		lz(0x86CB82, "story4", "lz_picture", "graphics/story4.png", "story4_palette", "Story page 4 picture."),
		lz(0x86E34B, "unused_palette", "lz_palette", "graphics/unused_palette.json", "", "Palette of a picture the game never shows."),
		lz(0x86E36F, "unused_picture", "lz_picture", "graphics/unused_picture.png", "unused_palette", "A picture the game never shows (no code refers to it)."),
		lz(0x87AD76, "gameover_palette", "lz_palette", "graphics/gameover_palette.json", "", "Game over picture palette."),
		lz(0x87AD9A, "gameover", "lz_picture", "graphics/gameover.png", "gameover_palette", "Game over picture."),
		lz(0x88827C, "stage2_palette", "lz_palette", "graphics/stage2_palette.json", "", "Stage background 2 palette."),
		lz(0x8882A0, "stage2", "lz_picture", "graphics/stage2.png", "stage2_palette", "Stage background 2."),
		lz(0x88B880, "stage1_palette", "lz_palette", "graphics/stage1_palette.json", "", "Stage background 1 palette."),
		lz(0x88B8A4, "stage1", "lz_picture", "graphics/stage1.png", "stage1_palette", "Stage background 1 (each new game uses the next background)."),
		lz(0x88F348, "stage3_palette", "lz_palette", "graphics/stage3_palette.json", "", "Stage background 3 palette."),
		lz(0x88F36C, "stage3", "lz_picture", "graphics/stage3.png", "stage3_palette", "Stage background 3."),
		lz(0x89D3DC, "stage4_palette", "lz_palette", "graphics/stage4_palette.json", "", "Stage background 4 palette."),
		lz(0x89D400, "stage4", "lz_picture", "graphics/stage4.png", "stage4_palette", "Stage background 4."),
		lz(0x8AA359, "stage5_palette", "lz_palette", "graphics/stage5_palette.json", "", "Stage background 5 palette."),
		lz(0x8AA37D, "stage5", "lz_picture", "graphics/stage5.png", "stage5_palette", "Stage background 5."),
		lz(0x8AD224, "stage6_palette", "lz_palette", "graphics/stage6_palette.json", "", "Stage background 6 palette."),
		lz(0x8AD248, "stage6", "lz_picture", "graphics/stage6.png", "stage6_palette", "Stage background 6."),
	}
	hints := map[string][]int{
		"title":              layoutPalettes(0x80C4E6),
		"story1":             layoutPalettes(0x80C4FC),
		"story2":             layoutPalettes(0x80C508),
		"story3":             layoutPalettes(0x80C514),
		"story4":             layoutPalettes(0x80C520),
		"gameover":           layoutPalettes(0x80C6DF),
		"unused_picture":     layoutPalettes(0x80BDBF),
		"story2_layer_tiles": tilemapPalettes("story2_layer_map", 512),
		"story3_layer_tiles": tilemapPalettes("story3_layer_map", 512),
	}
	for i := 1; i <= 6; i++ {
		hints[fmt.Sprintf("stage%d", i)] = layoutPalettes(0x80BDBF)
	}
	// sprite tiles: palette from the sprite frames that use them
	{
		var s af.Sprites
		b, _ := os.ReadFile(path("sprites/animations.json"))
		must(jsonUnmarshal(b, &s))
		pal := make([]int, 512)
		for _, f := range s.Frames {
			for _, p := range f.Pieces {
				t, _ := strconv.ParseInt(strings.TrimPrefix(p.Tile, "0x"), 16, 32)
				a, _ := strconv.ParseInt(strings.TrimPrefix(p.Attr, "0x"), 16, 32)
				t |= (a & 1) << 8
				pl := int(a>>1&7) + 8 // sprite palettes are CGRAM 128+
				for _, d := range []int64{0, 1, 16, 17} {
					if a&0x10 == 0 && d != 0 {
						continue
					}
					if int(t+d) < 512 {
						pal[t+d] = pl
					}
				}
			}
		}
		hints["game_tiles"] = pal
	}
	writeBlocks(order, hints)

	// ---- sound ($8F:8000) ----
	{
		o := af.Addr(0x8F8000).Offset()
		s := &af.SPC{Comment: "SPC700 sound program, uploaded to the audio CPU at power-on ($80:C8C3): blocks copied to SPC RAM, then execution starts at `entry`. Not played by this port yet."}
		p := o
		for {
			n := int(rom[p]) | int(rom[p+1])<<8
			d := int(rom[p+2]) | int(rom[p+3])<<8
			p += 4
			if n == 0 {
				s.Entry = fmt.Sprintf("0x%04X", d)
				break
			}
			f := fmt.Sprintf("sound/spc_%04X.bin", d)
			must(os.WriteFile(path(f), rom[p:p+n], 0o644))
			s.Blocks = append(s.Blocks, af.SPCBlock{Dest: fmt.Sprintf("0x%04X", d), File: f})
			p += n
		}
		must(af.WriteJSON(path("sound/spc.json"), s))
		add(&af.Item{Name: "spc_program", Kind: "spc", Addr: 0x8F8000, Slot: p - o, File: "sound/spc.json"})
	}

	// ---- whatever is left: non-zero bytes that are neither code nor an asset ----
	covered := make([]bool, len(rom))
	for _, it := range man.Items {
		o := it.Addr.Offset()
		for i := o; i < o+it.Slot; i++ {
			covered[i] = true
		}
	}
	f, err := os.Open(*codemap)
	must(err)
	sc := bufio.NewScanner(f)
	for sc.Scan() {
		l := sc.Text()
		if strings.HasPrefix(l, "#") {
			continue
		}
		var a, b int
		fmt.Sscanf(l, "%x %x", &a, &b)
		for i := a; i < b; i++ {
			covered[i] = true
		}
	}
	f.Close()
	var leftovers [][2]int
	for i := 0; i < len(rom); {
		if covered[i] || rom[i] == 0x00 || rom[i] == 0xFF {
			i++
			continue
		}
		j := i
		for j < len(rom) && !covered[j] && !(rom[j] == 0 && allPad(j)) {
			j++
		}
		leftovers = append(leftovers, [2]int{i, j})
		i = j
	}
	for _, l := range leftovers {
		a := af.AddrOf(l[0])
		kind, comment := "dead_code", "Code that is never called (so it was not recompiled). Kept only so the data image is complete."
		if a == 0x80B637 {
			kind, comment = "data", "Table that no code reads (it follows the score tables; looks like BG tile entries)."
		}
		file := fmt.Sprintf("unused/%s_%02X%04X.bin", kind, uint32(a)>>16, uint32(a)&0xFFFF)
		must(os.WriteFile(path(file), rom[l[0]:l[1]], 0o644))
		add(&af.Item{Name: "unused_" + kind + "_" + strings.ReplaceAll(a.String(), ":", ""), Kind: "raw", Addr: a, Slot: l[1] - l[0], File: file, Comment: comment})
	}

	for _, it := range man.Items {
		switch {
		case it.Kind == "table" || it.Kind == "text":
			it.Place = "bank80"
		case it.Compressed():
			it.Place = "anywhere"
		default:
			it.Place = "fixed"
		}
	}
	sort.SliceStable(man.Items, func(i, j int) bool { return man.Items[i].Addr < man.Items[j].Addr })
	must(af.WriteJSON(path("manifest.json"), man))
	fmt.Printf("extracted %d assets (%d leftover blobs) to %s\n", len(man.Items), len(leftovers), out)
}

// allPad reports whether the next 16 bytes from i are zero (end of a run).
func allPad(i int) bool {
	for k := i; k < i+16 && k < len(rom); k++ {
		if rom[k] != 0 {
			return false
		}
	}
	return true
}

func jsonUnmarshal(b []byte, v any) error { return json.Unmarshal(b, v) }
