"""Find code operands that refer to assets (used by recompile.py).

Returns {instruction_addr: (kind, asset_name, offset)} where kind is
'abs16' (absolute operand), 'long24', 'imm16' (16-bit immediate pointer),
'imm8bank' (8-bit immediate bank byte), 'imm8lo' / 'imm8hi'.
"""
import json
import re


def find_relocs(listing_path, manifest_path, rom):
    from d65 import OPS
    man = json.load(open(manifest_path))

    def ad(s):
        b, a = s.split(':')
        return int(b, 16) << 16 | int(a, 16)
    items = [(ad(i['addr']), i['slot'], i['name'], i['kind']) for i in man['items'] if i['kind'] != 'raw' and not i.get('new')]
    by_addr = {(a & 0x7FFFFF): (n, k) for a, s, n, k in items}

    ins = []
    for l in open(listing_path):
        m = re.match(r'([0-9A-F]{2}):([0-9A-F]{4})  ((?:[0-9a-f]{2} )+)', l)
        if m:
            a = (int(m.group(1), 16) & 0x7F) << 16 | int(m.group(2), 16)
            ins.append((a, bytes.fromhex(m.group(3).replace(' ', ''))))
    relocs = {}

    def in_item(v, bank, kinds):
        for a, s, n, k in items:
            if (a >> 16) & 0x7F != bank & 0x7F or k not in kinds:
                continue
            lo = a & 0xFFFF
            if lo - 2 <= v < lo + s:
                return n, v - lo
        return None

    data_kinds = ('table', 'text', 'sprites')
    for i, (a, bs) in enumerate(ins):
        mn, md = OPS[bs[0]]
        if md in ('abs', 'absx', 'absy') and len(bs) == 3 and a >> 16 == 0:
            v = bs[1] | bs[2] << 8
            if v >= 0x8000:
                r = in_item(v, 0x80, data_kinds)
                if r:
                    relocs[a] = ('abs16',) + r
        if md in ('absl', 'abslx'):
            v = bs[1] | bs[2] << 8 | bs[3] << 16
            if (v & 0xFFFF) >= 0x8000 and (v >> 16) not in (0x7E, 0x7F):
                r = in_item(v & 0xFFFF, v >> 16, data_kinds + ('font',))
                if r:
                    relocs[a] = ('long24',) + r

    # immediate pointer patterns, tracked per straight-line sequence
    bank_imm = None   # (instr addr, value) of last LDA #imm8 -> STA $0E
    ptr_imm = None    # (instr addr, value) of last LDA #imm16 -> STA $0C
    pending = None
    for i, (a, bs) in enumerate(ins):
        mn, md = OPS[bs[0]]
        nxt = ins[i + 1][1] if i + 1 < len(ins) else b''
        if mn == 'LDA' and md == 'immM':
            v = bs[1] | (bs[2] << 8 if len(bs) == 3 else 0)
            if nxt[:2] == b'\x85\x0e' and len(bs) == 2:
                bank_imm = (a, v)
            elif nxt[:2] == b'\x85\x0c' and len(bs) == 3:
                ptr_imm = (a, v)
        if mn == 'JSR' and len(bs) == 3:
            t = bs[1] | bs[2] << 8
            if t == 0x9DA6 and ptr_imm and bank_imm:
                key = (bank_imm[1] << 16 | ptr_imm[1]) & 0x7FFFFF
                if key in by_addr and by_addr[key][1].startswith('lz_'):
                    relocs[bank_imm[0]] = ('imm8bank', by_addr[key][0], 0)
                    relocs[ptr_imm[0]] = ('imm16', by_addr[key][0], 0)
            elif t in (0xB869, 0xB7A2, 0xB722) and ptr_imm:
                key = 0x000000 | ptr_imm[1]
                if key in by_addr and by_addr[key][1] in ('text', 'table'):
                    relocs[ptr_imm[0]] = ('imm16', by_addr[key][0], 0)
    # language menu cursor: pointer stored as two bytes into $05E0/$0940 at $80:BC5D
    cur = [i for i in items if i[2] == 'language_cursor'][0][0] & 0xFFFF
    for i, (a, bs) in enumerate(ins):
        if bs[0] == 0xA9 and len(bs) == 2 and i + 1 < len(ins):
            nb = ins[i + 1][1]
            if nb[:3] == b'\x8d\xe0\x05' and bs[1] == cur & 0xFF and a == 0x00BC5D:
                relocs[a] = ('imm8lo', 'language_cursor', 0)
            if nb[:3] == b'\x8d\x40\x09' and bs[1] == cur >> 8 and a == 0x00BC62:
                relocs[a] = ('imm8hi', 'language_cursor', 0)
    return relocs


if __name__ == '__main__':
    import sys
    rom = open(sys.argv[1], 'rb').read()
    r = find_relocs(sys.argv[2], sys.argv[3], rom)
    from collections import Counter
    for a in sorted(r):
        print('%06X %s' % (a, r[a]))
    print(len(r), Counter(v[0] for v in r.values()))
    names = set(v[1] for v in r.values())
    man = json.load(open(sys.argv[3]))
    print('assets never referenced by code:', [i['name'] for i in man['items'] if i['name'] not in names and i['kind'] != 'raw'])
