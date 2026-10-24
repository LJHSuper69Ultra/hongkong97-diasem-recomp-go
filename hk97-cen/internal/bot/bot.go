// Package bot is a tiny autoplayer used by the verification tools.
package bot

// Input returns autoplay buttons for logical frame f from game RAM.
func Input(w []byte, f int) uint16 {
	if w[0x0100]&0x80 == 0 || w[0x0130] != 0 { // not in gameplay: tap A every 20 frames
		if f%20 < 3 {
			return 0x0080
		}
		return 0
	}
	px := int(w[0x01F0]) | int(w[0x0790])<<8
	py := int(w[0x0220]) | int(w[0x07C0])<<8
	best, bx := -1, 0
	for x := 1; x < 0x30; x++ {
		if w[0x0100+x]&0x80 == 0 {
			continue
		}
		t := w[0x0130+x]
		if t != 2 && t != 3 && t != 4 && t != 5 && t != 9 {
			continue
		}
		ey := int(w[0x0220+x]) | int(w[0x07C0+x])<<8
		if ey > 0x200 || ey >= py {
			continue
		}
		if ey > best {
			best, bx = ey, int(w[0x01F0+x])|int(w[0x0790+x])<<8
		}
	}
	var m uint16
	if best >= 0 {
		if bx < px-2 {
			m |= 0x0200
		} else if bx > px+2 {
			m |= 0x0100
		}
	}
	if py < 0xC0 {
		m |= 0x0400
	}
	if f%2 == 0 {
		m |= 0x4000
	}
	return m
}
