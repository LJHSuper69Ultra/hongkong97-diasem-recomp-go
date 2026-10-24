package recomp

// Extensions: code that is not in the original ROM.
//
// The recompiled jump tables (JMP (table,X)) fall back to jumpExt for an
// index the ROM table does not have. An extension registers a handler for
// (table, X); the handler sets up registers like the code it imitates and
// returns the address to continue at.

type jumpHandler func(m *Machine) uint32

var jumpExts = map[uint32]map[uint16]jumpHandler{}

func addJump(table uint32, x uint16, h jumpHandler) {
	if jumpExts[table] == nil {
		jumpExts[table] = map[uint16]jumpHandler{}
	}
	jumpExts[table][x] = h
}

func (m *Machine) jumpExt(table uint32) uint32 {
	if h, ok := jumpExts[table][m.X]; ok {
		return h(m)
	}
	badTarget(table)
	return 0
}

// asset returns the address tools/pack gave an asset that only the
// extensions use (not referenced by the original code).
func (m *Machine) asset(name string) uint32 {
	a, ok := m.syms[name]
	if !ok {
		panic("recomp: no address for asset " + name + " (rebuild romdata with tools/pack)")
	}
	return a
}
