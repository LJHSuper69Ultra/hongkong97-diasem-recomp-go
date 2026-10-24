// Command hk97 is the PC version of Hong Kong 97 (SNES, 1995), built from
// this project's sources: the game code in recomp/ and the game data packed
// from assets/ (see the go:generate line below). No ROM file is used.
package main

import (
	_ "embed"
	"encoding/json"
	"fmt"
	"image"
	"os"
	"runtime/debug"
	"strings"
	"sync"

	"github.com/hajimehoshi/ebiten/v2"
	"github.com/hajimehoshi/ebiten/v2/ebitenutil"
	"github.com/hajimehoshi/ebiten/v2/inpututil"

	"hk97/apu"
	"hk97/ppu"
	"hk97/recomp"
)

//go:generate go run ../../tools/pack -assets ../../assets -codemap ../../recomp/codemap.txt -o romdata.bin

// romdata.bin is the game data image built from assets/ by tools/pack;
// romdatasyms.json records where each asset was placed.
var (
	//go:embed romdata.bin
	romdata []byte
	//go:embed romdatasyms.json
	romsymsJSON []byte
)

func romSymbols() map[string]uint32 {
	var raw map[string]string
	if err := json.Unmarshal(romsymsJSON, &raw); err != nil {
		panic(err)
	}
	syms := map[string]uint32{}
	for k, v := range raw {
		var b, a uint32
		fmt.Sscanf(v, "%x:%x", &b, &a)
		syms[k] = b<<16 | a
	}
	return syms
}

const title = "Hong Kong 97"

type stopSignal struct{}

// session runs the game on its own goroutine and hands over one frame per
// vblank, so the original program flow can stay sequential.
type session struct {
	m       *recomp.Machine
	resume  chan struct{}
	ready   chan struct{}
	stop    bool
	failure error
	mu      sync.Mutex
	frame   []byte
}

var sound = &stream{}

func newSession() *session {
	snd := apu.New()
	s := &session{
		m:      recomp.New(romdata, romSymbols()),
		resume: make(chan struct{}),
		ready:  make(chan struct{}),
		frame:  make([]byte, ppu.W*ppu.H*4),
	}
	s.m.HW.APU = snd
	s.m.Frame = func() {
		sound.push(snd.Frame())
		s.m.PPU.Render()
		s.mu.Lock()
		for i, c := range s.m.PPU.Frame {
			s.frame[i*4], s.frame[i*4+1], s.frame[i*4+2], s.frame[i*4+3] = uint8(c>>16), uint8(c>>8), uint8(c), 0xFF
		}
		s.mu.Unlock()
		s.ready <- struct{}{}
		<-s.resume
		if s.stop {
			panic(stopSignal{})
		}
	}
	go func() {
		defer func() {
			if r := recover(); r != nil {
				if _, ok := r.(stopSignal); ok {
					return
				}
				s.failure = fmt.Errorf("%v\n%s", r, debug.Stack())
				close(s.ready)
			}
		}()
		s.m.Run()
	}()
	<-s.ready
	return s
}

func (s *session) step(joy uint16) bool {
	if s.failure != nil {
		return false
	}
	s.m.Joy1 = joy
	s.resume <- struct{}{}
	_, ok := <-s.ready
	return ok
}

func (s *session) close() {
	if s.failure == nil {
		s.stop = true
		s.resume <- struct{}{}
	}
}

type game struct {
	warn   *warningScreen // non-nil until the player confirms the warning
	sess   *session
	screen *ebiten.Image
	errMsg string
}

func (g *game) Update() error {
	if inpututil.IsKeyJustPressed(ebiten.KeyF11) ||
		(inpututil.IsKeyJustPressed(ebiten.KeyEnter) && ebiten.IsKeyPressed(ebiten.KeyAlt)) {
		ebiten.SetFullscreen(!ebiten.IsFullscreen())
	}
	if g.warn != nil {
		if g.warn.confirmed() {
			g.warn = nil
			startAudio(sound)
			g.sess = newSession()
		}
		return nil
	}
	if g.sess == nil {
		return nil
	}
	if inpututil.IsKeyJustPressed(ebiten.KeyM) {
		sound.mu.Lock()
		sound.muted = !sound.muted
		sound.mu.Unlock()
	}
	if inpututil.IsKeyJustPressed(ebiten.KeyF2) {
		g.sess.close()
		g.sess = newSession()
	}
	if !g.sess.step(readInput()) {
		msg := g.sess.failure.Error()
		fmt.Fprintln(os.Stderr, msg)
		if i := strings.IndexByte(msg, '\n'); i >= 0 {
			msg = msg[:i]
		}
		g.errMsg = "The game stopped unexpectedly:\n" + msg
		g.sess = nil
	}
	return nil
}

func (g *game) Draw(screen *ebiten.Image) {
	if g.warn != nil {
		b := screen.Bounds()
		screen.DrawImage(g.warn.render(b.Dx(), b.Dy()), nil)
		return
	}
	if g.sess == nil {
		ebitenutil.DebugPrintAt(screen, g.errMsg, 8, 8)
		return
	}
	g.sess.mu.Lock()
	g.screen.WritePixels(g.sess.frame)
	g.sess.mu.Unlock()
	screen.DrawImage(g.screen, nil)
}

func (g *game) Layout(ow, oh int) (int, int) {
	if g.warn != nil { // draw the warning at full window resolution
		s := ebiten.Monitor().DeviceScaleFactor()
		return int(float64(ow) * s), int(float64(oh) * s)
	}
	return ppu.W, ppu.H
}

func main() {
	ebiten.SetWindowTitle(title)
	ebiten.SetWindowSize(ppu.W*3, ppu.H*3)
	ebiten.SetWindowResizingMode(ebiten.WindowResizingModeEnabled)
	ebiten.SetTPS(60)
	g := &game{screen: ebiten.NewImageFromImage(image.NewRGBA(image.Rect(0, 0, ppu.W, ppu.H)))}
	g.warn = newWarningScreen() // the game starts after the player confirms
	if err := ebiten.RunGame(g); err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}

// ---------------------------------------------------------------- input ---

// SNES joypad bits as read from $4218/$4219.
const (
	bB, bY, bSelect, bStart   = 0x8000, 0x4000, 0x2000, 0x1000
	bUp, bDown, bLeft, bRight = 0x0800, 0x0400, 0x0200, 0x0100
	bA, bX, bL, bR            = 0x0080, 0x0040, 0x0020, 0x0010
)

var keyMap = []struct {
	keys []ebiten.Key
	bit  uint16
}{
	{[]ebiten.Key{ebiten.KeyArrowUp}, bUp},
	{[]ebiten.Key{ebiten.KeyArrowDown}, bDown},
	{[]ebiten.Key{ebiten.KeyArrowLeft}, bLeft},
	{[]ebiten.Key{ebiten.KeyArrowRight}, bRight},
	{[]ebiten.Key{ebiten.KeyZ, ebiten.KeySpace}, bY}, // fire / confirm
	{[]ebiten.Key{ebiten.KeyX}, bB},
	{[]ebiten.Key{ebiten.KeyC}, bA},
	{[]ebiten.Key{ebiten.KeyV}, bX},
	{[]ebiten.Key{ebiten.KeyEnter}, bStart},
	{[]ebiten.Key{ebiten.KeyShiftRight, ebiten.KeyBackspace}, bSelect},
	{[]ebiten.Key{ebiten.KeyQ}, bL},
	{[]ebiten.Key{ebiten.KeyW}, bR},
}

var padMap = []struct {
	b   ebiten.StandardGamepadButton
	bit uint16
}{
	{ebiten.StandardGamepadButtonLeftTop, bUp},
	{ebiten.StandardGamepadButtonLeftBottom, bDown},
	{ebiten.StandardGamepadButtonLeftLeft, bLeft},
	{ebiten.StandardGamepadButtonLeftRight, bRight},
	{ebiten.StandardGamepadButtonRightBottom, bB},
	{ebiten.StandardGamepadButtonRightRight, bA},
	{ebiten.StandardGamepadButtonRightLeft, bY},
	{ebiten.StandardGamepadButtonRightTop, bX},
	{ebiten.StandardGamepadButtonCenterRight, bStart},
	{ebiten.StandardGamepadButtonCenterLeft, bSelect},
	{ebiten.StandardGamepadButtonFrontTopLeft, bL},
	{ebiten.StandardGamepadButtonFrontTopRight, bR},
}

func readInput() uint16 {
	var v uint16
	for _, k := range keyMap {
		for _, key := range k.keys {
			if ebiten.IsKeyPressed(key) {
				v |= k.bit
			}
		}
	}
	for _, id := range ebiten.AppendGamepadIDs(nil) {
		if !ebiten.IsStandardGamepadLayoutAvailable(id) {
			continue
		}
		for _, p := range padMap {
			if ebiten.IsStandardGamepadButtonPressed(id, p.b) {
				v |= p.bit
			}
		}
		x := ebiten.StandardGamepadAxisValue(id, ebiten.StandardGamepadAxisLeftStickHorizontal)
		y := ebiten.StandardGamepadAxisValue(id, ebiten.StandardGamepadAxisLeftStickVertical)
		switch {
		case x < -0.5:
			v |= bLeft
		case x > 0.5:
			v |= bRight
		}
		switch {
		case y < -0.5:
			v |= bUp
		case y > 0.5:
			v |= bDown
		}
	}
	if v&(bLeft|bRight) == bLeft|bRight { // a real pad cannot press both
		v &^= bLeft | bRight
	}
	if v&(bUp|bDown) == bUp|bDown {
		v &^= bUp | bDown
	}
	return v
}
