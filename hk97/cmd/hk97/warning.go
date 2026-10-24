package main

import (
	_ "embed"
	"image"
	"image/color"
	"image/draw"
	"strings"

	"github.com/hajimehoshi/ebiten/v2"
	"github.com/hajimehoshi/ebiten/v2/inpututil"
	"golang.org/x/image/font"
	"golang.org/x/image/font/opentype"
	"golang.org/x/image/math/fixed"
)

// The content warning shown before the game starts. The game (and its
// music) only starts once the player presses the confirm button.

const (
	warningTitle  = "주의사항"
	warningButton = "확인"
)

var warningBody = []string{
	"인터넷에 올리거나 공공장소에서의 플레이는 자제해주세요.",
	"이 게임은 고어한 사진을 포함되어 있으며 불쾌감을 일으킬 수 있습니다.",
	"이해하고 확인 버튼을 클릭하면 게임을 시작합니다.",
}

//go:embed fonts/NanumGothicBold.ttf
var fontData []byte

type warningScreen struct {
	font     *opentype.Font
	img      *ebiten.Image
	w, h     int
	button   image.Rectangle
	hover    bool
	drawnFor [3]int // w, h, hover
}

func newWarningScreen() *warningScreen {
	f, err := opentype.Parse(fontData)
	if err != nil {
		panic(err)
	}
	return &warningScreen{font: f}
}

func (ws *warningScreen) face(px float64) font.Face {
	fc, err := opentype.NewFace(ws.font, &opentype.FaceOptions{Size: px, DPI: 72, Hinting: font.HintingFull})
	if err != nil {
		panic(err)
	}
	return fc
}

// confirmed reports whether the player accepted the warning this frame.
func (ws *warningScreen) confirmed() bool {
	if ebiten.IsKeyPressed(ebiten.KeyAlt) {
		return false // Alt+Enter toggles full screen
	}
	for _, k := range []ebiten.Key{ebiten.KeyEnter, ebiten.KeyNumpadEnter, ebiten.KeySpace, ebiten.KeyZ} {
		if inpututil.IsKeyJustPressed(k) {
			return true
		}
	}
	for _, id := range ebiten.AppendGamepadIDs(nil) {
		for _, b := range []ebiten.StandardGamepadButton{ebiten.StandardGamepadButtonRightBottom, ebiten.StandardGamepadButtonRightRight, ebiten.StandardGamepadButtonCenterRight} {
			if inpututil.IsStandardGamepadButtonJustPressed(id, b) {
				return true
			}
		}
	}
	mx, my := ebiten.CursorPosition()
	p := image.Pt(mx, my)
	ws.hover = p.In(ws.button)
	if ws.hover && inpututil.IsMouseButtonJustPressed(ebiten.MouseButtonLeft) {
		return true
	}
	for _, id := range inpututil.AppendJustPressedTouchIDs(nil) {
		x, y := ebiten.TouchPosition(id)
		if image.Pt(x, y).In(ws.button) {
			return true
		}
	}
	return false
}

// wrap splits text into lines that fit width (breaking at spaces when
// possible, otherwise between characters).
func wrap(fc font.Face, text string, width int) []string {
	var lines []string
	for _, para := range strings.Split(text, "\n") {
		line := ""
		for _, word := range strings.SplitAfter(para, " ") {
			if font.MeasureString(fc, line+word).Ceil() <= width {
				line += word
				continue
			}
			if line != "" {
				lines = append(lines, strings.TrimRight(line, " "))
				line = ""
			}
			for _, r := range word { // a single word longer than the line
				if font.MeasureString(fc, line+string(r)).Ceil() > width && line != "" {
					lines = append(lines, line)
					line = ""
				}
				line += string(r)
			}
		}
		lines = append(lines, strings.TrimRight(line, " "))
	}
	return lines
}

func drawText(dst *image.RGBA, fc font.Face, s string, x, y int, c color.Color) {
	d := &font.Drawer{Dst: dst, Src: image.NewUniform(c), Face: fc, Dot: fixed.P(x, y)}
	d.DrawString(s)
}

func fillRect(dst *image.RGBA, r image.Rectangle, c color.Color) {
	draw.Draw(dst, r, image.NewUniform(c), image.Point{}, draw.Src)
}

// render redraws the screen for a w x h canvas (only when something changed).
func (ws *warningScreen) render(w, h int) *ebiten.Image {
	hv := 0
	if ws.hover {
		hv = 1
	}
	if ws.img != nil && ws.drawnFor == [3]int{w, h, hv} {
		return ws.img
	}
	ws.drawnFor = [3]int{w, h, hv}
	cv := image.NewRGBA(image.Rect(0, 0, w, h))
	fillRect(cv, cv.Rect, color.RGBA{14, 14, 18, 255})

	unit := float64(min(w, h*4/3)) / 40 // scales with the window
	cardW := int(unit * 34)
	pad := int(unit * 2)
	titleFace := ws.face(unit * 2.4)
	bodyFace := ws.face(unit * 1.25)
	btnFace := ws.face(unit * 1.4)
	defer titleFace.Close()
	defer bodyFace.Close()
	defer btnFace.Close()

	var lines []string
	for i, p := range warningBody {
		if i > 0 {
			lines = append(lines, "")
		}
		lines = append(lines, wrap(bodyFace, p, cardW-2*pad)...)
	}
	lineH := int(unit * 2.0)
	titleH := int(unit * 3.4)
	btnW, btnH := int(unit*9), int(unit*3)
	cardH := pad + titleH + len(lines)*lineH + pad + btnH + pad
	x0, y0 := (w-cardW)/2, (h-cardH)/2
	card := image.Rect(x0, y0, x0+cardW, y0+cardH)
	fillRect(cv, card, color.RGBA{30, 30, 36, 255})
	fillRect(cv, image.Rect(card.Min.X, card.Min.Y, card.Max.X, card.Min.Y+int(unit*0.35)), color.RGBA{245, 190, 40, 255})

	// title with a warning sign
	ty := y0 + pad + int(unit*2.2)
	tri := int(unit * 2.2)
	tx := x0 + pad
	for i := 0; i < tri; i++ { // filled triangle
		half := i / 2
		fillRect(cv, image.Rect(tx+tri/2-half, ty-tri+i, tx+tri/2+half+1, ty-tri+i+1), color.RGBA{245, 190, 40, 255})
	}
	drawText(cv, ws.face(unit*1.7), "!", tx+tri/2-int(unit*0.3), ty-int(unit*0.15), color.RGBA{30, 30, 36, 255})
	drawText(cv, titleFace, warningTitle, tx+tri+int(unit*0.8), ty, color.RGBA{245, 190, 40, 255})

	y := y0 + pad + titleH
	for _, l := range lines {
		y += lineH
		drawText(cv, bodyFace, l, x0+pad, y-int(unit*0.5), color.RGBA{232, 232, 236, 255})
	}

	bx := x0 + (cardW-btnW)/2
	by := y0 + cardH - pad - btnH
	ws.button = image.Rect(bx, by, bx+btnW, by+btnH)
	bc := color.RGBA{200, 50, 45, 255}
	if ws.hover {
		bc = color.RGBA{230, 70, 60, 255}
	}
	fillRect(cv, ws.button, bc)
	tw := font.MeasureString(btnFace, warningButton).Ceil()
	drawText(cv, btnFace, warningButton, bx+(btnW-tw)/2, by+btnH/2+int(unit*0.5), color.White)

	if ws.img == nil || ws.w != w || ws.h != h {
		if ws.img != nil {
			ws.img.Deallocate()
		}
		ws.img = ebiten.NewImage(w, h)
		ws.w, ws.h = w, h
	}
	ws.img.WritePixels(cv.Pix)
	return ws.img
}
