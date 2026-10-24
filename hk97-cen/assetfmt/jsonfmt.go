package assetfmt

import (
	"bytes"
	"encoding/json"
	"fmt"
	"strings"
)

// node is an order-preserving JSON tree used for pretty printing.
type node struct {
	obj  bool
	keys []string
	kids []*node
	arr  bool
	raw  string // scalar
}

func parseNode(d *json.Decoder) (*node, error) {
	t, err := d.Token()
	if err != nil {
		return nil, err
	}
	switch v := t.(type) {
	case json.Delim:
		n := &node{obj: v == '{', arr: v == '['}
		for d.More() {
			if n.obj {
				kt, err := d.Token()
				if err != nil {
					return nil, err
				}
				n.keys = append(n.keys, kt.(string))
			}
			c, err := parseNode(d)
			if err != nil {
				return nil, err
			}
			n.kids = append(n.kids, c)
		}
		if _, err := d.Token(); err != nil {
			return nil, err
		}
		return n, nil
	default:
		if num, ok := v.(json.Number); ok {
			return &node{raw: num.String()}, nil
		}
		return &node{raw: marshalNoEscape(v)}, nil
	}
}

func (n *node) compact() string {
	if !n.obj && !n.arr {
		return n.raw
	}
	var sb strings.Builder
	open, close := "[", "]"
	if n.obj {
		open, close = "{", "}"
	}
	sb.WriteString(open)
	for i, k := range n.kids {
		if i > 0 {
			sb.WriteString(", ")
		}
		if n.obj {
			sb.WriteString(marshalNoEscape(n.keys[i]))
			sb.WriteString(": ")
		}
		sb.WriteString(k.compact())
	}
	sb.WriteString(close)
	return sb.String()
}

func (n *node) write(sb *strings.Builder, indent string, width int) {
	c := n.compact()
	if (!n.obj && !n.arr) || len(indent)+len(c) <= width {
		sb.WriteString(c)
		return
	}
	open, close := "[", "]"
	if n.obj {
		open, close = "{", "}"
	}
	sb.WriteString(open + "\n")
	in := indent + "  "
	for i, k := range n.kids {
		sb.WriteString(in)
		if n.obj {
			sb.WriteString(marshalNoEscape(n.keys[i]))
			sb.WriteString(": ")
		}
		k.write(sb, in, width)
		if i < len(n.kids)-1 {
			sb.WriteString(",")
		}
		sb.WriteString("\n")
	}
	sb.WriteString(indent + close)
}

// PrettyJSON re-indents JSON, keeping key order and putting any object or
// array that fits in `width` columns on one line.
func PrettyJSON(b []byte, width int) ([]byte, error) {
	d := json.NewDecoder(bytes.NewReader(b))
	d.UseNumber()
	n, err := parseNode(d)
	if err != nil {
		return nil, err
	}
	var sb strings.Builder
	n.write(&sb, "", width)
	sb.WriteString("\n")
	return []byte(sb.String()), nil
}

// MarshalJSON writes rows with keys in field order.
func (t *Table) MarshalJSON() ([]byte, error) {
	var b bytes.Buffer
	b.WriteString("{")
	if t.Comment != "" {
		c, _ := json.Marshal(t.Comment)
		fmt.Fprintf(&b, `"comment":%s,`, c)
	}
	if t.Layout != "" {
		fmt.Fprintf(&b, `"layout":%q,`, t.Layout)
	}
	f, _ := json.Marshal(t.Fields)
	fmt.Fprintf(&b, `"fields":%s,"rows":[`, f)
	for i, r := range t.Rows {
		if i > 0 {
			b.WriteString(",")
		}
		b.WriteString("{")
		for k, fl := range t.Fields {
			if k > 0 {
				b.WriteString(",")
			}
			v, _ := json.Marshal(r[fl[0]])
			fmt.Fprintf(&b, "%q:%s", fl[0], v)
		}
		b.WriteString("}")
	}
	b.WriteString("]")
	if t.Terminator != "" {
		fmt.Fprintf(&b, `,"terminator":%q`, t.Terminator)
	}
	b.WriteString("}")
	return b.Bytes(), nil
}

// UnmarshalJSON is the default decoding (needed because MarshalJSON exists).
func (t *Table) UnmarshalJSON(b []byte) error {
	type plain Table
	var p plain
	d := json.NewDecoder(bytes.NewReader(b))
	d.UseNumber()
	if err := d.Decode(&p); err != nil {
		return err
	}
	*t = Table(p)
	return nil
}

func marshalNoEscape(v any) string {
	var b bytes.Buffer
	e := json.NewEncoder(&b)
	e.SetEscapeHTML(false)
	e.Encode(v)
	return strings.TrimRight(b.String(), "\n")
}
