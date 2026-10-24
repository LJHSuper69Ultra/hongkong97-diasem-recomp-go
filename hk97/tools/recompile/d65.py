import sys
# 65816 disassembler for LoROM
ROM = open(sys.argv[1], 'rb').read() if __name__ == '__main__' else None

# mode codes: imp, imm8, immM, immX, dp, dpx, dpy, idp, idx(dp,x), idy (dp),y, idl [dp], idly [dp],y,
# abs, absx, absy, absl, abslx, ind (abs), iax (abs,x), ial [abs], rel, rell, sr, sry, bm(block move)
OPS = {}
def op(code, mn, mode): OPS[code] = (mn, mode)
tbl = """
00 BRK imm8|01 ORA idx|02 COP imm8|03 ORA sr|04 TSB dp|05 ORA dp|06 ASL dp|07 ORA idl|08 PHP imp|09 ORA immM|0A ASL imp|0B PHD imp|0C TSB abs|0D ORA abs|0E ASL abs|0F ORA absl
10 BPL rel|11 ORA idy|12 ORA idp|13 ORA sry|14 TRB dp|15 ORA dpx|16 ASL dpx|17 ORA idly|18 CLC imp|19 ORA absy|1A INC imp|1B TCS imp|1C TRB abs|1D ORA absx|1E ASL absx|1F ORA abslx
20 JSR abs|21 AND idx|22 JSL absl|23 AND sr|24 BIT dp|25 AND dp|26 ROL dp|27 AND idl|28 PLP imp|29 AND immM|2A ROL imp|2B PLD imp|2C BIT abs|2D AND abs|2E ROL abs|2F AND absl
30 BMI rel|31 AND idy|32 AND idp|33 AND sry|34 BIT dpx|35 AND dpx|36 ROL dpx|37 AND idly|38 SEC imp|39 AND absy|3A DEC imp|3B TSC imp|3C BIT absx|3D AND absx|3E ROL absx|3F AND abslx
40 RTI imp|41 EOR idx|42 WDM imm8|43 EOR sr|44 MVP bm|45 EOR dp|46 LSR dp|47 EOR idl|48 PHA imp|49 EOR immM|4A LSR imp|4B PHK imp|4C JMP abs|4D EOR abs|4E LSR abs|4F EOR absl
50 BVC rel|51 EOR idy|52 EOR idp|53 EOR sry|54 MVN bm|55 EOR dpx|56 LSR dpx|57 EOR idly|58 CLI imp|59 EOR absy|5A PHY imp|5B TCD imp|5C JML absl|5D EOR absx|5E LSR absx|5F EOR abslx
60 RTS imp|61 ADC idx|62 PER rell|63 ADC sr|64 STZ dp|65 ADC dp|66 ROR dp|67 ADC idl|68 PLA imp|69 ADC immM|6A ROR imp|6B RTL imp|6C JMP ind|6D ADC abs|6E ROR abs|6F ADC absl
70 BVS rel|71 ADC idy|72 ADC idp|73 ADC sry|74 STZ dpx|75 ADC dpx|76 ROR dpx|77 ADC idly|78 SEI imp|79 ADC absy|7A PLY imp|7B TDC imp|7C JMP iax|7D ADC absx|7E ROR absx|7F ADC abslx
80 BRA rel|81 STA idx|82 BRL rell|83 STA sr|84 STY dp|85 STA dp|86 STX dp|87 STA idl|88 DEY imp|89 BIT immM|8A TXA imp|8B PHB imp|8C STY abs|8D STA abs|8E STX abs|8F STA absl
90 BCC rel|91 STA idy|92 STA idp|93 STA sry|94 STY dpx|95 STA dpx|96 STX dpy|97 STA idly|98 TYA imp|99 STA absy|9A TXS imp|9B TXY imp|9C STZ abs|9D STA absx|9E STZ absx|9F STA abslx
A0 LDY immX|A1 LDA idx|A2 LDX immX|A3 LDA sr|A4 LDY dp|A5 LDA dp|A6 LDX dp|A7 LDA idl|A8 TAY imp|A9 LDA immM|AA TAX imp|AB PLB imp|AC LDY abs|AD LDA abs|AE LDX abs|AF LDA absl
B0 BCS rel|B1 LDA idy|B2 LDA idp|B3 LDA sry|B4 LDY dpx|B5 LDA dpx|B6 LDX dpy|B7 LDA idly|B8 CLV imp|B9 LDA absy|BA TSX imp|BB TYX imp|BC LDY absx|BD LDA absx|BE LDX absy|BF LDA abslx
C0 CPY immX|C1 CMP idx|C2 REP imm8|C3 CMP sr|C4 CPY dp|C5 CMP dp|C6 DEC dp|C7 CMP idl|C8 INY imp|C9 CMP immM|CA DEX imp|CB WAI imp|CC CPY abs|CD CMP abs|CE DEC abs|CF CMP absl
D0 BNE rel|D1 CMP idy|D2 CMP idp|D3 CMP sry|D4 PEI dp|D5 CMP dpx|D6 DEC dpx|D7 CMP idly|D8 CLD imp|D9 CMP absy|DA PHX imp|DB STP imp|DC JML ial|DD CMP absx|DE DEC absx|DF CMP abslx
E0 CPX immX|E1 SBC idx|E2 SEP imm8|E3 SBC sr|E4 CPX dp|E5 SBC dp|E6 INC dp|E7 SBC idl|E8 INX imp|E9 SBC immM|EA NOP imp|EB XBA imp|EC CPX abs|ED SBC abs|EE INC abs|EF SBC absl
F0 BEQ rel|F1 SBC idy|F2 SBC idp|F3 SBC sry|F4 PEA abs|F5 SBC dpx|F6 INC dpx|F7 SBC idly|F8 SED imp|F9 SBC absy|FA PLX imp|FB XCE imp|FC JSR iax|FD SBC absx|FE INC absx|FF SBC abslx
"""
for line in tbl.strip().split('\n'):
    for e in line.split('|'):
        c, mn, md = e.split()
        op(int(c, 16), mn, md)

def size(mode, m, x):
    return {'imp':1,'imm8':2,'immM':2 if m else 3,'immX':2 if x else 3,'dp':2,'dpx':2,'dpy':2,'idp':2,'idx':2,'idy':2,'idl':2,'idly':2,
            'abs':3,'absx':3,'absy':3,'absl':4,'abslx':4,'ind':3,'iax':3,'ial':3,'rel':2,'rell':3,'sr':2,'sry':2,'bm':3}[mode]

def off(addr):  # LoROM snes addr -> file offset
    bank = (addr >> 16) & 0x7F
    return bank * 0x8000 + (addr & 0x7FFF)

def dis(rom, addr, count, m=True, x=True, stop_rts=False):
    out = []
    for _ in range(count):
        o = off(addr)
        c = rom[o]
        mn, md = OPS[c]
        n = size(md, m, x)
        b = rom[o:o+n]
        v = int.from_bytes(b[1:], 'little') if n > 1 else 0
        bank = addr & 0xFF0000
        if md == 'imp': s = ''
        elif md in ('imm8','immM','immX'): s = '#$%0*X' % ((n-1)*2, v)
        elif md == 'dp': s = '$%02X' % v
        elif md == 'dpx': s = '$%02X,X' % v
        elif md == 'dpy': s = '$%02X,Y' % v
        elif md == 'idp': s = '($%02X)' % v
        elif md == 'idx': s = '($%02X,X)' % v
        elif md == 'idy': s = '($%02X),Y' % v
        elif md == 'idl': s = '[$%02X]' % v
        elif md == 'idly': s = '[$%02X],Y' % v
        elif md == 'abs': s = '$%04X' % v
        elif md == 'absx': s = '$%04X,X' % v
        elif md == 'absy': s = '$%04X,Y' % v
        elif md == 'absl': s = '$%06X' % v
        elif md == 'abslx': s = '$%06X,X' % v
        elif md == 'ind': s = '($%04X)' % v
        elif md == 'iax': s = '($%04X,X)' % v
        elif md == 'ial': s = '[$%04X]' % v
        elif md == 'rel':
            t = (addr + 2 + (v - 256 if v > 127 else v)) & 0xFFFF
            s = '$%04X' % t
        elif md == 'rell':
            t = (addr + 3 + (v - 65536 if v > 32767 else v)) & 0xFFFF
            s = '$%04X' % t
        elif md == 'sr': s = '$%02X,S' % v
        elif md == 'sry': s = '($%02X,S),Y' % v
        elif md == 'bm': s = '$%02X,$%02X' % (b[2], b[1])
        flags = ('m' if m else 'M') + ('x' if x else 'X')
        out.append('%02X:%04X  %-12s %s %-4s %s' % (addr >> 16, addr & 0xFFFF, b.hex(' '), flags, mn, s))
        if c == 0xC2:
            if v & 0x20: m = False
            if v & 0x10: x = False
        if c == 0xE2:
            if v & 0x20: m = True
            if v & 0x10: x = True
        addr = bank | ((addr + n) & 0xFFFF)
        if stop_rts and c in (0x60, 0x6B, 0x40):
            break
    return '\n'.join(out), m, x

if __name__ == '__main__':
    a = int(sys.argv[2], 16)
    n = int(sys.argv[3]) if len(sys.argv) > 3 else 60
    m = (sys.argv[4][0] == 'm') if len(sys.argv) > 4 else True
    x = (sys.argv[4][1] == 'x') if len(sys.argv) > 4 else True
    print(dis(ROM, a, n, m, x)[0])
