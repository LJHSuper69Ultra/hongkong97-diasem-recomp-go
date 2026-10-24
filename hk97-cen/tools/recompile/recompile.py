#!/usr/bin/env python3
"""Static recompiler: Hong Kong 97 65816 code -> Go (recomp/gen.go).

Inputs: the ROM, the traced listing (instruction addresses + M/X state) and
optionally an execution-coverage file from the reference emulator, whose
recorded M/X flags take precedence. Only instruction *addresses and lengths*
come from these; operands are decoded from the ROM here and baked into Go.
"""
import re
import sys
from collections import defaultdict

sys.path.insert(0, sys.argv[4])
from d65 import OPS, size  # noqa: E402

rom = open(sys.argv[1], 'rb').read()
listing = sys.argv[2]
covfile = sys.argv[3]
out = sys.argv[5]
codemap_out = sys.argv[6] if len(sys.argv) > 6 else None
manifest = sys.argv[7] if len(sys.argv) > 7 else None
from relocs import find_relocs  # noqa: E402
RELOCS = find_relocs(listing, manifest, rom) if manifest else {}
reloc_index = {}   # (name, off, kind) -> index
reloc_list = []    # (name, off, orig24)
cur = {'rel': None}


def rel(kind):
    r = cur['rel']
    if not r or r[0] != kind:
        return None
    key = (r[1], r[2])
    if key not in reloc_index:
        reloc_index[key] = len(reloc_list)
        reloc_list.append((r[1], r[2]))
    return reloc_index[key]

# Jump tables used by JMP (abs,X): baked into the generated code as switches.
JUMP_TABLES = {0x9DD3: 4, 0x9DEB: 4, 0xA7FF: 4, 0xAC94: 4, 0xAE62: 3, 0xBCED: 3, 0xBD1E: 3,
               0xBD4F: 3, 0xBDE1: 6, 0xC536: 3, 0xC567: 3, 0xC598: 3, 0xC5C9: 3}
# Tables of code addresses that the program reads as data (object handler
# bank bytes $80:8ABA and handler pointers $80:8AC9); emitted as Go data.
CODE_DATA = [(0x808ABA, 15), (0x808AC9, 30)]


def off(a):
    return ((a >> 16) & 0x7F) * 0x8000 + (a & 0x7FFF)


instrs = {}  # addr -> (m8, x8)
for l in open(listing):
    mm = re.match(r'([0-9A-F]{2}):([0-9A-F]{4})  (?:[0-9a-f]{2} )+\s+([mM])([xX])', l)
    if mm:
        a = (int(mm.group(1), 16) & 0x7F) << 16 | int(mm.group(2), 16)
        instrs[a] = (mm.group(3) == 'm', mm.group(4) == 'x')
cov = defaultdict(set)
for l in open(covfile):
    a, f = l.split()
    cov[int(a, 16) & 0x7FFFFF].add(int(f, 16))
for a, fs in cov.items():
    if len(fs) == 1:
        f = next(iter(fs))
        instrs[a] = (bool(f & 0x20), bool(f & 0x10))
    elif a not in instrs:
        f = next(iter(fs))
        instrs[a] = (bool(f & 0x20), bool(f & 0x10))

# decode
dec = {}
for a, (m8, x8) in sorted(instrs.items()):
    o = off(a)
    c = rom[o]
    mn, md = OPS[c]
    n = size(md, m8, x8)
    v = int.from_bytes(rom[o + 1:o + n], 'little')
    dec[a] = (c, mn, md, n, v)

# overlap check
addrs = sorted(dec)
for i in range(len(addrs) - 1):
    a = addrs[i]
    if a + dec[a][3] > addrs[i + 1] and (a >> 16) == (addrs[i + 1] >> 16):
        raise SystemExit('overlap %06X / %06X' % (a, addrs[i + 1]))


def h(v, w):
    return '0x%0*X' % (w, v)


def ea(md, v):
    k = rel('abs16') if md in ('abs', 'absx', 'absy') else rel('long24') if md in ('absl', 'abslx') else None
    if k is not None:
        e = 'm.rel16(%d)' % k if md in ('abs', 'absx', 'absy') else 'm.rel24(%d)' % k
        return {'abs': 'm.eABS(%s)', 'absx': 'm.eABSX(%s)', 'absy': 'm.eABSY(%s)',
                'absl': '%s', 'abslx': 'm.eABSLX(%s)'}[md] % e
    return {
        'dp': 'm.eDP(%s)' % h(v, 2), 'dpx': 'm.eDPX(%s)' % h(v, 2), 'dpy': 'm.eDPY(%s)' % h(v, 2),
        'idp': 'm.eIDP(%s)' % h(v, 2), 'idx': 'm.eIDX(%s)' % h(v, 2), 'idy': 'm.eIDY(%s)' % h(v, 2),
        'idl': 'm.eIDL(%s)' % h(v, 2), 'idly': 'm.eIDLY(%s)' % h(v, 2),
        'abs': 'm.eABS(%s)' % h(v, 4), 'absx': 'm.eABSX(%s)' % h(v, 4), 'absy': 'm.eABSY(%s)' % h(v, 4),
        'absl': 'uint32(%s)' % h(v, 6), 'abslx': 'm.eABSLX(%s)' % h(v, 6),
        'sr': 'm.eSR(%s)' % h(v, 2), 'sry': 'm.eSRY(%s)' % h(v, 2),
    }[md]


def valM(md, v):
    if md in ('immM', 'immX', 'imm8'):
        for kind, fmt in (('imm16', 'm.rel16(%d)'), ('imm8bank', 'uint16(m.relBank(%d))'),
                          ('imm8lo', '(m.rel16(%d) & 0xFF)'), ('imm8hi', '(m.rel16(%d) >> 8)')):
            k = rel(kind)
            if k is not None:
                return fmt % k
        return 'uint16(%s)' % h(v, 4)
    return 'm.ldM(%s)' % ea(md, v)


def valX(md, v):
    if md in ('immM', 'immX', 'imm8'):
        return 'uint16(%s)' % h(v, 4)
    return 'm.ldX(%s)' % ea(md, v)


BR = {'BPL': 'm.P&fN == 0', 'BMI': 'm.P&fN != 0', 'BVC': 'm.P&fV == 0', 'BVS': 'm.P&fV != 0',
      'BCC': 'm.P&fC == 0', 'BCS': 'm.P&fC != 0', 'BNE': 'm.P&fZ == 0', 'BEQ': 'm.P&fZ != 0'}


def gen(a, c, mn, md, n, v):
    """Return (lines, terminates)."""
    bank = a & 0xFF0000
    nxt = bank | ((a + n) & 0xFFFF)
    L = []
    t = False
    if mn == 'LDA':
        L.append('m.setA(%s)' % valM(md, v))
    elif mn == 'LDX':
        L.append('m.setXr(%s)' % valX(md, v))
    elif mn == 'LDY':
        L.append('m.setYr(%s)' % valX(md, v))
    elif mn == 'STA':
        L.append('m.stM(%s, m.A)' % ea(md, v))
    elif mn == 'STX':
        L.append('m.stX(%s, m.X)' % ea(md, v))
    elif mn == 'STY':
        L.append('m.stX(%s, m.Y)' % ea(md, v))
    elif mn == 'STZ':
        L.append('m.stM(%s, 0)' % ea(md, v))
    elif mn == 'ORA':
        L.append('m.setA(m.A | %s)' % valM(md, v))
    elif mn == 'AND':
        L.append('m.and(%s)' % valM(md, v))
    elif mn == 'EOR':
        L.append('m.setA(m.A ^ %s)' % valM(md, v))
    elif mn == 'ADC':
        L.append('m.adc(%s)' % valM(md, v))
    elif mn == 'SBC':
        L.append('m.sbc(%s)' % valM(md, v))
    elif mn == 'CMP':
        L.append('m.cmpA(%s)' % valM(md, v))
    elif mn == 'CPX':
        L.append('m.cpx(%s)' % valX(md, v))
    elif mn == 'CPY':
        L.append('m.cpy(%s)' % valX(md, v))
    elif mn == 'BIT':
        if md == 'immM':
            L.append('m.bitImm(%s)' % h(v, 4))
        else:
            L.append('m.bitMem(%s)' % ea(md, v))
    elif mn in ('TSB', 'TRB'):
        L.append('m.tsb(%s, %s)' % (ea(md, v), 'true' if mn == 'TSB' else 'false'))
    elif mn in ('ASL', 'LSR', 'ROL', 'ROR', 'INC', 'DEC'):
        f = 'm.' + mn.lower()
        if md == 'imp':
            L.append('m.setA(%s(m.accM()))' % f)
        else:
            L.append('m.rmw(%s, %s)' % (ea(md, v), f))
    elif mn == 'INX':
        L.append('m.setXr(m.X + 1)')
    elif mn == 'INY':
        L.append('m.setYr(m.Y + 1)')
    elif mn == 'DEX':
        L.append('m.setXr(m.X - 1)')
    elif mn == 'DEY':
        L.append('m.setYr(m.Y - 1)')
    elif mn == 'TAX':
        L.append('m.setXr(m.A)')
    elif mn == 'TAY':
        L.append('m.setYr(m.A)')
    elif mn == 'TXA':
        L.append('m.setA(m.X)')
    elif mn == 'TYA':
        L.append('m.setA(m.Y)')
    elif mn == 'TXY':
        L.append('m.setYr(m.X)')
    elif mn == 'TYX':
        L.append('m.setXr(m.Y)')
    elif mn == 'TSX':
        L.append('m.setXr(m.S)')
    elif mn == 'TXS':
        L.append('m.txs()')
    elif mn == 'TCD':
        L.append('m.D = m.A; m.nz16(m.D)')
    elif mn == 'TDC':
        L.append('m.A = m.D; m.nz16(m.A)')
    elif mn == 'TCS':
        L.append('m.tcs()')
    elif mn == 'TSC':
        L.append('m.A = m.S; m.nz16(m.A)')
    elif mn == 'XBA':
        L.append('m.A = m.A>>8 | m.A<<8; m.nz8(uint8(m.A))')
    elif mn == 'PHA':
        L.append('m.pushM(m.A)')
    elif mn == 'PLA':
        L.append('m.setA(m.pullM())')
    elif mn == 'PHX':
        L.append('m.pushX(m.X)')
    elif mn == 'PLX':
        L.append('m.setXr(m.pullX())')
    elif mn == 'PHY':
        L.append('m.pushX(m.Y)')
    elif mn == 'PLY':
        L.append('m.setYr(m.pullX())')
    elif mn == 'PHP':
        L.append('m.push(m.P)')
    elif mn == 'PLP':
        L.append('m.setP(m.pull())')
    elif mn == 'PHB':
        L.append('m.push(m.DB)')
    elif mn == 'PLB':
        L.append('m.DB = m.pull(); m.nz8(m.DB)')
    elif mn == 'PHK':
        L.append('m.push(m.PB)')
    elif mn == 'PHD':
        L.append('m.push16(m.D)')
    elif mn == 'PLD':
        L.append('m.D = m.pull16(); m.nz16(m.D)')
    elif mn == 'PEA':
        L.append('m.push16(%s)' % h(v, 4))
    elif mn == 'PEI':
        L.append('m.push16(m.rd16(m.eDP(%s)))' % h(v, 2))
    elif mn == 'PER':
        tgt = (a + 3 + (v - 0x10000 if v & 0x8000 else v)) & 0xFFFF
        L.append('m.push16(%s)' % h(tgt, 4))
    elif mn in ('CLC', 'SEC', 'CLI', 'SEI', 'CLD', 'SED', 'CLV'):
        fl = {'C': 'fC', 'I': 'fI', 'D': 'fD', 'V': 'fV'}[mn[2]]
        L.append(('m.P |= %s' if mn[0] == 'S' else 'm.P &^= %s') % fl)
    elif mn == 'REP':
        L.append('m.setP(m.P &^ %s)' % h(v, 2))
    elif mn == 'SEP':
        L.append('m.setP(m.P | %s)' % h(v, 2))
    elif mn == 'XCE':
        L.append('m.xce()')
    elif mn in ('NOP', 'WDM'):
        pass
    elif mn in ('MVN', 'MVP'):
        L.append('m.mvn(%s, %s, %s)' % (h(v & 0xFF, 2), h(v >> 8, 2), '1' if mn == 'MVN' else '0xFFFF'))
    elif mn in BR:
        tgt = bank | ((a + 2 + (v - 256 if v > 127 else v)) & 0xFFFF)
        L.append('if %s {\n\t\t\t\tpc = %s\n\t\t\t\tcontinue\n\t\t\t}' % (BR[mn], h(tgt, 6)))
    elif mn == 'BRA':
        tgt = bank | ((a + 2 + (v - 256 if v > 127 else v)) & 0xFFFF)
        L.append('pc = %s\n\t\t\tcontinue' % h(tgt, 6)); t = True
    elif mn == 'BRL':
        tgt = bank | ((a + 3 + (v - 0x10000 if v > 0x7FFF else v)) & 0xFFFF)
        L.append('pc = %s\n\t\t\tcontinue' % h(tgt, 6)); t = True
    elif mn == 'JMP' and md == 'abs':
        L.append('pc = %s\n\t\t\tcontinue' % h(bank | v, 6)); t = True
    elif mn == 'JMP' and md == 'ind':
        L.append('pc = %s | uint32(m.rd16(%s))\n\t\t\tcontinue' % (h(bank, 6), h(v, 4))); t = True
    elif mn == 'JMP' and md == 'iax':
        n = JUMP_TABLES[v]
        cases = []
        for k in range(n):
            tgt = rom[off(bank | v) + 2 * k] | rom[off(bank | v) + 2 * k + 1] << 8
            cases.append('case %d:\n\t\t\t\tpc = %s' % (2 * k, h(bank | tgt, 6)))
        L.append('switch m.X {\n\t\t\t' + '\n\t\t\t'.join(cases) + '\n\t\t\tdefault:\n\t\t\t\tpc = m.jumpExt(%s) // entries added outside the ROM (recomp/ext.go)\n\t\t\t}\n\t\t\tcontinue' % h(bank | v, 6)); t = True
    elif mn == 'JML' and md == 'absl':
        L.append('m.PB = %s\n\t\t\tpc = %s\n\t\t\tcontinue' % (h(v >> 16, 2), h(v & 0x7FFFFF, 6))); t = True
    elif mn == 'JML' and md == 'ial':
        L.append('m.PB = m.rd(%s)\n\t\t\tpc = uint32(m.PB&0x7F)<<16 | uint32(m.rd16(%s))\n\t\t\tcontinue' % (h(v + 2, 4), h(v, 4))); t = True
    elif mn == 'JSR' and md == 'abs':
        L.append('m.push16(%s)\n\t\t\tpc = %s\n\t\t\tcontinue' % (h((a + 2) & 0xFFFF, 4), h(bank | v, 6))); t = True
    elif mn == 'JSR' and md == 'iax':
        L.append('m.push16(%s)\n\t\t\tpc = %s | uint32(m.rd16(uint32(m.PB)<<16 | uint32(uint16(%s)+m.X)))\n\t\t\tcontinue' % (h((a + 2) & 0xFFFF, 4), h(bank, 6), h(v, 4))); t = True
    elif mn == 'JSL':
        L.append('m.push(m.PB)\n\t\t\tm.push16(%s)\n\t\t\tm.PB = %s\n\t\t\tpc = %s\n\t\t\tcontinue' % (h((a + 3) & 0xFFFF, 4), h(v >> 16, 2), h(v & 0x7FFFFF, 6))); t = True
    elif mn == 'RTS':
        L.append('pc = uint32(m.PB&0x7F)<<16 | uint32(m.pull16()+1)\n\t\t\tcontinue'); t = True
    elif mn == 'RTL':
        L.append('pc = uint32(m.pull16() + 1)\n\t\t\tm.PB = m.pull()\n\t\t\tpc |= uint32(m.PB&0x7F) << 16\n\t\t\tcontinue'); t = True
    elif mn == 'RTI':
        L.append('m.setP(m.pull())\n\t\t\tm.pull16()\n\t\t\tif !m.E {\n\t\t\t\tm.PB = m.pull()\n\t\t\t}\n\t\t\treturn'); t = True
    else:
        L.append('panic("unsupported %s at %06X")' % (mn, a)); t = True
    return L, t


SPECIAL = {
    # entry of the vblank wait routine: verification hook
    0x0083C3: 'if m.OnBoundary != nil {\n\t\t\t\tm.OnBoundary()\n\t\t\t}',
    # busy-wait on the NMI counter: hand the frame to the host and run the NMI
    0x0083D6: 'if !m.inNMI {\n\t\t\t\tm.vblank(0x83D6)\n\t\t\t}',
}

src = []
src.append('// Code generated by tools/recompile.py from the Hong Kong 97 ROM. DO NOT EDIT.\n')
src.append('// Each case is one original 65816 instruction, labelled by its SNES address.\n\n')
src.append('package recomp\n\n')
src.append('func (m *Machine) run(pc uint32) {\n\tfor {\n\t\tswitch pc {\n')
addrs = sorted(dec)
for i, a in enumerate(addrs):
    c, mn, md, n, v = dec[a]
    cur['rel'] = RELOCS.get(a)
    lines, term = gen(a, c, mn, md, n, v)
    if cur['rel'] and (cur['rel'][1], cur['rel'][2]) not in reloc_index:
        raise SystemExit('relocation at %06X was not used by the generator' % a)
    raw = rom[off(a):off(a) + n].hex(' ')
    src.append('\t\tcase %s: // %02X:%04X  %-12s %s\n' % (h(a, 6), a >> 16, a & 0xFFFF, raw, mn))
    if a in SPECIAL:
        src.append('\t\t\t' + SPECIAL[a] + '\n')
    for ln in lines:
        src.append('\t\t\t' + ln + '\n')
    if not term:
        nxt = (a & 0xFF0000) | ((a + n) & 0xFFFF)
        if i + 1 < len(addrs) and addrs[i + 1] == nxt:
            src.append('\t\t\tfallthrough\n')
        else:
            src.append('\t\t\tpc = %s\n\t\t\tcontinue\n' % h(nxt, 6))
src.append('\t\tdefault:\n\t\t\tbadTarget(pc)\n\t\t}\n\t}\n}\n')
src.append('\n// relocs: code operands that refer to assets, resolved at start-up from the\n// final asset addresses chosen by tools/pack (see Machine.New).\n')
src.append('var relocs = []reloc{\n')
import json as _json
_orig = {i['name']: int(i['addr'].replace(':', ''), 16) for i in _json.load(open(manifest))['items'] if 'addr' in i} if manifest else {}
for name, o in reloc_list:
    src.append('\t{"%s", %d, 0x%06X},\n' % (name, o, _orig[name]))
src.append('}\n')
src.append('\n// codeData holds tables of code addresses that the program reads as data.\n')
src.append('var codeData = []struct {\n\tAddr uint32\n\tData []byte\n}{\n')
for a, n in CODE_DATA:
    bs = rom[off(a):off(a) + n]
    src.append('\t{%s, []byte{%s}},\n' % (h(a, 6), ', '.join('0x%02X' % x for x in bs)))
src.append('}\n')
open(out, 'w').write(''.join(src))
if codemap_out:
    ranges = [(off(a), off(a) + dec[a][3]) for a in addrs]
    ranges += [(off(0x800000 | t), off(0x800000 | t) + 2 * n) for t, n in JUMP_TABLES.items()]
    ranges += [(off(a), off(a) + n) for a, n in CODE_DATA]
    ranges.sort()
    merged = []
    for a, b in ranges:
        if merged and a <= merged[-1][1]:
            merged[-1][1] = max(merged[-1][1], b)
        else:
            merged.append([a, b])
    with open(codemap_out, 'w') as f:
        f.write('# ROM byte ranges [start,end) that hold code or code tables (file offsets)\n')
        for a, b in merged:
            f.write('%05X %05X\n' % (a, b))
print('instructions:', len(addrs))
