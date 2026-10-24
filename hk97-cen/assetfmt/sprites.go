package assetfmt

import "fmt"

// Sprite animation data (bank $82). All object types share one descriptor
// at $82:8000 (pointed to by the type tables at $80:8A15/8A24/8A33).
//
// Layout written by EncodeSprites, in this order:
//
//	descriptor: 5 words -> animation table, frame table, size table A,
//	            size table B, hitbox table (a 6th word, the graphics-stream
//	            offset table, is unused and coincides with animation pointer 0)
//	animation pointer table: one word per animation plus an end pointer
//	animation data: 4 bytes per step (frame id, duration, dx, dy)
//	frame (metasprite) pointer table: one word per frame id 1..N
//	frame data: piece count, then 4 bytes per piece (x, y, tile, attributes)
//	size tables A and B (raw bytes, read with per-step indices by $80:88BF)
//	hitboxes: 4 bytes per frame id (x offset, y offset, width, height)
type Sprites struct {
	Comment    string      `json:"comment"`
	Base       Addr        `json:"base"`
	Animations []Animation `json:"animations"`
	Frames     []Frame     `json:"frames"`
	SizeA      []int       `json:"size_table_a"`
	SizeB      []int       `json:"size_table_b"`
	Hitboxes   [][4]int    `json:"hitboxes"`
}

type Animation struct {
	ID    int    `json:"id"`
	Steps []Step `json:"steps"`
}

type Step struct {
	Frame    int `json:"frame"`
	Duration int `json:"duration"`
	DX       int `json:"dx"`
	DY       int `json:"dy"`
}

type Frame struct {
	ID     int     `json:"id"`
	Pieces []Piece `json:"pieces"`
}

type Piece struct {
	X    int    `json:"x"`
	Y    int    `json:"y"`
	Tile string `json:"tile"`
	Attr string `json:"attr"`
}

// DecodeSprites parses the bank starting at base (bank-relative bytes in b).
func DecodeSprites(b []byte, base Addr) (*Sprites, int, error) {
	org := int(uint32(base) & 0xFFFF)
	w := func(a int) int { return int(b[a-org]) | int(b[a-org+1])<<8 }
	animTab, frameTab, sizeA, sizeB, hit := w(org), w(org+2), w(org+4), w(org+6), w(org+8)
	if animTab != org+10 {
		return nil, 0, fmt.Errorf("sprites: unexpected layout")
	}
	s := &Sprites{Base: base, Comment: "Sprite animations and frames (bank $82). Edit freely; tools/pack lays the bank out and rebuilds all pointers."}
	// animation pointer table ends where the first animation starts
	first := w(animTab)
	var ptrs []int
	for a := animTab; a < first; a += 2 {
		ptrs = append(ptrs, w(a))
	}
	maxFrame := 0
	for i := 0; i+1 < len(ptrs); i++ {
		an := Animation{ID: i}
		for a := ptrs[i]; a < ptrs[i+1]; a += 4 {
			st := Step{int(b[a-org]), int(b[a-org+1]), int(int8(b[a-org+2])), int(int8(b[a-org+3]))}
			if st.Frame > maxFrame {
				maxFrame = st.Frame
			}
			an.Steps = append(an.Steps, st)
		}
		s.Animations = append(s.Animations, an)
	}
	if ptrs[len(ptrs)-1] != frameTab {
		return nil, 0, fmt.Errorf("sprites: animation data does not end at frame table")
	}
	for f := 1; f <= maxFrame; f++ {
		p := w(frameTab + 2*(f-1))
		n := int(b[p-org])
		fr := Frame{ID: f}
		for k := 0; k < n; k++ {
			q := p - org + 1 + 4*k
			fr.Pieces = append(fr.Pieces, Piece{int(int8(b[q])), int(int8(b[q+1])), fmt.Sprintf("0x%02X", b[q+2]), fmt.Sprintf("0x%02X", b[q+3])})
		}
		s.Frames = append(s.Frames, fr)
	}
	for a := sizeA; a < sizeB; a++ {
		s.SizeA = append(s.SizeA, int(b[a-org]))
	}
	for a := sizeB; a < hit; a++ {
		s.SizeB = append(s.SizeB, int(b[a-org]))
	}
	for f := 0; f < maxFrame; f++ {
		q := hit - org + 4*f
		s.Hitboxes = append(s.Hitboxes, [4]int{int(int8(b[q])), int(int8(b[q+1])), int(b[q+2]), int(b[q+3])})
	}
	end := hit + 4*maxFrame
	return s, end - org, nil
}

// EncodeSprites lays the data out from Base and returns the bytes.
func (s *Sprites) Encode() ([]byte, error) {
	org := int(uint32(s.Base) & 0xFFFF)
	nA := len(s.Animations)
	nF := len(s.Frames)
	for i, f := range s.Frames {
		if f.ID != i+1 {
			return nil, fmt.Errorf("sprites: frames must be numbered 1..N in order (got %d at %d)", f.ID, i)
		}
	}
	animTab := org + 10
	animData := animTab + 2*(nA+1)
	steps := 0
	for _, a := range s.Animations {
		steps += len(a.Steps)
	}
	frameTab := animData + 4*steps
	frameData := frameTab + 2*nF
	fsize := 0
	for _, f := range s.Frames {
		fsize += 1 + 4*len(f.Pieces)
	}
	sizeA := frameData + fsize
	sizeB := sizeA + len(s.SizeA)
	hit := sizeB + len(s.SizeB)
	end := hit + 4*len(s.Hitboxes)
	if end > 0x10000 {
		return nil, fmt.Errorf("sprites: data does not fit in the bank")
	}
	out := make([]byte, end-org)
	pw := func(a, v int) { out[a-org], out[a-org+1] = byte(v), byte(v>>8) }
	pw(org, animTab)
	pw(org+2, frameTab)
	pw(org+4, sizeA)
	pw(org+6, sizeB)
	pw(org+8, hit)
	a := animData
	for i, an := range s.Animations {
		pw(animTab+2*i, a)
		for _, st := range an.Steps {
			if st.Frame < 0 || st.Frame > nF {
				return nil, fmt.Errorf("animation %d: frame %d does not exist", an.ID, st.Frame)
			}
			out[a-org], out[a-org+1], out[a-org+2], out[a-org+3] = byte(st.Frame), byte(st.Duration), byte(st.DX), byte(st.DY)
			a += 4
		}
	}
	pw(animTab+2*nA, a)
	a = frameData
	for i, f := range s.Frames {
		pw(frameTab+2*i, a)
		out[a-org] = byte(len(f.Pieces))
		a++
		for _, p := range f.Pieces {
			t, err := num(p.Tile)
			if err != nil {
				return nil, err
			}
			at, err := num(p.Attr)
			if err != nil {
				return nil, err
			}
			out[a-org], out[a-org+1], out[a-org+2], out[a-org+3] = byte(p.X), byte(p.Y), byte(t), byte(at)
			a += 4
		}
	}
	for i, v := range s.SizeA {
		out[sizeA-org+i] = byte(v)
	}
	for i, v := range s.SizeB {
		out[sizeB-org+i] = byte(v)
	}
	for i, h := range s.Hitboxes {
		for k := 0; k < 4; k++ {
			out[hit-org+4*i+k] = byte(h[k])
		}
	}
	return out, nil
}
