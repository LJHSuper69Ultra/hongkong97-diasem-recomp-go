package recomp

// Korean: a fourth language, $1252 = 3.
//
// The language menu is data-driven (assets/text/language_select.txt and
// the cursor table assets/menu/language_cursor.json, which now has four
// rows), so choosing the fourth row stores 3 in $1252. Every screen with
// translated text picks its text through a jump table indexed by $1252*2
// (0 = Japanese, 1 = Chinese, 2 = English). The Korean entries do what the
// Japanese ones do — LDA #text / STA $0C / JSR $B869 (16x16 renderer) /
// RTS — with the Korean text asset: they load A and continue at the
// Japanese entry's STA $0C. The Hangul glyphs are in the font extension
// (assets/font/hangul.png).

func init() {
	for _, e := range []struct {
		table uint32 // JMP (table,X)
		rep   uint8  // REP mask of the Japanese entry
		sta   uint32 // the Japanese entry's STA $0C
		text  string // Korean text asset
	}{
		{0x00BCED, 0x30, 0x00BD03, "text_ko_games_wanted"},
		{0x00BD1E, 0x30, 0x00BD34, "text_ko_dealers"},
		{0x00BD4F, 0x30, 0x00BD65, "text_ko_address"},
		{0x00C536, 0x30, 0x00C54C, "text_ko_story1"},
		{0x00C567, 0x30, 0x00C57D, "text_ko_story2"},
		{0x00C598, 0x30, 0x00C5AE, "text_ko_story3"},
		{0x00C5C9, 0x20, 0x00C5DF, "text_ko_story4"},
	} {
		e := e
		addJump(e.table, 6, func(m *Machine) uint32 {
			m.setP(m.P &^ e.rep)
			m.setA(uint16(m.asset(e.text))) // bank $80 (tools/pack place "bank80")
			return e.sta
		})
	}
}
