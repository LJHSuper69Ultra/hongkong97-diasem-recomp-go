package assetfmt

import (
	"bufio"
	"fmt"
	"strconv"
	"strings"
)

// Text blocks: a list of lines, each `x y code... FFFF` (16-bit words),
// the block ending with an extra FFFF. x/y are tile coordinates.
//
// Two renderers exist:
//   - "8x8"  ($80:B7A2): English, 8x8 glyphs, codes in enGlyphs
//   - "16"   ($80:B869): 16x16 glyphs (kana/kanji/full-width), codes in cjkGlyphs
//
// Text files use one line per screen line:  "@x,y text".  A code with no
// character assigned is written as {XXXX}.

var enGlyphs = func() map[uint16]rune {
	m := map[uint16]rune{0: ' ', 1: '.', 2: ',', 3: '!', 4: '?', 5: '\'', 6: '"', 7: '-', 8: '/', 9: '(', 10: ')'}
	for i := 0; i < 26; i++ {
		m[uint16(0x0B+i)] = rune('A' + i)
		m[uint16(0x25+i)] = rune('a' + i)
	}
	for i := 0; i < 10; i++ {
		m[uint16(0x40+i)] = rune('0' + i)
	}
	return m
}()

func charmap(renderer string) (map[uint16]rune, map[rune]uint16, error) {
	var m map[uint16]rune
	switch renderer {
	case "8x8":
		m = enGlyphs
	case "16":
		m = cjkGlyphs
	default:
		return nil, nil, fmt.Errorf("unknown text renderer %q", renderer)
	}
	inv := map[rune]uint16{}
	for k, v := range m {
		if old, dup := inv[v]; dup {
			return nil, nil, fmt.Errorf("charmap %s: %q used by %X and %X", renderer, v, old, k)
		}
		inv[v] = k
	}
	return m, inv, nil
}

// DecodeText reads a text block and returns the file form and the number
// of bytes the block occupies.
func DecodeText(b []byte, renderer string) (string, int, error) {
	m, _, err := charmap(renderer)
	if err != nil {
		return "", 0, err
	}
	w := func(i int) uint16 { return uint16(b[i]) | uint16(b[i+1])<<8 }
	var sb strings.Builder
	o := 0
	for {
		x := w(o)
		o += 2
		if x == 0xFFFF {
			return sb.String(), o, nil
		}
		y := w(o)
		o += 2
		fmt.Fprintf(&sb, "@%d,%d ", x, y)
		for {
			c := w(o)
			o += 2
			if c == 0xFFFF {
				break
			}
			if r, ok := m[c]; ok && r != '{' {
				sb.WriteRune(r)
			} else {
				fmt.Fprintf(&sb, "{%04X}", c)
			}
		}
		sb.WriteByte('\n')
	}
}

// EncodeText is the inverse of DecodeText. Lines starting with '#' are comments.
func EncodeText(src, renderer string) ([]byte, error) {
	_, inv, err := charmap(renderer)
	if err != nil {
		return nil, err
	}
	var out []byte
	put := func(v uint16) { out = append(out, byte(v), byte(v>>8)) }
	sc := bufio.NewScanner(strings.NewReader(src))
	ln := 0
	for sc.Scan() {
		ln++
		line := strings.TrimRight(sc.Text(), "\r")
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		if !strings.HasPrefix(line, "@") {
			return nil, fmt.Errorf("line %d: expected \"@x,y text\"", ln)
		}
		sp := strings.IndexByte(line, ' ')
		if sp < 0 {
			sp = len(line)
		}
		xy := strings.Split(line[1:sp], ",")
		if len(xy) != 2 {
			return nil, fmt.Errorf("line %d: bad position", ln)
		}
		x, err1 := strconv.Atoi(xy[0])
		y, err2 := strconv.Atoi(xy[1])
		if err1 != nil || err2 != nil {
			return nil, fmt.Errorf("line %d: bad position", ln)
		}
		put(uint16(x))
		put(uint16(y))
		text := ""
		if sp < len(line) {
			text = line[sp+1:]
		}
		rs := []rune(text)
		for i := 0; i < len(rs); i++ {
			if rs[i] == '{' {
				end := i + 5
				if end < len(rs) && rs[end] == '}' {
					v, err := strconv.ParseUint(string(rs[i+1:end]), 16, 16)
					if err == nil {
						put(uint16(v))
						i = end
						continue
					}
				}
			}
			c, ok := inv[rs[i]]
			if !ok && renderer == "16" {
				c, ok = inv[wideAlias(rs[i])]
			}
			if !ok {
				hint := ""
				if renderer == "16" && isHangul(rs[i]) {
					hint = " (run `go run ./tools/hangul` to add Hangul glyphs to the font)"
				}
				return nil, fmt.Errorf("line %d: character %q is not in the %s font%s", ln, rs[i], renderer, hint)
			}
			put(c)
		}
		put(0xFFFF)
	}
	put(0xFFFF)
	return out, nil
}

// wideAlias lets 16x16 text be written with ASCII spaces, digits and
// punctuation: each stands for its full-width form.
func wideAlias(r rune) rune {
	switch {
	case r == ' ':
		return '\u3000'
	case r == '-':
		return 'ー'
	case r > ' ' && r < 0x7F:
		return r - '!' + '！'
	}
	return r
}

func isHangul(r rune) bool { return r >= 0xAC00 && r <= 0xD7A3 }

// RegisterGlyphs adds 16x16 glyphs to the character table: chars[i] is
// drawn by code first+i. Used for glyphs appended to the font (see
// ReadGlyphList).
func RegisterGlyphs(first uint16, chars []rune) error {
	for i, r := range chars {
		c := first + uint16(i)
		if old, ok := cjkGlyphs[c]; ok && old != r {
			return fmt.Errorf("glyph code %04X is already %q", c, old)
		}
		for k, v := range cjkGlyphs {
			if v == r && k != c {
				return fmt.Errorf("character %q is already glyph %04X", r, k)
			}
		}
		cjkGlyphs[c] = r
	}
	return nil
}

// ReadGlyphList parses a glyph list file: '#' comment lines, a line
// "@XXXX" giving the code of the first glyph, then the characters in code
// order (line breaks and spaces are ignored).
func ReadGlyphList(src string) (uint16, []rune, error) {
	var first uint16
	seen := false
	var chars []rune
	sc := bufio.NewScanner(strings.NewReader(src))
	for sc.Scan() {
		l := strings.TrimSpace(sc.Text())
		switch {
		case l == "" || strings.HasPrefix(l, "#"):
		case strings.HasPrefix(l, "@"):
			v, err := strconv.ParseUint(l[1:], 16, 16)
			if err != nil {
				return 0, nil, fmt.Errorf("bad first code %q", l)
			}
			first, seen = uint16(v), true
		default:
			for _, r := range l {
				if r != ' ' && r != '\u3000' {
					chars = append(chars, r)
				}
			}
		}
	}
	if !seen && len(chars) > 0 {
		return 0, nil, fmt.Errorf("glyph list has no @first-code line")
	}
	return first, chars, sc.Err()
}

// FormatGlyphList is the inverse of ReadGlyphList.
func FormatGlyphList(header string, first uint16, chars []rune) string {
	var sb strings.Builder
	sb.WriteString(header)
	fmt.Fprintf(&sb, "@%04X\n", first)
	for i := 0; i < len(chars); i += 16 {
		j := min(i+16, len(chars))
		sb.WriteString(string(chars[i:j]))
		sb.WriteByte('\n')
	}
	return sb.String()
}

// Glyph16 returns the 16x16 glyph code for r (ASCII aliases included).
func Glyph16(r rune) (uint16, bool) {
	for k, v := range cjkGlyphs {
		if v == r || v == wideAlias(r) {
			return k, true
		}
	}
	return 0, false
}

// TextChars returns the characters a text file uses (positions, comments
// and {XXXX} escapes excluded), in order of appearance.
func TextChars(src string) []rune {
	var out []rune
	sc := bufio.NewScanner(strings.NewReader(src))
	for sc.Scan() {
		line := strings.TrimRight(sc.Text(), "\r")
		if !strings.HasPrefix(line, "@") {
			continue
		}
		sp := strings.IndexByte(line, ' ')
		if sp < 0 {
			continue
		}
		rs := []rune(line[sp+1:])
		for i := 0; i < len(rs); i++ {
			if rs[i] == '{' && i+5 < len(rs) && rs[i+5] == '}' {
				if _, err := strconv.ParseUint(string(rs[i+1:i+5]), 16, 16); err == nil {
					i += 5
					continue
				}
			}
			out = append(out, rs[i])
		}
	}
	return out
}

// WideAlias is exported for tools: the full-width form an ASCII character
// in 16x16 text stands for.
func WideAlias(r rune) rune { return wideAlias(r) }
