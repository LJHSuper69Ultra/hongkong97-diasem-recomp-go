package assetfmt

import (
	"encoding/json"
	"fmt"
	"strconv"
	"strings"
)

// Table is a JSON-described array of fixed-layout records:
//
//	{ "comment": "...", "fields": [["x","s16"],["y","s16"]], "rows": [{"x":16,"y":-8}, ...],
//	  "terminator": "FF" }
//
// Field types: u8 s8 u16 s16 (decimal numbers) and x8 x16 (hex strings).
type Table struct {
	Comment    string           `json:"comment,omitempty"`
	Fields     [][2]string      `json:"fields"`
	Rows       []map[string]any `json:"rows"`
	Terminator string           `json:"terminator,omitempty"`
	// Layout "columns": stored as parallel arrays (all values of the first
	// field, then all of the second, ...). Default: one record after another.
	Layout string `json:"layout,omitempty"`
}

func fieldSize(t string) (int, error) {
	switch t {
	case "u8", "s8", "x8":
		return 1, nil
	case "u16", "s16", "x16":
		return 2, nil
	}
	return 0, fmt.Errorf("unknown field type %q", t)
}

// DecodeTable reads n records (and an optional terminator) from b.
func DecodeTable(b []byte, comment string, fields [][2]string, n int, term []byte) (*Table, error) {
	t := &Table{Comment: comment, Fields: fields}
	o := 0
	for i := 0; i < n; i++ {
		row := map[string]any{}
		for _, f := range fields {
			sz, err := fieldSize(f[1])
			if err != nil {
				return nil, err
			}
			v := int(b[o])
			if sz == 2 {
				v |= int(b[o+1]) << 8
			}
			switch f[1] {
			case "s8":
				row[f[0]] = int(int8(v))
			case "s16":
				row[f[0]] = int(int16(v))
			case "x8":
				row[f[0]] = fmt.Sprintf("0x%02X", v)
			case "x16":
				row[f[0]] = fmt.Sprintf("0x%04X", v)
			default:
				row[f[0]] = v
			}
			o += sz
		}
		t.Rows = append(t.Rows, row)
	}
	if len(term) > 0 {
		t.Terminator = fmt.Sprintf("%X", term)
	}
	return t, nil
}

func (t *Table) Size() int {
	n := 0
	for _, f := range t.Fields {
		s, _ := fieldSize(f[1])
		n += s
	}
	return n*len(t.Rows) + len(t.Terminator)/2
}

func num(v any) (int, error) {
	switch x := v.(type) {
	case float64:
		return int(x), nil
	case json.Number:
		i, err := x.Int64()
		return int(i), err
	case int:
		return x, nil
	case string:
		i, err := strconv.ParseInt(strings.TrimPrefix(strings.ToLower(x), "0x"), 16, 32)
		return int(i), err
	}
	return 0, fmt.Errorf("not a number: %v", v)
}

// Encode serializes the table.
func (t *Table) Encode() ([]byte, error) {
	if t.Layout == "columns" {
		var out []byte
		for _, f := range t.Fields {
			for i, row := range t.Rows {
				n, err := num(row[f[0]])
				if err != nil {
					return nil, fmt.Errorf("row %d field %s: %v", i, f[0], err)
				}
				out = append(out, byte(n))
				if sz, _ := fieldSize(f[1]); sz == 2 {
					out = append(out, byte(n>>8))
				}
			}
		}
		return out, nil
	}
	var out []byte
	for i, row := range t.Rows {
		for _, f := range t.Fields {
			v, ok := row[f[0]]
			if !ok {
				return nil, fmt.Errorf("row %d: missing field %q", i, f[0])
			}
			n, err := num(v)
			if err != nil {
				return nil, fmt.Errorf("row %d field %s: %v", i, f[0], err)
			}
			sz, err := fieldSize(f[1])
			if err != nil {
				return nil, err
			}
			out = append(out, byte(n))
			if sz == 2 {
				out = append(out, byte(n>>8))
			}
		}
	}
	if t.Terminator != "" {
		var term []byte
		for i := 0; i+1 < len(t.Terminator); i += 2 {
			v, err := strconv.ParseUint(t.Terminator[i:i+2], 16, 8)
			if err != nil {
				return nil, fmt.Errorf("bad terminator %q", t.Terminator)
			}
			term = append(term, byte(v))
		}
		out = append(out, term...)
	}
	return out, nil
}
