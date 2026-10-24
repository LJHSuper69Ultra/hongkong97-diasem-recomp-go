// Package assetfmt converts between Hong Kong 97's in-ROM data formats and
// the editable asset files of this project (PNG, JSON, text). Every format
// has a decoder (used by tools/extract) and an encoder (used by tools/pack).
package assetfmt

import (
	"errors"
	"fmt"
)

// Decompress unpacks the game's LZ format (original routine: $80:9DA6).
// read(i) returns the i-th byte of the compressed stream. It returns the
// output and the number of input bytes consumed.
//
// Stream: u16 output size, then commands chosen by the top bits of a byte:
//
//	00LLLLMM? no: 00OOOOLL        copy (LL+3) from distance OOOO+1        (1 byte)
//	01OOOOLL oooooooo             copy (LL+3), distance OOOOoooooooo+1    (2 bytes)
//	10LLLLOO oooooooo             copy (LLLL+7), distance OOoooooooo+1    (2 bytes)
//	110HLLLL llllOOOO oooooooo    copy (HllllLLLL+7), 12-bit distance     (3 bytes)
//	1110NNNN                      NNNN+1 literal bytes follow
//	11110LLL l(8) llllOOOO o(8)   copy (LLL llll l(8))+0x207, 12-bit dist  (4 bytes)
//	111110NN nnnnnnnn             NNnnnnnnnn+0x11 literal bytes follow
func Decompress(src []byte) ([]byte, int, error) {
	pos := 0
	get := func() (int, error) {
		if pos >= len(src) {
			return 0, errors.New("lz: truncated input")
		}
		v := src[pos]
		pos++
		return int(v), nil
	}
	lo, err := get()
	if err != nil {
		return nil, 0, err
	}
	hi, err := get()
	if err != nil {
		return nil, 0, err
	}
	n := lo | hi<<8
	out := make([]byte, 0, n)
	for len(out) < n {
		b, err := get()
		if err != nil {
			return nil, 0, err
		}
		var ln, dist, lit int
		switch b >> 6 {
		case 0:
			ln, dist = b&3+3, b>>2
		case 1:
			o, err := get()
			if err != nil {
				return nil, 0, err
			}
			ln, dist = b&3+3, (b>>2&0xF)<<8|o
		case 2:
			o, err := get()
			if err != nil {
				return nil, 0, err
			}
			ln, dist = (b>>2&0xF)+7, (b&3)<<8|o
		default:
			switch {
			case b&0x20 == 0: // 110xxxxx
				n1, _ := get()
				n2, err := get()
				if err != nil {
					return nil, 0, err
				}
				ln = (b>>4&1)<<8 | n1&0xF0 | b&0xF
				ln += 7
				dist = (n1&0xF)<<8 | n2
			case b&0x10 == 0: // 1110xxxx
				lit = b&0xF + 1
			case b&0x08 == 0: // 11110xxx
				n1, _ := get()
				n2, _ := get()
				n3, err := get()
				if err != nil {
					return nil, 0, err
				}
				ln = (b&7)<<12 | (n2>>4)<<8 | n1
				ln += 0x207
				dist = (n2&0xF)<<8 | n3
			case b&0x04 == 0: // 111110xx
				n1, err := get()
				if err != nil {
					return nil, 0, err
				}
				lit = (b&3)<<8 | n1
				lit += 0x11
			default:
				return nil, 0, fmt.Errorf("lz: invalid command %02X", b)
			}
		}
		if lit > 0 {
			if pos+lit > len(src) {
				return nil, 0, errors.New("lz: truncated literal")
			}
			out = append(out, src[pos:pos+lit]...)
			pos += lit
			continue
		}
		s := len(out) - (dist + 1)
		if s < 0 {
			return nil, 0, errors.New("lz: distance before start")
		}
		for i := 0; i < ln; i++ {
			out = append(out, out[s+i])
		}
	}
	return out[:n], pos, nil
}

// copy command costs in bytes for a (length, distance) pair, 0 if impossible.
func copyCost(ln, dist int) int {
	switch {
	case ln >= 3 && ln <= 6 && dist <= 0xF:
		return 1
	case ln >= 3 && ln <= 6 && dist <= 0xFFF:
		return 2
	case ln >= 7 && ln <= 22 && dist <= 0x3FF:
		return 2
	case ln >= 7 && ln <= 0x1FF+7 && dist <= 0xFFF:
		return 3
	case ln >= 0x207 && ln <= 0x7FFF+0x207 && dist <= 0xFFF:
		return 4
	}
	return 0
}

func emitCopy(out []byte, ln, dist int) []byte {
	switch copyCost(ln, dist) {
	case 1:
		if ln <= 6 && dist <= 0xF {
			return append(out, byte(dist<<2|(ln-3)))
		}
	case 2:
		if ln <= 6 {
			return append(out, byte(0x40|(dist>>8)<<2|(ln-3)), byte(dist))
		}
		return append(out, byte(0x80|(ln-7)<<2|dist>>8), byte(dist))
	case 3:
		l := ln - 7
		return append(out, byte(0xC0|(l>>8&1)<<4|l&0xF), byte(l&0xF0|dist>>8), byte(dist))
	case 4:
		l := ln - 0x207
		return append(out, byte(0xF0|l>>12&7), byte(l), byte((l>>8&0xF)<<4|dist>>8), byte(dist))
	}
	panic("lz: bad copy")
}

func emitLiterals(out, lit []byte) []byte {
	for len(lit) > 0 {
		n := len(lit)
		if n <= 16 {
			out = append(out, byte(0xE0|(n-1)))
		} else {
			if n > 0x3FF+0x11 {
				n = 0x3FF + 0x11
			}
			l := n - 0x11
			out = append(out, byte(0xF8|l>>8), byte(l))
		}
		out = append(out, lit[:n]...)
		lit = lit[n:]
	}
	return out
}

// Compress produces a near-optimal stream (dynamic programming over all
// command forms; very long copies only consider their longest lengths).
// Output always round-trips through Decompress.
func Compress(data []byte) []byte {
	n := len(data)
	const inf = 1 << 30
	const maxDist = 0xFFF
	cost := make([]int, n+1)
	choiceLen := make([]int, n+1) // >0 copy length, <0 literal run length
	choiceDist := make([]int, n+1)
	ml := make([]int, maxDist+1)     // match length at i for distance d
	mlNext := make([]int, maxDist+1) // ... at i+1
	type bracket struct{ maxDist, lo, hi, cost int }
	brackets := []bracket{
		{0xF, 3, 6, 1}, {0xFFF, 3, 6, 2}, {0x3FF, 7, 22, 2},
		{0xFFF, 7, 0x1FF + 7, 3}, {0xFFF, 0x207, 0x7FFF + 0x207, 4},
	}
	for i := n - 1; i >= 0; i-- {
		ml, mlNext = mlNext, ml
		for d := 0; d <= maxDist; d++ {
			s := i - d - 1
			if s >= 0 && data[s] == data[i] {
				ml[d] = mlNext[d] + 1
			} else {
				ml[d] = 0
			}
		}
		best := inf
		for l := 1; l <= 0x3FF+0x11 && i+l <= n; l++ {
			h := 1
			if l > 16 {
				h = 2
			}
			if h+l >= best {
				break
			}
			if c := h + l + cost[i+l]; c < best {
				best, choiceLen[i], choiceDist[i] = c, -l, 0
			}
		}
		for _, b := range brackets {
			bl, bd := 0, 0
			for d := 0; d <= b.maxDist && d < i; d++ {
				if ml[d] > bl {
					bl, bd = ml[d], d
				}
			}
			if bl > b.hi {
				bl = b.hi
			}
			from := b.lo
			if b.cost == 4 && bl-64 > from {
				from = bl - 64
			}
			for ln := from; ln <= bl; ln++ {
				if c := b.cost + cost[i+ln]; c < best {
					best, choiceLen[i], choiceDist[i] = c, ln, bd
				}
			}
		}
		cost[i] = best
	}
	out := []byte{byte(n), byte(n >> 8)}
	for i := 0; i < n; {
		if choiceLen[i] < 0 {
			l := -choiceLen[i]
			out = emitLiterals(out, data[i:i+l])
			i += l
		} else {
			out = emitCopy(out, choiceLen[i], choiceDist[i])
			i += choiceLen[i]
		}
	}
	return out
}
