00:8000  78           mx SEI  
00:8001  18           mx CLC  
00:8002  fb           mx XCE  
00:8003  c2 20        mx REP  #$20
00:8005  a9 ff 1f     Mx LDA  #$1FFF
00:8008  1b           Mx TCS  
00:8009  c2 20        Mx REP  #$20
00:800B  a9 00 00     Mx LDA  #$0000
00:800E  5b           Mx TCD  
00:800F  e2 30        Mx SEP  #$30
00:8011  a9 80        mx LDA  #$80
00:8013  48           mx PHA  
00:8014  ab           mx PLB  
00:8015  e2 30        mx SEP  #$30
00:8017  a9 0f        mx LDA  #$0F
00:8019  85 06        mx STA  $06
00:801B  a2 00        mx LDX  #$00
00:801D  a0 00        mx LDY  #$00

L_00801F:   ; xref 008033
00:801F  bd 3a 80     mx LDA  $803A,X
00:8022  85 03        mx STA  $03
00:8024  bd 3b 80     mx LDA  $803B,X
00:8027  85 04        mx STA  $04
00:8029  bd 39 80     mx LDA  $8039,X
00:802C  91 03        mx STA  ($03),Y
00:802E  e8           mx INX  
00:802F  e8           mx INX  
00:8030  e8           mx INX  
00:8031  c6 06        mx DEC  $06
00:8033  d0 ea        mx BNE  $801F
00:8035  5c 66 80 80  mx JML  $808066
00:8066  e2 20        mx SEP  #$20
00:8068  a9 01        mx LDA  #$01
00:806A  8d 0d 42     mx STA  $420D
00:806D  20 db 82     mx JSR  $82DB
00:8070  20 9c 83     mx JSR  $839C
00:8073  20 c5 84     mx JSR  $84C5
00:8076  20 d1 9b     mx JSR  $9BD1
00:8079  20 82 9d     mx JSR  $9D82
00:807C  20 64 a0     mx JSR  $A064
00:807F  e2 30        mx SEP  #$30
00:8081  58           mx CLI  
00:8082  e2 30        mx SEP  #$30
00:8084  a9 17        mx LDA  #$17
00:8086  8d 2c 21     mx STA  $212C
00:8089  a9 13        mx LDA  #$13
00:808B  8d 2d 21     mx STA  $212D
00:808E  a9 ec        mx LDA  #$EC
00:8090  8d 32 21     mx STA  $2132
00:8093  9c 25 21     mx STZ  $2125
00:8096  a9 54        mx LDA  #$54
00:8098  8d 31 21     mx STA  $2131
00:809B  a9 02        mx LDA  #$02
00:809D  8d 30 21     mx STA  $2130
00:80A0  e2 30        mx SEP  #$30
00:80A2  64 9d        mx STZ  $9D
00:80A4  a9 80        mx LDA  #$80
00:80A6  8d 00 21     mx STA  $2100
00:80A9  c2 30        mx REP  #$30
00:80AB  64 25        MX STZ  $25
00:80AD  64 27        MX STZ  $27
00:80AF  e2 20        MX SEP  #$20
00:80B1  a9 ff        mX LDA  #$FF
00:80B3  9c 0d 21     mX STZ  $210D
00:80B6  9c 0d 21     mX STZ  $210D
00:80B9  8d 0e 21     mX STA  $210E
00:80BC  8d 0e 21     mX STA  $210E
00:80BF  9c 0f 21     mX STZ  $210F
00:80C2  9c 0f 21     mX STZ  $210F
00:80C5  8d 10 21     mX STA  $2110
00:80C8  8d 10 21     mX STA  $2110
00:80CB  9c 11 21     mX STZ  $2111
00:80CE  9c 11 21     mX STZ  $2111
00:80D1  8d 12 21     mX STA  $2112
00:80D4  8d 12 21     mX STA  $2112
00:80D7  20 c3 c8     mX JSR  $C8C3
00:80DA  e2 20        mX SEP  #$20
00:80DC  9c 00 21     mX STZ  $2100
00:80DF  20 b3 83     mX JSR  $83B3
00:80E2  e2 30        mX SEP  #$30
00:80E4  a9 84        mx LDA  #$84
00:80E6  85 0e        mx STA  $0E
00:80E8  a9 80        mx LDA  #$80
00:80EA  85 11        mx STA  $11
00:80EC  c2 20        mx REP  #$20
00:80EE  a9 e7 d4     Mx LDA  #$D4E7
00:80F1  85 0c        Mx STA  $0C
00:80F3  a9 c0 0b     Mx LDA  #$0BC0
00:80F6  85 0f        Mx STA  $0F
00:80F8  20 a6 9d     Mx JSR  $9DA6
00:80FB  20 b3 83     Mx JSR  $83B3
00:80FE  e2 30        Mx SEP  #$30
00:8100  a9 84        mx LDA  #$84
00:8102  85 0e        mx STA  $0E
00:8104  a9 7f        mx LDA  #$7F
00:8106  85 11        mx STA  $11
00:8108  c2 20        mx REP  #$20
00:810A  a9 00 86     Mx LDA  #$8600
00:810D  85 0c        Mx STA  $0C
00:810F  a9 00 90     Mx LDA  #$9000
00:8112  85 0f        Mx STA  $0F
00:8114  20 a6 9d     Mx JSR  $9DA6
00:8117  c2 20        Mx REP  #$20
00:8119  a9 00 90     Mx LDA  #$9000
00:811C  85 2d        Mx STA  $2D
00:811E  a9 00 00     Mx LDA  #$0000
00:8121  85 2f        Mx STA  $2F
00:8123  a9 00 40     Mx LDA  #$4000
00:8126  85 31        Mx STA  $31
00:8128  e2 20        Mx SEP  #$20
00:812A  a9 7f        mx LDA  #$7F
00:812C  85 2c        mx STA  $2C
00:812E  a9 01        mx LDA  #$01
00:8130  85 29        mx STA  $29
00:8132  a9 80        mx LDA  #$80
00:8134  85 2a        mx STA  $2A
00:8136  a9 18        mx LDA  #$18
00:8138  85 2b        mx STA  $2B
00:813A  20 ed 82     mx JSR  $82ED
00:813D  20 b3 83     mx JSR  $83B3
00:8140  e2 30        mx SEP  #$30
00:8142  a9 84        mx LDA  #$84
00:8144  85 0e        mx STA  $0E
00:8146  a9 80        mx LDA  #$80
00:8148  85 11        mx STA  $11
00:814A  c2 20        mx REP  #$20
00:814C  a9 25 a7     Mx LDA  #$A725
00:814F  85 0c        Mx STA  $0C
00:8151  a9 c0 0c     Mx LDA  #$0CC0
00:8154  85 0f        Mx STA  $0F
00:8156  20 a6 9d     Mx JSR  $9DA6
00:8159  20 b3 83     Mx JSR  $83B3
00:815C  c2 30        Mx REP  #$30
00:815E  a9 80 00     MX LDA  #$0080
00:8161  85 00        MX STA  $00
00:8163  a9 d8 00     MX LDA  #$00D8
00:8166  85 03        MX STA  $03
00:8168  a9 06 00     MX LDA  #$0006
00:816B  22 ef 9b 80  MX JSL  $809BEF
00:816F  e2 30        MX SEP  #$30
00:8171  a9 17        mx LDA  #$17
00:8173  8d 2c 21     mx STA  $212C
00:8176  a9 10        mx LDA  #$10
00:8178  8d 2d 21     mx STA  $212D
00:817B  a9 ec        mx LDA  #$EC
00:817D  8d 32 21     mx STA  $2132
00:8180  9c 25 21     mx STZ  $2125
00:8183  a9 50        mx LDA  #$50
00:8185  8d 31 21     mx STA  $2131
00:8188  a9 02        mx LDA  #$02
00:818A  8d 30 21     mx STA  $2130
00:818D  e2 30        mx SEP  #$30
00:818F  a9 14        mx LDA  #$14
00:8191  8d 2c 21     mx STA  $212C
00:8194  20 53 bc     mx JSR  $BC53
00:8197  e2 30        mx SEP  #$30
00:8199  a2 00        mx LDX  #$00

L_00819B:   ; xref 0081A5
00:819B  da           mx PHX  
00:819C  20 a1 9c     mx JSR  $9CA1
00:819F  e2 30        mx SEP  #$30
00:81A1  fa           mx PLX  
00:81A2  e8           mx INX  
00:81A3  e0 30        mx CPX  #$30
00:81A5  d0 f4        mx BNE  $819B
00:81A7  20 d1 82     mx JSR  $82D1

L_0081AA:   ; xref 0082CA
00:81AA  e2 30        mx SEP  #$30
00:81AC  a9 17        mx LDA  #$17
00:81AE  8d 2c 21     mx STA  $212C
00:81B1  a9 13        mx LDA  #$13
00:81B3  8d 2d 21     mx STA  $212D
00:81B6  a9 ec        mx LDA  #$EC
00:81B8  8d 32 21     mx STA  $2132
00:81BB  9c 25 21     mx STZ  $2125
00:81BE  a9 54        mx LDA  #$54
00:81C0  8d 31 21     mx STA  $2131
00:81C3  a9 02        mx LDA  #$02
00:81C5  8d 30 21     mx STA  $2130
00:81C8  e2 30        mx SEP  #$30
00:81CA  a9 07        mx LDA  #$07
00:81CC  8d 2c 21     mx STA  $212C
00:81CF  20 27 c0     mx JSR  $C027
00:81D2  e2 30        mx SEP  #$30
00:81D4  a9 84        mx LDA  #$84
00:81D6  85 0e        mx STA  $0E
00:81D8  a9 7f        mx LDA  #$7F
00:81DA  85 11        mx STA  $11
00:81DC  c2 20        mx REP  #$20
00:81DE  a9 00 86     Mx LDA  #$8600
00:81E1  85 0c        Mx STA  $0C
00:81E3  a9 00 90     Mx LDA  #$9000
00:81E6  85 0f        Mx STA  $0F
00:81E8  20 a6 9d     Mx JSR  $9DA6
00:81EB  c2 20        Mx REP  #$20
00:81ED  a9 00 90     Mx LDA  #$9000
00:81F0  85 2d        Mx STA  $2D
00:81F2  a9 00 00     Mx LDA  #$0000
00:81F5  85 2f        Mx STA  $2F
00:81F7  a9 00 40     Mx LDA  #$4000
00:81FA  85 31        Mx STA  $31
00:81FC  e2 20        Mx SEP  #$20
00:81FE  a9 7f        mx LDA  #$7F
00:8200  85 2c        mx STA  $2C
00:8202  a9 01        mx LDA  #$01
00:8204  85 29        mx STA  $29
00:8206  a9 80        mx LDA  #$80
00:8208  85 2a        mx STA  $2A
00:820A  a9 18        mx LDA  #$18
00:820C  85 2b        mx STA  $2B
00:820E  20 ed 82     mx JSR  $82ED
00:8211  20 b3 83     mx JSR  $83B3
00:8214  c2 30        mx REP  #$30
00:8216  a9 80 00     MX LDA  #$0080
00:8219  85 00        MX STA  $00
00:821B  a9 d8 00     MX LDA  #$00D8
00:821E  85 03        MX STA  $03
00:8220  a9 00 00     MX LDA  #$0000
00:8223  22 ef 9b 80  MX JSL  $809BEF
00:8227  e2 30        MX SEP  #$30
00:8229  a9 13        mx LDA  #$13
00:822B  8d 2c 21     mx STA  $212C
00:822E  a9 00        mx LDA  #$00
00:8230  8d 2d 21     mx STA  $212D
00:8233  a9 82        mx LDA  #$82
00:8235  8d 31 21     mx STA  $2131
00:8238  a9 38        mx LDA  #$38
00:823A  8d 32 21     mx STA  $2132
00:823D  a9 50        mx LDA  #$50
00:823F  8d 32 21     mx STA  $2132
00:8242  a9 88        mx LDA  #$88
00:8244  8d 32 21     mx STA  $2132
00:8247  a9 02        mx LDA  #$02
00:8249  8d 30 21     mx STA  $2130
00:824C  e2 30        mx SEP  #$30
00:824E  9c d6 0e     mx STZ  $0ED6
00:8251  9c d8 0e     mx STZ  $0ED8
00:8254  20 76 bd     mx JSR  $BD76
00:8257  20 78 9d     mx JSR  $9D78
00:825A  c2 30        mx REP  #$30
00:825C  a9 0c 00     MX LDA  #$000C
00:825F  8d 4e 12     MX STA  $124E
00:8262  a9 01 00     MX LDA  #$0001
00:8265  8d 50 12     MX STA  $1250
00:8268  20 4e b4     MX JSR  $B44E

L_00826B:   ; xref 008289
00:826B  20 72 b4     MX JSR  $B472
00:826E  20 d1 82     MX JSR  $82D1
00:8271  20 d5 ab     MX JSR  $ABD5
00:8274  e2 30        MX SEP  #$30
00:8276  ad d6 0e     mx LDA  $0ED6
00:8279  c9 01        mx CMP  #$01
00:827B  d0 0a        mx BNE  $8287
00:827D  c2 20        mx REP  #$20
00:827F  ad da 0e     Mx LDA  $0EDA
00:8282  f0 0b        Mx BEQ  $828F
00:8284  ce da 0e     Mx DEC  $0EDA

L_008287:   ; xref 00827B
00:8287  e2 30        Mx SEP  #$30
00:8289  4c 6b 82     mx JMP  $826B

L_00828F:   ; xref 008282
00:828F  20 7d 9d     Mx JSR  $9D7D
00:8292  e2 30        Mx SEP  #$30
00:8294  a2 00        mx LDX  #$00

L_008296:   ; xref 0082A0
00:8296  da           mx PHX  
00:8297  20 a1 9c     mx JSR  $9CA1
00:829A  e2 30        mx SEP  #$30
00:829C  fa           mx PLX  
00:829D  e8           mx INX  
00:829E  e0 30        mx CPX  #$30
00:82A0  d0 f4        mx BNE  $8296
00:82A2  e2 30        mx SEP  #$30
00:82A4  a9 17        mx LDA  #$17
00:82A6  8d 2c 21     mx STA  $212C
00:82A9  a9 13        mx LDA  #$13
00:82AB  8d 2d 21     mx STA  $212D
00:82AE  a9 ec        mx LDA  #$EC
00:82B0  8d 32 21     mx STA  $2132
00:82B3  9c 25 21     mx STZ  $2125
00:82B6  a9 54        mx LDA  #$54
00:82B8  8d 31 21     mx STA  $2131
00:82BB  a9 02        mx LDA  #$02
00:82BD  8d 30 21     mx STA  $2130
00:82C0  e2 30        mx SEP  #$30
00:82C2  a9 07        mx LDA  #$07
00:82C4  8d 2c 21     mx STA  $212C
00:82C7  20 f0 c5     mx JSR  $C5F0
00:82CA  4c aa 81     mx JMP  $81AA

L_0082D1:   ; xref 0081A7 00826E 00C6F0 00BC7C
00:82D1  20 76 a0     MX JSR  $A076
00:82D4  20 b0 9c     MX JSR  $9CB0
00:82D7  20 b3 83     MX JSR  $83B3
00:82DA  60           MX RTS  

L_0082DB:   ; xref 00806D
00:82DB  08           mx PHP  
00:82DC  e2 20        mx SEP  #$20
00:82DE  9c b4 0e     mx STZ  $0EB4
00:82E1  9c b5 0e     mx STZ  $0EB5
00:82E4  9c b6 0e     mx STZ  $0EB6
00:82E7  28           mx PLP  
00:82E8  60           mx RTS  

L_0082ED:   ; xref 0089D6 00813A 00820E 00C61F 00C661 00BA24
00:82ED  08           mx PHP  
00:82EE  e2 30        mx SEP  #$30
00:82F0  da           mx PHX  
00:82F1  ae b4 0e     mx LDX  $0EB4
00:82F4  a5 29        mx LDA  $29
00:82F6  9d c4 0d     mx STA  $0DC4,X
00:82F9  a5 2a        mx LDA  $2A
00:82FB  9d c5 0d     mx STA  $0DC5,X
00:82FE  a5 2b        mx LDA  $2B
00:8300  9d c6 0d     mx STA  $0DC6,X
00:8303  a5 2c        mx LDA  $2C
00:8305  9d c7 0d     mx STA  $0DC7,X
00:8308  c2 20        mx REP  #$20
00:830A  a5 2d        Mx LDA  $2D
00:830C  9d c8 0d     Mx STA  $0DC8,X
00:830F  a5 2f        Mx LDA  $2F
00:8311  9d ca 0d     Mx STA  $0DCA,X
00:8314  a5 31        Mx LDA  $31
00:8316  9d cc 0d     Mx STA  $0DCC,X
00:8319  e2 20        Mx SEP  #$20
00:831B  ee b5 0e     mx INC  $0EB5
00:831E  ad b4 0e     mx LDA  $0EB4
00:8321  18           mx CLC  
00:8322  69 0a        mx ADC  #$0A
00:8324  8d b4 0e     mx STA  $0EB4
00:8327  ad b6 0e     mx LDA  $0EB6
00:832A  29 7f        mx AND  #$7F
00:832C  cd b5 0e     mx CMP  $0EB5
00:832F  b0 0b        mx BCS  $833C
00:8331  ad b6 0e     mx LDA  $0EB6
00:8334  29 80        mx AND  #$80
00:8336  0d b5 0e     mx ORA  $0EB5
00:8339  8d b6 0e     mx STA  $0EB6

L_00833C:   ; xref 00832F
00:833C  fa           mx PLX  
00:833D  28           mx PLP  
00:833E  60           mx RTS  

L_00833F:   ; xref 00840F
00:833F  08           MX PHP  
00:8340  e2 20        MX SEP  #$20
00:8342  ad b5 0e     mX LDA  $0EB5
00:8345  d0 02        mX BNE  $8349
00:8347  28           mX PLP  
00:8348  60           mX RTS  

L_008349:   ; xref 008345
00:8349  c2 10        mX REP  #$10
00:834B  a2 00 00     mX LDX  #$0000

L_00834E:   ; xref 008354
00:834E  20 5b 83     mX JSR  $835B
00:8351  ce b5 0e     mX DEC  $0EB5
00:8354  d0 f8        mX BNE  $834E
00:8356  9c b4 0e     mX STZ  $0EB4
00:8359  28           mX PLP  
00:835A  60           mX RTS  

L_00835B:   ; xref 00834E
00:835B  08           mX PHP  
00:835C  c2 20        mX REP  #$20
00:835E  bd c8 0d     MX LDA  $0DC8,X
00:8361  8d 02 43     MX STA  $4302
00:8364  bd cc 0d     MX LDA  $0DCC,X
00:8367  8d 05 43     MX STA  $4305
00:836A  bd ca 0d     MX LDA  $0DCA,X
00:836D  8d 16 21     MX STA  $2116
00:8370  e2 20        MX SEP  #$20
00:8372  bd c4 0d     mX LDA  $0DC4,X
00:8375  8d 00 43     mX STA  $4300
00:8378  bd c7 0d     mX LDA  $0DC7,X
00:837B  8d 04 43     mX STA  $4304
00:837E  bd c5 0d     mX LDA  $0DC5,X
00:8381  8d 15 21     mX STA  $2115
00:8384  bd c6 0d     mX LDA  $0DC6,X
00:8387  8d 01 43     mX STA  $4301
00:838A  a9 01        mX LDA  #$01
00:838C  8d 0b 42     mX STA  $420B
00:838F  c2 20        mX REP  #$20
00:8391  8a           MX TXA  
00:8392  18           MX CLC  
00:8393  69 0a 00     MX ADC  #$000A
00:8396  aa           MX TAX  
00:8397  28           MX PLP  
00:8398  60           MX RTS  
00:8399  40           mx RTI  

L_00839C:   ; xref 008070
00:839C  08           mx PHP  
00:839D  e2 20        mx SEP  #$20
00:839F  64 9e        mx STZ  $9E
00:83A1  64 9f        mx STZ  $9F
00:83A3  64 a7        mx STZ  $A7
00:83A5  64 a3        mx STZ  $A3
00:83A7  64 9d        mx STZ  $9D
00:83A9  c2 20        mx REP  #$20
00:83AB  64 a1        Mx STZ  $A1
00:83AD  28           Mx PLP  
00:83AE  60           Mx RTS  

L_0083B3:   ; xref 0080DF 0080FB 00813D 008159 008211 00C664
00:83B3  08           MX PHP  
00:83B4  e2 30        MX SEP  #$30
00:83B6  a9 06        mx LDA  #$06
00:83B8  85 a3        mx STA  $A3
00:83BA  20 c3 83     mx JSR  $83C3
00:83BD  28           mx PLP  
00:83BE  60           mx RTS  
00:83BF  20 c3 83     mx JSR  $83C3
00:83C2  6b           mx RTL  

L_0083C3:   ; xref 00C622 0083BF 0083BA 00BA27 00B1FF 00B228
00:83C3  08           mx PHP  
00:83C4  e2 20        mx SEP  #$20

L_0083C6:   ; xref 0083C9
00:83C6  ad 10 42     mx LDA  $4210
00:83C9  30 fb        mx BMI  $83C6
00:83CB  e2 20        mx SEP  #$20
00:83CD  a5 9f        mx LDA  $9F
00:83CF  48           mx PHA  
00:83D0  a9 81        mx LDA  #$81
00:83D2  8d 00 42     mx STA  $4200
00:83D5  68           mx PLA  

L_0083D6:   ; xref 0083D8
00:83D6  c5 9f        mx CMP  $9F
00:83D8  f0 fc        mx BEQ  $83D6
00:83DA  28           mx PLP  
00:83DB  60           mx RTS  
00:83DC  78           mx SEI  
00:83DD  08           mx PHP  
00:83DE  c2 30        mx REP  #$30
00:83E0  0b           MX PHD  
00:83E1  8b           MX PHB  
00:83E2  48           MX PHA  
00:83E3  da           MX PHX  
00:83E4  5a           MX PHY  
00:83E5  4b           MX PHK  
00:83E6  ab           MX PLB  
00:83E7  a9 00 00     MX LDA  #$0000
00:83EA  5b           MX TCD  
00:83EB  e2 20        MX SEP  #$20
00:83ED  cd 10 42     mX CMP  $4210
00:83F0  a9 01        mX LDA  #$01
00:83F2  8d 00 42     mX STA  $4200
00:83F5  a9 80        mX LDA  #$80
00:83F7  8d 00 21     mX STA  $2100
00:83FA  e2 20        mX SEP  #$20
00:83FC  9c 0c 42     mX STZ  $420C
00:83FF  20 5f 84     mX JSR  $845F
00:8402  c2 20        mX REP  #$20
00:8404  85 a8        MX STA  $A8

L_008406:   ; xref 00840D
00:8406  20 5f 84     MX JSR  $845F
00:8409  c2 20        MX REP  #$20
00:840B  c5 a8        MX CMP  $A8
00:840D  f0 f7        MX BEQ  $8406
00:840F  20 3f 83     MX JSR  $833F
00:8412  20 5f 84     MX JSR  $845F
00:8415  c2 20        MX REP  #$20
00:8417  c9 fa 00     MX CMP  #$00FA
00:841A  b0 16        MX BCS  $8432
00:841C  e2 30        MX SEP  #$30
00:841E  a5 a3        mx LDA  $A3
00:8420  89 02        mx BIT  #$02
00:8422  f0 03        mx BEQ  $8427
00:8424  20 97 84     mx JSR  $8497

L_008427:   ; xref 008422
00:8427  a5 a3        mx LDA  $A3
00:8429  89 04        mx BIT  #$04
00:842B  f0 03        mx BEQ  $8430
00:842D  20 6f 84     mx JSR  $846F

L_008430:   ; xref 00842B
00:8430  64 a3        mx STZ  $A3

L_008432:   ; xref 00841A
00:8432  c2 20        mx REP  #$20
00:8434  a5 a1        Mx LDA  $A1
00:8436  f0 03        Mx BEQ  $843B
00:8438  20 c2 84     Mx JSR  $84C2

L_00843B:   ; xref 008436
00:843B  64 a1        Mx STZ  $A1
00:843D  e2 20        Mx SEP  #$20
00:843F  a5 9d        mx LDA  $9D
00:8441  8d 0c 42     mx STA  $420C
00:8444  e2 20        mx SEP  #$20
00:8446  a5 9e        mx LDA  $9E
00:8448  8d 00 21     mx STA  $2100
00:844B  e2 20        mx SEP  #$20
00:844D  a5 a0        mx LDA  $A0
00:844F  f0 02        mx BEQ  $8453
00:8451  c6 a0        mx DEC  $A0

L_008453:   ; xref 00844F
00:8453  e6 9f        mx INC  $9F
00:8455  c2 30        mx REP  #$30
00:8457  7a           MX PLY  
00:8458  fa           MX PLX  
00:8459  68           MX PLA  
00:845A  ab           MX PLB  
00:845B  2b           MX PLD  
00:845C  28           MX PLP  
00:845D  58           MX CLI  
00:845E  40           MX RTI  

L_00845F:   ; xref 0083FF 008406 008412
00:845F  e2 20        MX SEP  #$20
00:8461  ad 37 21     mX LDA  $2137
00:8464  ad 3d 21     mX LDA  $213D
00:8467  eb           mX XBA  
00:8468  ad 3d 21     mX LDA  $213D
00:846B  29 01        mX AND  #$01
00:846D  eb           mX XBA  
00:846E  60           mX RTS  

L_00846F:   ; xref 00842D
00:846F  08           mx PHP  
00:8470  c2 20        mx REP  #$20
00:8472  a9 c0 0b     Mx LDA  #$0BC0
00:8475  8d 02 43     Mx STA  $4302
00:8478  a9 00 02     Mx LDA  #$0200
00:847B  8d 05 43     Mx STA  $4305
00:847E  e2 20        Mx SEP  #$20
00:8480  9c 21 21     mx STZ  $2121
00:8483  a9 80        mx LDA  #$80
00:8485  8d 04 43     mx STA  $4304
00:8488  9c 00 43     mx STZ  $4300
00:848B  a9 22        mx LDA  #$22
00:848D  8d 01 43     mx STA  $4301
00:8490  a9 01        mx LDA  #$01
00:8492  8d 0b 42     mx STA  $420B
00:8495  28           mx PLP  
00:8496  60           mx RTS  

L_008497:   ; xref 008424
00:8497  08           mx PHP  
00:8498  c2 20        mx REP  #$20
00:849A  a9 a0 09     Mx LDA  #$09A0
00:849D  8d 02 43     Mx STA  $4302
00:84A0  a9 20 02     Mx LDA  #$0220
00:84A3  8d 05 43     Mx STA  $4305
00:84A6  e2 20        Mx SEP  #$20
00:84A8  9c 02 21     mx STZ  $2102
00:84AB  9c 03 21     mx STZ  $2103
00:84AE  a9 80        mx LDA  #$80
00:84B0  8d 04 43     mx STA  $4304
00:84B3  9c 00 43     mx STZ  $4300
00:84B6  a9 04        mx LDA  #$04
00:84B8  8d 01 43     mx STA  $4301
00:84BB  a9 01        mx LDA  #$01
00:84BD  8d 0b 42     mx STA  $420B
00:84C0  28           mx PLP  
00:84C1  60           mx RTS  

L_0084C2:   ; xref 008438
00:84C2  6c a1 00     Mx JMP  ($00A1)

L_0084C5:   ; xref 008073
00:84C5  08           mx PHP  
00:84C6  e2 30        mx SEP  #$30
00:84C8  9c b7 0e     mx STZ  $0EB7
00:84CB  22 d1 84 80  mx JSL  $8084D1
00:84CF  28           mx PLP  
00:84D0  60           mx RTS  
00:84D1  08           mx PHP  
00:84D2  c2 10        mx REP  #$10
00:84D4  a0 00 00     mX LDY  #$0000
00:84D7  e2 20        mX SEP  #$20
00:84D9  a9 f0        mX LDA  #$F0

L_0084DB:   ; xref 0084E5
00:84DB  99 a1 09     mX STA  $09A1,Y
00:84DE  c8           mX INY  
00:84DF  c8           mX INY  
00:84E0  c8           mX INY  
00:84E1  c8           mX INY  
00:84E2  c0 00 02     mX CPY  #$0200
00:84E5  d0 f4        mX BNE  $84DB
00:84E7  e2 30        mX SEP  #$30
00:84E9  64 ab        mx STZ  $AB
00:84EB  64 ac        mx STZ  $AC
00:84ED  28           mx PLP  
00:84EE  6b           mx RTL  
00:84EF  08           mx PHP  
00:84F0  e2 30        mx SEP  #$30
00:84F2  a5 ab        mx LDA  $AB
00:84F4  c5 ac        mx CMP  $AC
00:84F6  b0 20        mx BCS  $8518
00:84F8  c2 30        mx REP  #$30
00:84FA  a5 ab        MX LDA  $AB
00:84FC  29 ff 00     MX AND  #$00FF
00:84FF  0a           MX ASL  
00:8500  0a           MX ASL  
00:8501  a8           MX TAY  
00:8502  e2 20        MX SEP  #$20
00:8504  a5 ac        mX LDA  $AC
00:8506  38           mX SEC  
00:8507  e5 ab        mX SBC  $AB
00:8509  85 00        mX STA  $00
00:850B  a9 f0        mX LDA  #$F0

L_00850D:   ; xref 008516
00:850D  99 a1 09     mX STA  $09A1,Y
00:8510  c8           mX INY  
00:8511  c8           mX INY  
00:8512  c8           mX INY  
00:8513  c8           mX INY  
00:8514  c6 00        mX DEC  $00
00:8516  d0 f5        mX BNE  $850D

L_008518:   ; xref 0084F6
00:8518  28           mX PLP  
00:8519  6b           mX RTL  
00:851A  20 1e 85     mx JSR  $851E
00:851D  6b           mx RTL  

L_00851E:   ; xref 00851A
00:851E  08           mx PHP  
00:851F  22 54 85 80  mx JSL  $808554
00:8523  e2 30        mx SEP  #$30
00:8525  bd 30 01     mx LDA  $0130,X
00:8528  a8           mx TAY  
00:8529  b9 ba 8a     mx LDA  $8ABA,Y
00:852C  85 02        mx STA  $02
00:852E  c2 30        mx REP  #$30
00:8530  bd 30 01     MX LDA  $0130,X
00:8533  29 ff 00     MX AND  #$00FF
00:8536  0a           MX ASL  
00:8537  a8           MX TAY  
00:8538  4b           MX PHK  
00:8539  f4 47 85     MX PEA  $8547
00:853C  b9 c9 8a     MX LDA  $8AC9,Y
00:853F  38           MX SEC  
00:8540  e9 03 00     MX SBC  #$0003
00:8543  85 00        MX STA  $00
00:8545  dc 00 00     MX JML  [$0000]
00:8548  e2 30        mx SEP  #$30
00:854A  bd 00 01     mx LDA  $0100,X
00:854D  09 02        mx ORA  #$02
00:854F  9d 00 01     mx STA  $0100,X
00:8552  28           mx PLP  
00:8553  60           mx RTS  
00:8554  08           mx PHP  
00:8555  e2 30        mx SEP  #$30
00:8557  9e 40 03     mx STZ  $0340,X
00:855A  9e 70 03     mx STZ  $0370,X
00:855D  9e 90 01     mx STZ  $0190,X
00:8560  bd 00 01     mx LDA  $0100,X
00:8563  29 df        mx AND  #$DF
00:8565  9d 00 01     mx STA  $0100,X
00:8568  20 ba 87     mx JSR  $87BA
00:856B  28           mx PLP  
00:856C  6b           mx RTL  

L_00856D:   ; xref 009D04
00:856D  08           mx PHP  
00:856E  e2 20        mx SEP  #$20
00:8570  bd f0 01     mx LDA  $01F0,X
00:8573  85 21        mx STA  $21
00:8575  bd 90 07     mx LDA  $0790,X
00:8578  85 22        mx STA  $22
00:857A  bd 20 02     mx LDA  $0220,X
00:857D  85 23        mx STA  $23
00:857F  bd c0 07     mx LDA  $07C0,X
00:8582  85 24        mx STA  $24
00:8584  bd b0 05     mx LDA  $05B0,X
00:8587  29 7f        mx AND  #$7F
00:8589  9d b0 05     mx STA  $05B0,X
00:858C  c2 10        mx REP  #$10
00:858E  bd 00 01     mX LDA  $0100,X
00:8591  89 20        mX BIT  #$20
00:8593  f0 0c        mX BEQ  $85A1
00:8595  bd 00 01     mX LDA  $0100,X
00:8598  89 10        mX BIT  #$10
00:859A  f0 10        mX BEQ  $85AC
00:859C  29 df        mX AND  #$DF
00:859E  9d 00 01     mX STA  $0100,X

L_0085A1:   ; xref 008593
00:85A1  de c0 01     mX DEC  $01C0,X
00:85A4  d0 06        mX BNE  $85AC
00:85A6  fe 90 01     mX INC  $0190,X
00:85A9  20 ba 87     mX JSR  $87BA

L_0085AC:   ; xref 00859A 0085A4
00:85AC  e2 30        mX SEP  #$30
00:85AE  bd 30 01     mx LDA  $0130,X
00:85B1  a8           mx TAY  
00:85B2  b9 ba 8a     mx LDA  $8ABA,Y
00:85B5  85 02        mx STA  $02
00:85B7  c2 30        mx REP  #$30
00:85B9  bd 30 01     MX LDA  $0130,X
00:85BC  29 ff 00     MX AND  #$00FF
00:85BF  0a           MX ASL  
00:85C0  a8           MX TAY  
00:85C1  4b           MX PHK  
00:85C2  f4 cc 85     MX PEA  $85CC
00:85C5  b9 c9 8a     MX LDA  $8AC9,Y
00:85C8  85 00        MX STA  $00
00:85CA  dc 00 00     MX JML  [$0000]
00:85CD  e2 30        mx SEP  #$30
00:85CF  a5 21        mx LDA  $21
00:85D1  9d f0 01     mx STA  $01F0,X
00:85D4  a5 22        mx LDA  $22
00:85D6  9d 90 07     mx STA  $0790,X
00:85D9  a5 23        mx LDA  $23
00:85DB  9d 20 02     mx STA  $0220,X
00:85DE  a5 24        mx LDA  $24
00:85E0  9d c0 07     mx STA  $07C0,X
00:85E3  e2 30        mx SEP  #$30
00:85E5  bd b0 05     mx LDA  $05B0,X
00:85E8  10 03        mx BPL  $85ED
00:85EA  20 88 89     mx JSR  $8988

L_0085ED:   ; xref 0085E8
00:85ED  e2 30        mx SEP  #$30
00:85EF  bd 00 01     mx LDA  $0100,X
00:85F2  09 40        mx ORA  #$40
00:85F4  89 08        mx BIT  #$08
00:85F6  d0 07        mx BNE  $85FF
00:85F8  89 02        mx BIT  #$02
00:85FA  f0 03        mx BEQ  $85FF
00:85FC  4c 01 86     mx JMP  $8601

L_0085FF:   ; xref 0085F6 0085FA
00:85FF  29 bf        mx AND  #$BF

L_008601:   ; xref 0085FC
00:8601  9d 00 01     mx STA  $0100,X
00:8604  20 17 86     mx JSR  $8617
00:8607  b0 0c        mx BCS  $8615
00:8609  e2 30        mx SEP  #$30
00:860B  bd 00 01     mx LDA  $0100,X
00:860E  89 40        mx BIT  #$40
00:8610  f0 03        mx BEQ  $8615
00:8612  20 3e 86     mx JSR  $863E

L_008615:   ; xref 008607 008610
00:8615  28           mx PLP  
00:8616  60           mx RTS  

L_008617:   ; xref 008604 009D0F
00:8617  e2 30        mx SEP  #$30
00:8619  ad b7 0e     mx LDA  $0EB7
00:861C  f0 1c        mx BEQ  $863A
00:861E  bd 30 01     mx LDA  $0130,X
00:8621  c9 01        mx CMP  #$01
00:8623  d0 07        mx BNE  $862C
00:8625  bd 60 01     mx LDA  $0160,X
00:8628  c9 13        mx CMP  #$13
00:862A  90 10        mx BCC  $863C

L_00862C:   ; xref 008623
00:862C  bd 30 01     mx LDA  $0130,X
00:862F  c9 71        mx CMP  #$71
00:8631  d0 07        mx BNE  $863A
00:8633  bd 60 01     mx LDA  $0160,X
00:8636  c9 04        mx CMP  #$04
00:8638  90 02        mx BCC  $863C

L_00863A:   ; xref 00861C 008631
00:863A  18           mx CLC  
00:863B  60           mx RTS  

L_00863C:   ; xref 00862A 008638
00:863C  38           mx SEC  
00:863D  60           mx RTS  

L_00863E:   ; xref 008612
00:863E  08           mx PHP  
00:863F  e2 30        mx SEP  #$30
00:8641  20 88 87     mx JSR  $8788
00:8644  bc e0 02     mx LDY  $02E0,X
00:8647  d0 03        mx BNE  $864C
00:8649  bc 30 01     mx LDY  $0130,X

L_00864C:   ; xref 008647
00:864C  b9 ab 8a     mx LDA  $8AAB,Y
00:864F  0a           mx ASL  
00:8650  85 12        mx STA  $12
00:8652  64 13        mx STZ  $13
00:8654  c0 93        mx CPY  #$93
00:8656  f0 08        mx BEQ  $8660
00:8658  c0 94        mx CPY  #$94
00:865A  f0 04        mx BEQ  $8660
00:865C  c0 95        mx CPY  #$95
00:865E  d0 04        mx BNE  $8664

L_008660:   ; xref 008656 00865A
00:8660  a9 30        mx LDA  #$30
00:8662  85 13        mx STA  $13

L_008664:   ; xref 00865E
00:8664  b9 15 8a     mx LDA  $8A15,Y
00:8667  85 34        mx STA  $34
00:8669  85 31        mx STA  $31
00:866B  c2 30        mx REP  #$30
00:866D  98           MX TYA  
00:866E  29 ff 00     MX AND  #$00FF
00:8671  0a           MX ASL  
00:8672  a8           MX TAY  
00:8673  b9 e7 8a     MX LDA  $8AE7,Y
00:8676  f0 08        MX BEQ  $8680
00:8678  e2 30        MX SEP  #$30
00:867A  a9 7e        mx LDA  #$7E
00:867C  85 34        mx STA  $34
00:867E  85 31        mx STA  $31

L_008680:   ; xref 008676
00:8680  e2 30        mx SEP  #$30
00:8682  bd 80 02     mx LDA  $0280,X
00:8685  85 32        mx STA  $32
00:8687  bd f0 07     mx LDA  $07F0,X
00:868A  85 33        mx STA  $33
00:868C  bd b0 02     mx LDA  $02B0,X
00:868F  85 2f        mx STA  $2F
00:8691  bd 20 08     mx LDA  $0820,X
00:8694  85 30        mx STA  $30
00:8696  c2 10        mx REP  #$10
00:8698  bd f0 01     mX LDA  $01F0,X
00:869B  85 2b        mX STA  $2B
00:869D  bd 90 07     mX LDA  $0790,X
00:86A0  85 2c        mX STA  $2C
00:86A2  bd 20 02     mX LDA  $0220,X
00:86A5  85 2d        mX STA  $2D
00:86A7  bd c0 07     mX LDA  $07C0,X
00:86AA  85 2e        mX STA  $2E
00:86AC  c2 20        mX REP  #$20
00:86AE  a5 2b        MX LDA  $2B
00:86B0  38           MX SEC  
00:86B1  e5 25        MX SBC  $25
00:86B3  85 2b        MX STA  $2B
00:86B5  a5 2d        MX LDA  $2D
00:86B7  38           MX SEC  
00:86B8  e5 27        MX SBC  $27
00:86BA  85 2d        MX STA  $2D
00:86BC  a0 00 00     MX LDY  #$0000
00:86BF  b7 2f        MX LDA  [$2F],Y
00:86C1  29 ff 00     MX AND  #$00FF
00:86C4  85 06        MX STA  $06
00:86C6  c8           MX INY  

L_0086C7:   ; xref 0086CC
00:86C7  20 d0 86     MX JSR  $86D0
00:86CA  c6 06        MX DEC  $06
00:86CC  d0 f9        MX BNE  $86C7
00:86CE  28           MX PLP  
00:86CF  60           MX RTS  

L_0086D0:   ; xref 0086C7
00:86D0  08           MX PHP  
00:86D1  e2 20        MX SEP  #$20
00:86D3  64 01        mX STZ  $01
00:86D5  b7 2f        mX LDA  [$2F],Y
00:86D7  85 00        mX STA  $00
00:86D9  10 04        mX BPL  $86DF
00:86DB  a9 ff        mX LDA  #$FF
00:86DD  85 01        mX STA  $01

L_0086DF:   ; xref 0086D9
00:86DF  c8           mX INY  
00:86E0  c2 20        mX REP  #$20
00:86E2  a5 00        MX LDA  $00
00:86E4  18           MX CLC  
00:86E5  65 2b        MX ADC  $2B
00:86E7  85 00        MX STA  $00
00:86E9  e2 20        MX SEP  #$20
00:86EB  a5 01        mX LDA  $01
00:86ED  29 01        mX AND  #$01
00:86EF  85 09        mX STA  $09
00:86F1  64 04        mX STZ  $04
00:86F3  b7 2f        mX LDA  [$2F],Y
00:86F5  85 03        mX STA  $03
00:86F7  10 04        mX BPL  $86FD
00:86F9  a9 ff        mX LDA  #$FF
00:86FB  85 04        mX STA  $04

L_0086FD:   ; xref 0086F7
00:86FD  c8           mX INY  
00:86FE  c2 20        mX REP  #$20
00:8700  a5 03        MX LDA  $03
00:8702  18           MX CLC  
00:8703  65 2d        MX ADC  $2D
00:8705  85 03        MX STA  $03
00:8707  c9 e0 00     MX CMP  #$00E0
00:870A  90 11        MX BCC  $871D
00:870C  18           MX CLC  
00:870D  69 10 00     MX ADC  #$0010
00:8710  c9 e0 00     MX CMP  #$00E0
00:8713  90 08        MX BCC  $871D
00:8715  e2 20        MX SEP  #$20
00:8717  a9 01        mX LDA  #$01
00:8719  85 09        mX STA  $09
00:871B  85 00        mX STA  $00

L_00871D:   ; xref 00870A 008713
00:871D  e2 20        mX SEP  #$20
00:871F  a5 03        mX LDA  $03
00:8721  85 01        mX STA  $01
00:8723  b7 2f        mX LDA  [$2F],Y
00:8725  85 03        mX STA  $03
00:8727  c8           mX INY  
00:8728  b7 2f        mX LDA  [$2F],Y
00:872A  29 cf        mX AND  #$CF
00:872C  09 20        mX ORA  #$20
00:872E  05 13        mX ORA  $13
00:8730  18           mX CLC  
00:8731  65 12        mX ADC  $12
00:8733  85 04        mX STA  $04
00:8735  b7 2f        mX LDA  [$2F],Y
00:8737  29 10        mX AND  #$10
00:8739  f0 02        mX BEQ  $873D
00:873B  a9 01        mX LDA  #$01

L_00873D:   ; xref 008739
00:873D  85 0a        mX STA  $0A
00:873F  c8           mX INY  
00:8740  e2 10        mX SEP  #$10
00:8742  5a           mx PHY  
00:8743  a9 00        mx LDA  #$00
00:8745  a4 0a        mx LDY  $0A
00:8747  f0 02        mx BEQ  $874B
00:8749  a5 39        mx LDA  $39

L_00874B:   ; xref 008747
00:874B  0a           mx ASL  
00:874C  a4 09        mx LDY  $09
00:874E  f0 02        mx BEQ  $8752
00:8750  05 39        mx ORA  $39

L_008752:   ; xref 00874E
00:8752  85 09        mx STA  $09
00:8754  a5 39        mx LDA  $39
00:8756  0a           mx ASL  
00:8757  05 39        mx ORA  $39
00:8759  49 ff        mx EOR  #$FF
00:875B  32 37        mx AND  ($37)
00:875D  05 09        mx ORA  $09
00:875F  92 37        mx STA  ($37)
00:8761  06 39        mx ASL  $39
00:8763  06 39        mx ASL  $39
00:8765  d0 08        mx BNE  $876F
00:8767  a9 01        mx LDA  #$01
00:8769  85 39        mx STA  $39
00:876B  c2 20        mx REP  #$20
00:876D  e6 37        Mx INC  $37

L_00876F:   ; xref 008765
00:876F  c2 20        Mx REP  #$20
00:8771  a5 00        Mx LDA  $00
00:8773  92 35        Mx STA  ($35)
00:8775  a0 02        Mx LDY  #$02
00:8777  a5 03        Mx LDA  $03
00:8779  91 35        Mx STA  ($35),Y
00:877B  a9 04 00     Mx LDA  #$0004
00:877E  18           Mx CLC  
00:877F  65 35        Mx ADC  $35
00:8781  85 35        Mx STA  $35
00:8783  e2 10        Mx SEP  #$10
00:8785  7a           Mx PLY  
00:8786  28           Mx PLP  
00:8787  60           Mx RTS  

L_008788:   ; xref 008641
00:8788  08           mx PHP  
00:8789  c2 30        mx REP  #$30
00:878B  bd 50 02     MX LDA  $0250,X
00:878E  29 ff 00     MX AND  #$00FF
00:8791  0a           MX ASL  
00:8792  0a           MX ASL  
00:8793  18           MX CLC  
00:8794  69 a0 09     MX ADC  #$09A0
00:8797  85 35        MX STA  $35
00:8799  bd 50 02     MX LDA  $0250,X
00:879C  29 ff 00     MX AND  #$00FF
00:879F  4a           MX LSR  
00:87A0  4a           MX LSR  
00:87A1  18           MX CLC  
00:87A2  69 a0 0b     MX ADC  #$0BA0
00:87A5  85 37        MX STA  $37
00:87A7  e2 30        MX SEP  #$30
00:87A9  bd 50 02     mx LDA  $0250,X
00:87AC  29 03        mx AND  #$03
00:87AE  a8           mx TAY  
00:87AF  b9 b6 87     mx LDA  $87B6,Y
00:87B2  85 39        mx STA  $39
00:87B4  28           mx PLP  
00:87B5  60           mx RTS  

L_0087BA:   ; xref 008568 0085A9
00:87BA  08           mx PHP  
00:87BB  e2 30        mx SEP  #$30
00:87BD  bc e0 02     mx LDY  $02E0,X
00:87C0  d0 03        mx BNE  $87C5
00:87C2  bc 30 01     mx LDY  $0130,X

L_0087C5:   ; xref 0087C0
00:87C5  b9 15 8a     mx LDA  $8A15,Y
00:87C8  85 02        mx STA  $02
00:87CA  b9 24 8a     mx LDA  $8A24,Y
00:87CD  85 00        mx STA  $00
00:87CF  b9 33 8a     mx LDA  $8A33,Y
00:87D2  85 01        mx STA  $01
00:87D4  c2 30        mx REP  #$30
00:87D6  98           MX TYA  
00:87D7  29 ff 00     MX AND  #$00FF
00:87DA  0a           MX ASL  
00:87DB  a8           MX TAY  
00:87DC  b9 e7 8a     MX LDA  $8AE7,Y
00:87DF  f0 08        MX BEQ  $87E9
00:87E1  85 00        MX STA  $00
00:87E3  e2 30        MX SEP  #$30
00:87E5  a9 7e        mx LDA  #$7E
00:87E7  85 02        mx STA  $02

L_0087E9:   ; xref 0087DF
00:87E9  e2 30        mx SEP  #$30
00:87EB  a5 02        mx LDA  $02
00:87ED  85 34        mx STA  $34
00:87EF  85 31        mx STA  $31
00:87F1  85 3d        mx STA  $3D
00:87F3  85 46        mx STA  $46
00:87F5  85 40        mx STA  $40
00:87F7  85 43        mx STA  $43
00:87F9  a0 00        mx LDY  #$00
00:87FB  a7 00        mx LDA  [$00]
00:87FD  85 32        mx STA  $32
00:87FF  c8           mx INY  
00:8800  b7 00        mx LDA  [$00],Y
00:8802  85 33        mx STA  $33
00:8804  c8           mx INY  
00:8805  b7 00        mx LDA  [$00],Y
00:8807  85 2f        mx STA  $2F
00:8809  c8           mx INY  
00:880A  b7 00        mx LDA  [$00],Y
00:880C  85 30        mx STA  $30
00:880E  c8           mx INY  
00:880F  b7 00        mx LDA  [$00],Y
00:8811  85 44        mx STA  $44
00:8813  c8           mx INY  
00:8814  b7 00        mx LDA  [$00],Y
00:8816  85 45        mx STA  $45
00:8818  c8           mx INY  
00:8819  b7 00        mx LDA  [$00],Y
00:881B  85 3e        mx STA  $3E
00:881D  c8           mx INY  
00:881E  b7 00        mx LDA  [$00],Y
00:8820  85 3f        mx STA  $3F
00:8822  c8           mx INY  
00:8823  b7 00        mx LDA  [$00],Y
00:8825  85 41        mx STA  $41
00:8827  c8           mx INY  
00:8828  b7 00        mx LDA  [$00],Y
00:882A  85 42        mx STA  $42
00:882C  c8           mx INY  
00:882D  b7 00        mx LDA  [$00],Y
00:882F  85 3b        mx STA  $3B
00:8831  c8           mx INY  
00:8832  b7 00        mx LDA  [$00],Y
00:8834  85 3c        mx STA  $3C

L_008836:   ; xref 008868
00:8836  c2 30        mx REP  #$30
00:8838  bd 60 01     MX LDA  $0160,X
00:883B  29 ff 00     MX AND  #$00FF
00:883E  1a           MX INC  
00:883F  0a           MX ASL  
00:8840  a8           MX TAY  
00:8841  b7 32        MX LDA  [$32],Y
00:8843  85 00        MX STA  $00
00:8845  88           MX DEY  
00:8846  88           MX DEY  
00:8847  b7 32        MX LDA  [$32],Y
00:8849  85 03        MX STA  $03
00:884B  bd 90 01     MX LDA  $0190,X
00:884E  29 ff 00     MX AND  #$00FF
00:8851  0a           MX ASL  
00:8852  0a           MX ASL  
00:8853  a8           MX TAY  
00:8854  18           MX CLC  
00:8855  65 03        MX ADC  $03
00:8857  c5 00        MX CMP  $00
00:8859  d0 10        MX BNE  $886B
00:885B  e2 20        MX SEP  #$20
00:885D  9e 90 01     mX STZ  $0190,X
00:8860  bd 00 01     mX LDA  $0100,X
00:8863  09 20        mX ORA  #$20
00:8865  9d 00 01     mX STA  $0100,X
00:8868  4c 36 88     mX JMP  $8836

L_00886B:   ; xref 008859
00:886B  a5 03        MX LDA  $03
00:886D  85 32        MX STA  $32
00:886F  e2 20        MX SEP  #$20
00:8871  b7 32        mX LDA  [$32],Y
00:8873  3a           mX DEC  
00:8874  9d 10 03     mX STA  $0310,X
00:8877  c8           mX INY  
00:8878  b7 32        mX LDA  [$32],Y
00:887A  9d c0 01     mX STA  $01C0,X
00:887D  c8           mX INY  
00:887E  b7 32        mX LDA  [$32],Y
00:8880  9d 40 03     mX STA  $0340,X
00:8883  c8           mX INY  
00:8884  b7 32        mX LDA  [$32],Y
00:8886  9d 70 03     mX STA  $0370,X
00:8889  c2 20        mX REP  #$20
00:888B  bd 10 03     MX LDA  $0310,X
00:888E  29 ff 00     MX AND  #$00FF
00:8891  0a           MX ASL  
00:8892  a8           MX TAY  
00:8893  b7 2f        MX LDA  [$2F],Y
00:8895  85 2f        MX STA  $2F
00:8897  e2 20        MX SEP  #$20
00:8899  a5 32        mX LDA  $32
00:889B  9d 80 02     mX STA  $0280,X
00:889E  a5 33        mX LDA  $33
00:88A0  9d f0 07     mX STA  $07F0,X
00:88A3  a5 2f        mX LDA  $2F
00:88A5  9d b0 02     mX STA  $02B0,X
00:88A8  a5 30        mX LDA  $30
00:88AA  9d 20 08     mX STA  $0820,X
00:88AD  bd b0 05     mX LDA  $05B0,X
00:88B0  29 80        mX AND  #$80
00:88B2  07 2f        mX ORA  [$2F]
00:88B4  9d b0 05     mX STA  $05B0,X
00:88B7  bd 70 09     mX LDA  $0970,X
00:88BA  29 3f        mX AND  #$3F
00:88BC  9d 70 09     mX STA  $0970,X
00:88BF  b7 44        mX LDA  [$44],Y
00:88C1  29 0f        mX AND  #$0F
00:88C3  18           mX CLC  
00:88C4  69 01        mX ADC  #$01
00:88C6  9d f0 04     mX STA  $04F0,X
00:88C9  b7 44        mX LDA  [$44],Y
00:88CB  4a           mX LSR  
00:88CC  4a           mX LSR  
00:88CD  4a           mX LSR  
00:88CE  4a           mX LSR  
00:88CF  18           mX CLC  
00:88D0  69 01        mX ADC  #$01
00:88D2  9d 50 05     mX STA  $0550,X
00:88D5  c8           mX INY  
00:88D6  b7 44        mX LDA  [$44],Y
00:88D8  29 0f        mX AND  #$0F
00:88DA  18           mX CLC  
00:88DB  69 01        mX ADC  #$01
00:88DD  9d 20 05     mX STA  $0520,X
00:88E0  b7 44        mX LDA  [$44],Y
00:88E2  4a           mX LSR  
00:88E3  4a           mX LSR  
00:88E4  4a           mX LSR  
00:88E5  4a           mX LSR  
00:88E6  9d 80 05     mX STA  $0580,X
00:88E9  88           mX DEY  
00:88EA  b7 3e        mX LDA  [$3E],Y
00:88EC  29 0f        mX AND  #$0F
00:88EE  1a           mX INC  
00:88EF  0a           mX ASL  
00:88F0  0a           mX ASL  
00:88F1  0a           mX ASL  
00:88F2  9d 30 04     mX STA  $0430,X
00:88F5  b7 3e        mX LDA  [$3E],Y
00:88F7  29 f0        mX AND  #$F0
00:88F9  4a           mX LSR  
00:88FA  18           mX CLC  
00:88FB  69 08        mX ADC  #$08
00:88FD  18           mX CLC  
00:88FE  7d 30 04     mX ADC  $0430,X
00:8901  9d 90 04     mX STA  $0490,X
00:8904  bd 30 04     mX LDA  $0430,X
00:8907  49 ff        mX EOR  #$FF
00:8909  1a           mX INC  
00:890A  9d 30 04     mX STA  $0430,X
00:890D  c8           mX INY  
00:890E  b7 3e        mX LDA  [$3E],Y
00:8910  29 0f        mX AND  #$0F
00:8912  18           mX CLC  
00:8913  69 02        mX ADC  #$02
00:8915  0a           mX ASL  
00:8916  0a           mX ASL  
00:8917  0a           mX ASL  
00:8918  9d 60 04     mX STA  $0460,X
00:891B  b7 3e        mX LDA  [$3E],Y
00:891D  29 f0        mX AND  #$F0
00:891F  4a           mX LSR  
00:8920  18           mX CLC  
00:8921  7d 60 04     mX ADC  $0460,X
00:8924  9d c0 04     mX STA  $04C0,X
00:8927  bd 60 04     mX LDA  $0460,X
00:892A  49 ff        mX EOR  #$FF
00:892C  1a           mX INC  
00:892D  9d 60 04     mX STA  $0460,X
00:8930  c2 20        mX REP  #$20
00:8932  bd 10 03     MX LDA  $0310,X
00:8935  29 ff 00     MX AND  #$00FF
00:8938  0a           MX ASL  
00:8939  0a           MX ASL  
00:893A  a8           MX TAY  
00:893B  e2 20        MX SEP  #$20
00:893D  b7 41        mX LDA  [$41],Y
00:893F  9d 80 08     mX STA  $0880,X
00:8942  c8           mX INY  
00:8943  b7 41        mX LDA  [$41],Y
00:8945  9d b0 08     mX STA  $08B0,X
00:8948  c8           mX INY  
00:8949  b7 41        mX LDA  [$41],Y
00:894B  9d e0 08     mX STA  $08E0,X
00:894E  c8           mX INY  
00:894F  b7 41        mX LDA  [$41],Y
00:8951  9d 10 09     mX STA  $0910,X
00:8954  bd 90 04     mX LDA  $0490,X
00:8957  10 0d        mX BPL  $8966
00:8959  bd c0 04     mX LDA  $04C0,X
00:895C  10 08        mX BPL  $8966
00:895E  bd 70 09     mX LDA  $0970,X
00:8961  09 40        mX ORA  #$40
00:8963  9d 70 09     mX STA  $0970,X

L_008966:   ; xref 008957 00895C
00:8966  bd e0 08     mX LDA  $08E0,X
00:8969  c9 01        mX CMP  #$01
00:896B  d0 0f        mX BNE  $897C
00:896D  bd 10 09     mX LDA  $0910,X
00:8970  c9 01        mX CMP  #$01
00:8972  d0 08        mX BNE  $897C
00:8974  bd 70 09     mX LDA  $0970,X
00:8977  09 80        mX ORA  #$80
00:8979  9d 70 09     mX STA  $0970,X

L_00897C:   ; xref 00896B 008972
00:897C  e2 30        mX SEP  #$30
00:897E  bd b0 05     mx LDA  $05B0,X
00:8981  09 80        mx ORA  #$80
00:8983  9d b0 05     mx STA  $05B0,X
00:8986  28           mx PLP  
00:8987  60           mx RTS  

L_008988:   ; xref 0085EA
00:8988  08           mx PHP  
00:8989  e2 30        mx SEP  #$30
00:898B  bc e0 02     mx LDY  $02E0,X
00:898E  d0 03        mx BNE  $8993
00:8990  bc 30 01     mx LDY  $0130,X

L_008993:   ; xref 00898E
00:8993  b9 42 8a     mx LDA  $8A42,Y
00:8996  f0 41        mx BEQ  $89D9
00:8998  20 db 89     mx JSR  $89DB
00:899B  e2 30        mx SEP  #$30
00:899D  b9 42 8a     mx LDA  $8A42,Y
00:89A0  85 2c        mx STA  $2C
00:89A2  b9 51 8a     mx LDA  $8A51,Y
00:89A5  85 2d        mx STA  $2D
00:89A7  b9 60 8a     mx LDA  $8A60,Y
00:89AA  85 2e        mx STA  $2E
00:89AC  b9 6f 8a     mx LDA  $8A6F,Y
00:89AF  85 2f        mx STA  $2F
00:89B1  b9 7e 8a     mx LDA  $8A7E,Y
00:89B4  85 30        mx STA  $30
00:89B6  b9 8d 8a     mx LDA  $8A8D,Y
00:89B9  85 31        mx STA  $31
00:89BB  b9 9c 8a     mx LDA  $8A9C,Y
00:89BE  85 32        mx STA  $32
00:89C0  a9 01        mx LDA  #$01
00:89C2  85 29        mx STA  $29
00:89C4  a9 80        mx LDA  #$80
00:89C6  85 2a        mx STA  $2A
00:89C8  a9 18        mx LDA  #$18
00:89CA  85 2b        mx STA  $2B
00:89CC  bc 10 03     mx LDY  $0310,X
00:89CF  b7 3b        mx LDA  [$3B],Y
00:89D1  18           mx CLC  
00:89D2  65 2e        mx ADC  $2E
00:89D4  85 2e        mx STA  $2E
00:89D6  20 ed 82     mx JSR  $82ED

L_0089D9:   ; xref 008996
00:89D9  28           mx PLP  
00:89DA  60           mx RTS  

L_0089DB:   ; xref 008998
00:89DB  e2 30        mx SEP  #$30
00:89DD  5a           mx PHY  
00:89DE  b9 15 8a     mx LDA  $8A15,Y
00:89E1  85 02        mx STA  $02
00:89E3  b9 24 8a     mx LDA  $8A24,Y
00:89E6  85 00        mx STA  $00
00:89E8  b9 33 8a     mx LDA  $8A33,Y
00:89EB  85 01        mx STA  $01
00:89ED  c2 30        mx REP  #$30
00:89EF  98           MX TYA  
00:89F0  29 ff 00     MX AND  #$00FF
00:89F3  0a           MX ASL  
00:89F4  a8           MX TAY  
00:89F5  b9 e7 8a     MX LDA  $8AE7,Y
00:89F8  f0 08        MX BEQ  $8A02
00:89FA  85 00        MX STA  $00
00:89FC  e2 30        MX SEP  #$30
00:89FE  a9 7e        mx LDA  #$7E
00:8A00  85 02        mx STA  $02

L_008A02:   ; xref 0089F8
00:8A02  e2 30        mx SEP  #$30
00:8A04  a5 02        mx LDA  $02
00:8A06  85 3d        mx STA  $3D
00:8A08  a0 0a        mx LDY  #$0A
00:8A0A  b7 00        mx LDA  [$00],Y
00:8A0C  85 3b        mx STA  $3B
00:8A0E  c8           mx INY  
00:8A0F  b7 00        mx LDA  [$00],Y
00:8A11  85 3c        mx STA  $3C
00:8A13  7a           mx PLY  
00:8A14  60           mx RTS  

L_009BD1:   ; xref 008076
00:9BD1  08           mx PHP  
00:9BD2  e2 30        mx SEP  #$30
00:9BD4  64 aa        mx STZ  $AA
00:9BD6  a0 00        mx LDY  #$00
00:9BD8  98           mx TYA  

L_009BD9:   ; xref 009BDF
00:9BD9  99 00 01     mx STA  $0100,Y
00:9BDC  c8           mx INY  
00:9BDD  c0 30        mx CPY  #$30
00:9BDF  d0 f8        mx BNE  $9BD9
00:9BE1  28           mx PLP  
00:9BE2  60           mx RTS  
00:9BEF  20 1c 9c     MX JSR  $9C1C
00:9BF2  6b           MX RTL  

L_009BF3:   ; xref 00A63C 00ACF1
00:9BF3  20 0a 9c     MX JSR  $9C0A
00:9BF6  80 03        MX BRA  $9BFB

L_009BF8:   ; xref 00A4CB 00A0E6
00:9BF8  20 1c 9c     MX JSR  $9C1C

L_009BFB:   ; xref 009BF6
00:9BFB  08           MX PHP  
00:9BFC  e2 30        MX SEP  #$30
00:9BFE  48           mx PHA  
00:9BFF  b9 00 01     mx LDA  $0100,Y
00:9C02  09 01        mx ORA  #$01
00:9C04  99 00 01     mx STA  $0100,Y
00:9C07  68           mx PLA  
00:9C08  28           mx PLP  
00:9C09  60           mx RTS  

L_009C0A:   ; xref 009BF3 00A992
00:9C0A  08           MX PHP  
00:9C0B  c2 20        MX REP  #$20
00:9C0D  48           MX PHA  
00:9C0E  a5 21        MX LDA  $21
00:9C10  85 00        MX STA  $00
00:9C12  a5 23        MX LDA  $23
00:9C14  85 03        MX STA  $03
00:9C16  68           MX PLA  
00:9C17  20 1c 9c     MX JSR  $9C1C
00:9C1A  28           MX PLP  
00:9C1B  60           MX RTS  

L_009C1C:   ; xref 009BF8 009C17 00A966 00AA00 00AA2A 00AEB3
00:9C1C  08           MX PHP  
00:9C1D  c2 20        MX REP  #$20
00:9C1F  48           MX PHA  
00:9C20  e2 30        MX SEP  #$30
00:9C22  da           mx PHX  
00:9C23  22 6f 9c 80  mx JSL  $809C6F
00:9C27  da           mx PHX  
00:9C28  7a           mx PLY  
00:9C29  fa           mx PLX  
00:9C2A  a5 00        mx LDA  $00
00:9C2C  99 f0 01     mx STA  $01F0,Y
00:9C2F  a5 01        mx LDA  $01
00:9C31  99 90 07     mx STA  $0790,Y
00:9C34  a5 03        mx LDA  $03
00:9C36  99 20 02     mx STA  $0220,Y
00:9C39  a5 04        mx LDA  $04
00:9C3B  99 c0 07     mx STA  $07C0,Y
00:9C3E  c2 20        mx REP  #$20
00:9C40  68           Mx PLA  
00:9C41  e2 20        Mx SEP  #$20
00:9C43  99 30 01     mx STA  $0130,Y
00:9C46  eb           mx XBA  
00:9C47  99 60 01     mx STA  $0160,Y
00:9C4A  a9 00        mx LDA  #$00
00:9C4C  99 e0 02     mx STA  $02E0,Y
00:9C4F  da           mx PHX  
00:9C50  5a           mx PHY  
00:9C51  fa           mx PLX  
00:9C52  22 1a 85 80  mx JSL  $80851A
00:9C56  da           mx PHX  
00:9C57  7a           mx PLY  
00:9C58  fa           mx PLX  
00:9C59  28           mx PLP  
00:9C5A  60           mx RTS  
00:9C6F  20 73 9c     mx JSR  $9C73
00:9C72  6b           mx RTL  

L_009C73:   ; xref 009C6F
00:9C73  08           mx PHP  
00:9C74  e2 30        mx SEP  #$30
00:9C76  a5 aa        mx LDA  $AA
00:9C78  c9 30        mx CMP  #$30
00:9C7A  d0 05        mx BNE  $9C81
00:9C7C  a2 ff        mx LDX  #$FF
00:9C7E  4c 8d 9c     mx JMP  $9C8D

L_009C81:   ; xref 009C7A
00:9C81  20 8f 9c     mx JSR  $9C8F
00:9C84  e2 30        mx SEP  #$30
00:9C86  a9 80        mx LDA  #$80
00:9C88  9d 00 01     mx STA  $0100,X
00:9C8B  e6 aa        mx INC  $AA

L_009C8D:   ; xref 009C7E
00:9C8D  28           mx PLP  
00:9C8E  60           mx RTS  

L_009C8F:   ; xref 009C81
00:9C8F  e2 30        mx SEP  #$30
00:9C91  a2 00        mx LDX  #$00

L_009C93:   ; xref 009C99
00:9C93  bd 00 01     mx LDA  $0100,X
00:9C96  10 04        mx BPL  $9C9C
00:9C98  e8           mx INX  
00:9C99  4c 93 9c     mx JMP  $9C93

L_009C9C:   ; xref 009C96
00:9C9C  60           mx RTS  

L_009CA1:   ; xref 00A510 00A169 00A0B4 00A189 00A1F9 00A2F0
00:9CA1  08           mx PHP  
00:9CA2  e2 30        mx SEP  #$30
00:9CA4  bd 00 01     mx LDA  $0100,X
00:9CA7  10 05        mx BPL  $9CAE
00:9CA9  9e 00 01     mx STZ  $0100,X
00:9CAC  c6 aa        mx DEC  $AA

L_009CAE:   ; xref 009CA7
00:9CAE  28           mx PLP  
00:9CAF  60           mx RTS  

L_009CB0:   ; xref 0082D4
00:9CB0  08           MX PHP  
00:9CB1  e2 30        MX SEP  #$30
00:9CB3  a5 ab        mx LDA  $AB
00:9CB5  85 ac        mx STA  $AC
00:9CB7  64 ab        mx STZ  $AB
00:9CB9  c2 10        mx REP  #$10
00:9CBB  a2 00 00     mX LDX  #$0000

L_009CBE:   ; xref 009CD1
00:9CBE  e2 30        mX SEP  #$30
00:9CC0  bd 00 01     mx LDA  $0100,X
00:9CC3  29 81        mx AND  #$81
00:9CC5  c9 81        mx CMP  #$81
00:9CC7  d0 03        mx BNE  $9CCC
00:9CC9  20 f3 9c     mx JSR  $9CF3

L_009CCC:   ; xref 009CC7
00:9CCC  e2 30        mx SEP  #$30
00:9CCE  e8           mx INX  
00:9CCF  e0 30        mx CPX  #$30
00:9CD1  d0 eb        mx BNE  $9CBE
00:9CD3  c2 10        mx REP  #$10
00:9CD5  a2 00 00     mX LDX  #$0000
00:9CD8  e2 10        mX SEP  #$10

L_009CDA:   ; xref 009CEB
00:9CDA  bd 00 01     mx LDA  $0100,X
00:9CDD  29 81        mx AND  #$81
00:9CDF  c9 80        mx CMP  #$80
00:9CE1  d0 03        mx BNE  $9CE6
00:9CE3  20 f3 9c     mx JSR  $9CF3

L_009CE6:   ; xref 009CE1
00:9CE6  e2 30        mx SEP  #$30
00:9CE8  e8           mx INX  
00:9CE9  e0 30        mx CPX  #$30
00:9CEB  d0 ed        mx BNE  $9CDA
00:9CED  22 ef 84 80  mx JSL  $8084EF
00:9CF1  28           mx PLP  
00:9CF2  60           mx RTS  

L_009CF3:   ; xref 009CC9 009CE3
00:9CF3  e2 30        mx SEP  #$30
00:9CF5  86 ad        mx STX  $AD
00:9CF7  a5 ab        mx LDA  $AB
00:9CF9  9d 50 02     mx STA  $0250,X
00:9CFC  18           mx CLC  
00:9CFD  69 0a        mx ADC  #$0A
00:9CFF  c9 80        mx CMP  #$80
00:9D01  90 01        mx BCC  $9D04
00:9D03  60           mx RTS  

L_009D04:   ; xref 009D01
00:9D04  20 6d 85     mx JSR  $856D
00:9D07  bd 00 01     mx LDA  $0100,X
00:9D0A  89 40        mx BIT  #$40
00:9D0C  d0 01        mx BNE  $9D0F
00:9D0E  60           mx RTS  

L_009D0F:   ; xref 009D0C
00:9D0F  20 17 86     mx JSR  $8617
00:9D12  90 01        mx BCC  $9D15
00:9D14  60           mx RTS  

L_009D15:   ; xref 009D12
00:9D15  e2 30        mx SEP  #$30
00:9D17  bd b0 05     mx LDA  $05B0,X
00:9D1A  29 7f        mx AND  #$7F
00:9D1C  18           mx CLC  
00:9D1D  65 ab        mx ADC  $AB
00:9D1F  85 ab        mx STA  $AB
00:9D21  60           mx RTS  

L_009D78:   ; xref 008257 00C696 00C6B4 00C6CF 00C02D 00C08D
00:9D78  22 21 80 81  MX JSL  $818021
00:9D7C  60           MX RTS  

L_009D7D:   ; xref 00828F 00C6A1 00C6BF 00C6DA 00C038 00C098
00:9D7D  22 00 80 81  MX JSL  $818000
00:9D81  60           MX RTS  

L_009D82:   ; xref 008079
00:9D82  08           mx PHP  
00:9D83  e2 30        mx SEP  #$30
00:9D85  a5 9e        mx LDA  $9E
00:9D87  29 f0        mx AND  #$F0
00:9D89  85 9e        mx STA  $9E
00:9D8B  28           mx PLP  
00:9D8C  60           mx RTS  

L_009DA6:   ; xref 0080F8 008114 008156 0081E8 00C63B 00C67D
00:9DA6  08           Mx PHP  
00:9DA7  c2 20        Mx REP  #$20
00:9DA9  a7 0c        Mx LDA  [$0C]
00:9DAB  85 06        Mx STA  $06
00:9DAD  e6 0c        Mx INC  $0C
00:9DAF  e6 0c        Mx INC  $0C
00:9DB1  e2 20        Mx SEP  #$20
00:9DB3  a5 11        mx LDA  $11
00:9DB5  85 2b        mx STA  $2B
00:9DB7  20 bc 9d     mx JSR  $9DBC
00:9DBA  28           mx PLP  
00:9DBB  60           mx RTS  

L_009DBC:   ; xref 009DB7 00A039 00A005
00:9DBC  c2 20        mx REP  #$20
00:9DBE  a5 06        Mx LDA  $06
00:9DC0  d0 01        Mx BNE  $9DC3
00:9DC2  60           Mx RTS  

L_009DC3:   ; xref 009DC0
00:9DC3  e2 30        Mx SEP  #$30
00:9DC5  a7 0c        mx LDA  [$0C]
00:9DC7  2a           mx ROL  
00:9DC8  2a           mx ROL  
00:9DC9  85 00        mx STA  $00
00:9DCB  2a           mx ROL  
00:9DCC  29 03        mx AND  #$03
00:9DCE  0a           mx ASL  
00:9DCF  aa           mx TAX  
00:9DD0  7c d3 9d     mx JMP  ($9DD3,X)

L_009DDB:   ; xref 009DD0
00:9DDB  a9 00        mx LDA  #$00

L_009DDD:   ; xref 009DE4
00:9DDD  26 00        mx ROL  $00
00:9DDF  90 06        mx BCC  $9DE7
00:9DE1  18           mx CLC  
00:9DE2  69 02        mx ADC  #$02
00:9DE4  4c dd 9d     mx JMP  $9DDD

L_009DE7:   ; xref 009DDF
00:9DE7  aa           mx TAX  
00:9DE8  7c eb 9d     mx JMP  ($9DEB,X)

L_009DF3:   ; xref 009DD0
00:9DF3  e2 30        mx SEP  #$30
00:9DF5  a7 0c        mx LDA  [$0C]
00:9DF7  29 03        mx AND  #$03
00:9DF9  18           mx CLC  
00:9DFA  69 03        mx ADC  #$03
00:9DFC  85 2c        mx STA  $2C
00:9DFE  64 2d        mx STZ  $2D
00:9E00  a7 0c        mx LDA  [$0C]
00:9E02  4a           mx LSR  
00:9E03  4a           mx LSR  
00:9E04  85 29        mx STA  $29
00:9E06  64 2a        mx STZ  $2A
00:9E08  c2 20        mx REP  #$20
00:9E0A  e6 0c        Mx INC  $0C
00:9E0C  a5 0c        Mx LDA  $0C
00:9E0E  d0 09        Mx BNE  $9E19
00:9E10  a9 00 80     Mx LDA  #$8000
00:9E13  85 0c        Mx STA  $0C
00:9E15  e2 20        Mx SEP  #$20
00:9E17  e6 0e        mx INC  $0E

L_009E19:   ; xref 009E0E
00:9E19  4c dc 9f     mx JMP  $9FDC

L_009E1C:   ; xref 009DD0
00:9E1C  e2 30        mx SEP  #$30
00:9E1E  a7 0c        mx LDA  [$0C]
00:9E20  29 03        mx AND  #$03
00:9E22  18           mx CLC  
00:9E23  69 03        mx ADC  #$03
00:9E25  85 2c        mx STA  $2C
00:9E27  64 2d        mx STZ  $2D
00:9E29  a7 0c        mx LDA  [$0C]
00:9E2B  4a           mx LSR  
00:9E2C  4a           mx LSR  
00:9E2D  29 0f        mx AND  #$0F
00:9E2F  85 2a        mx STA  $2A
00:9E31  c2 20        mx REP  #$20
00:9E33  e6 0c        Mx INC  $0C
00:9E35  a5 0c        Mx LDA  $0C
00:9E37  d0 09        Mx BNE  $9E42
00:9E39  a9 00 80     Mx LDA  #$8000
00:9E3C  85 0c        Mx STA  $0C
00:9E3E  e2 20        Mx SEP  #$20
00:9E40  e6 0e        mx INC  $0E

L_009E42:   ; xref 009E37
00:9E42  e2 30        mx SEP  #$30
00:9E44  a7 0c        mx LDA  [$0C]
00:9E46  85 29        mx STA  $29
00:9E48  c2 20        mx REP  #$20
00:9E4A  e6 0c        Mx INC  $0C
00:9E4C  a5 0c        Mx LDA  $0C
00:9E4E  d0 09        Mx BNE  $9E59
00:9E50  a9 00 80     Mx LDA  #$8000
00:9E53  85 0c        Mx STA  $0C
00:9E55  e2 20        Mx SEP  #$20
00:9E57  e6 0e        mx INC  $0E

L_009E59:   ; xref 009E4E
00:9E59  4c dc 9f     mx JMP  $9FDC

L_009E5C:   ; xref 009DD0
00:9E5C  e2 30        mx SEP  #$30
00:9E5E  a7 0c        mx LDA  [$0C]
00:9E60  29 03        mx AND  #$03
00:9E62  8d 2a 00     mx STA  $002A
00:9E65  a7 0c        mx LDA  [$0C]
00:9E67  4a           mx LSR  
00:9E68  4a           mx LSR  
00:9E69  29 0f        mx AND  #$0F
00:9E6B  18           mx CLC  
00:9E6C  69 07        mx ADC  #$07
00:9E6E  85 2c        mx STA  $2C
00:9E70  64 2d        mx STZ  $2D
00:9E72  c2 20        mx REP  #$20
00:9E74  e6 0c        Mx INC  $0C
00:9E76  a5 0c        Mx LDA  $0C
00:9E78  d0 09        Mx BNE  $9E83
00:9E7A  a9 00 80     Mx LDA  #$8000
00:9E7D  85 0c        Mx STA  $0C
00:9E7F  e2 20        Mx SEP  #$20
00:9E81  e6 0e        mx INC  $0E

L_009E83:   ; xref 009E78
00:9E83  e2 30        mx SEP  #$30
00:9E85  a7 0c        mx LDA  [$0C]
00:9E87  85 29        mx STA  $29
00:9E89  c2 20        mx REP  #$20
00:9E8B  e6 0c        Mx INC  $0C
00:9E8D  a5 0c        Mx LDA  $0C
00:9E8F  d0 09        Mx BNE  $9E9A
00:9E91  a9 00 80     Mx LDA  #$8000
00:9E94  85 0c        Mx STA  $0C
00:9E96  e2 20        Mx SEP  #$20
00:9E98  e6 0e        mx INC  $0E

L_009E9A:   ; xref 009E8F
00:9E9A  4c dc 9f     mx JMP  $9FDC

L_009E9D:   ; xref 009DE8
00:9E9D  e2 30        mx SEP  #$30
00:9E9F  a7 0c        mx LDA  [$0C]
00:9EA1  29 0f        mx AND  #$0F
00:9EA3  85 2c        mx STA  $2C
00:9EA5  a7 0c        mx LDA  [$0C]
00:9EA7  4a           mx LSR  
00:9EA8  4a           mx LSR  
00:9EA9  4a           mx LSR  
00:9EAA  4a           mx LSR  
00:9EAB  29 01        mx AND  #$01
00:9EAD  85 00        mx STA  $00
00:9EAF  c2 20        mx REP  #$20
00:9EB1  e6 0c        Mx INC  $0C
00:9EB3  a5 0c        Mx LDA  $0C
00:9EB5  d0 09        Mx BNE  $9EC0
00:9EB7  a9 00 80     Mx LDA  #$8000
00:9EBA  85 0c        Mx STA  $0C
00:9EBC  e2 20        Mx SEP  #$20
00:9EBE  e6 0e        mx INC  $0E

L_009EC0:   ; xref 009EB5
00:9EC0  e2 30        mx SEP  #$30
00:9EC2  a7 0c        mx LDA  [$0C]
00:9EC4  29 f0        mx AND  #$F0
00:9EC6  05 2c        mx ORA  $2C
00:9EC8  18           mx CLC  
00:9EC9  69 07        mx ADC  #$07
00:9ECB  85 2c        mx STA  $2C
00:9ECD  a5 00        mx LDA  $00
00:9ECF  69 00        mx ADC  #$00
00:9ED1  85 2d        mx STA  $2D
00:9ED3  a7 0c        mx LDA  [$0C]
00:9ED5  29 0f        mx AND  #$0F
00:9ED7  85 2a        mx STA  $2A
00:9ED9  c2 20        mx REP  #$20
00:9EDB  e6 0c        Mx INC  $0C
00:9EDD  a5 0c        Mx LDA  $0C
00:9EDF  d0 09        Mx BNE  $9EEA
00:9EE1  a9 00 80     Mx LDA  #$8000
00:9EE4  85 0c        Mx STA  $0C
00:9EE6  e2 20        Mx SEP  #$20
00:9EE8  e6 0e        mx INC  $0E

L_009EEA:   ; xref 009EDF
00:9EEA  e2 30        mx SEP  #$30
00:9EEC  a7 0c        mx LDA  [$0C]
00:9EEE  85 29        mx STA  $29
00:9EF0  c2 20        mx REP  #$20
00:9EF2  e6 0c        Mx INC  $0C
00:9EF4  a5 0c        Mx LDA  $0C
00:9EF6  d0 09        Mx BNE  $9F01
00:9EF8  a9 00 80     Mx LDA  #$8000
00:9EFB  85 0c        Mx STA  $0C
00:9EFD  e2 20        Mx SEP  #$20
00:9EFF  e6 0e        mx INC  $0E

L_009F01:   ; xref 009EF6
00:9F01  4c dc 9f     mx JMP  $9FDC

L_009F04:   ; xref 009DE8
00:9F04  e2 30        mx SEP  #$30
00:9F06  a7 0c        mx LDA  [$0C]
00:9F08  29 07        mx AND  #$07
00:9F0A  85 2d        mx STA  $2D
00:9F0C  c2 20        mx REP  #$20
00:9F0E  e6 0c        Mx INC  $0C
00:9F10  a5 0c        Mx LDA  $0C
00:9F12  d0 09        Mx BNE  $9F1D
00:9F14  a9 00 80     Mx LDA  #$8000
00:9F17  85 0c        Mx STA  $0C
00:9F19  e2 20        Mx SEP  #$20
00:9F1B  e6 0e        mx INC  $0E

L_009F1D:   ; xref 009F12
00:9F1D  e2 30        mx SEP  #$30
00:9F1F  a7 0c        mx LDA  [$0C]
00:9F21  85 2c        mx STA  $2C
00:9F23  c2 20        mx REP  #$20
00:9F25  e6 0c        Mx INC  $0C
00:9F27  a5 0c        Mx LDA  $0C
00:9F29  d0 09        Mx BNE  $9F34
00:9F2B  a9 00 80     Mx LDA  #$8000
00:9F2E  85 0c        Mx STA  $0C
00:9F30  e2 20        Mx SEP  #$20
00:9F32  e6 0e        mx INC  $0E

L_009F34:   ; xref 009F29
00:9F34  e2 30        mx SEP  #$30
00:9F36  a7 0c        mx LDA  [$0C]
00:9F38  66 2d        mx ROR  $2D
00:9F3A  6a           mx ROR  
00:9F3B  66 2d        mx ROR  $2D
00:9F3D  6a           mx ROR  
00:9F3E  66 2d        mx ROR  $2D
00:9F40  6a           mx ROR  
00:9F41  4a           mx LSR  
00:9F42  85 2d        mx STA  $2D
00:9F44  c2 20        mx REP  #$20
00:9F46  a5 2c        Mx LDA  $2C
00:9F48  18           Mx CLC  
00:9F49  69 07 02     Mx ADC  #$0207
00:9F4C  85 2c        Mx STA  $2C
00:9F4E  e2 20        Mx SEP  #$20
00:9F50  a7 0c        mx LDA  [$0C]
00:9F52  29 0f        mx AND  #$0F
00:9F54  85 2a        mx STA  $2A
00:9F56  c2 20        mx REP  #$20
00:9F58  e6 0c        Mx INC  $0C
00:9F5A  a5 0c        Mx LDA  $0C
00:9F5C  d0 09        Mx BNE  $9F67
00:9F5E  a9 00 80     Mx LDA  #$8000
00:9F61  85 0c        Mx STA  $0C
00:9F63  e2 20        Mx SEP  #$20
00:9F65  e6 0e        mx INC  $0E

L_009F67:   ; xref 009F5C
00:9F67  e2 30        mx SEP  #$30
00:9F69  a7 0c        mx LDA  [$0C]
00:9F6B  85 29        mx STA  $29
00:9F6D  c2 20        mx REP  #$20
00:9F6F  e6 0c        Mx INC  $0C
00:9F71  a5 0c        Mx LDA  $0C
00:9F73  d0 09        Mx BNE  $9F7E
00:9F75  a9 00 80     Mx LDA  #$8000
00:9F78  85 0c        Mx STA  $0C
00:9F7A  e2 20        Mx SEP  #$20
00:9F7C  e6 0e        mx INC  $0E

L_009F7E:   ; xref 009F73
00:9F7E  4c dc 9f     mx JMP  $9FDC

L_009F81:   ; xref 009DE8
00:9F81  e2 30        mx SEP  #$30
00:9F83  a7 0c        mx LDA  [$0C]
00:9F85  29 03        mx AND  #$03
00:9F87  85 00        mx STA  $00
00:9F89  c2 20        mx REP  #$20
00:9F8B  e6 0c        Mx INC  $0C
00:9F8D  a5 0c        Mx LDA  $0C
00:9F8F  d0 09        Mx BNE  $9F9A
00:9F91  a9 00 80     Mx LDA  #$8000
00:9F94  85 0c        Mx STA  $0C
00:9F96  e2 20        Mx SEP  #$20
00:9F98  e6 0e        mx INC  $0E

L_009F9A:   ; xref 009F8F
00:9F9A  e2 30        mx SEP  #$30
00:9F9C  a7 0c        mx LDA  [$0C]
00:9F9E  18           mx CLC  
00:9F9F  69 11        mx ADC  #$11
00:9FA1  85 2c        mx STA  $2C
00:9FA3  a5 00        mx LDA  $00
00:9FA5  69 00        mx ADC  #$00
00:9FA7  85 2d        mx STA  $2D
00:9FA9  c2 20        mx REP  #$20
00:9FAB  e6 0c        Mx INC  $0C
00:9FAD  a5 0c        Mx LDA  $0C
00:9FAF  d0 09        Mx BNE  $9FBA
00:9FB1  a9 00 80     Mx LDA  #$8000
00:9FB4  85 0c        Mx STA  $0C
00:9FB6  e2 20        Mx SEP  #$20
00:9FB8  e6 0e        mx INC  $0E

L_009FBA:   ; xref 009FAF
00:9FBA  4c 08 a0     mx JMP  $A008

L_009FBD:   ; xref 009DE8
00:9FBD  e2 30        mx SEP  #$30
00:9FBF  a7 0c        mx LDA  [$0C]
00:9FC1  29 0f        mx AND  #$0F
00:9FC3  1a           mx INC  
00:9FC4  85 2c        mx STA  $2C
00:9FC6  64 2d        mx STZ  $2D
00:9FC8  c2 20        mx REP  #$20
00:9FCA  e6 0c        Mx INC  $0C
00:9FCC  a5 0c        Mx LDA  $0C
00:9FCE  d0 09        Mx BNE  $9FD9
00:9FD0  a9 00 80     Mx LDA  #$8000
00:9FD3  85 0c        Mx STA  $0C
00:9FD5  e2 20        Mx SEP  #$20
00:9FD7  e6 0e        mx INC  $0E

L_009FD9:   ; xref 009FCE
00:9FD9  4c 08 a0     mx JMP  $A008

L_009FDC:   ; xref 009F7E 009F01 009E9A 009E59 009E19
00:9FDC  c2 30        mx REP  #$30
00:9FDE  e6 29        MX INC  $29
00:9FE0  a5 0f        MX LDA  $0F
00:9FE2  38           MX SEC  
00:9FE3  e5 29        MX SBC  $29
00:9FE5  85 29        MX STA  $29
00:9FE7  e2 20        MX SEP  #$20
00:9FE9  a0 00 00     mX LDY  #$0000

L_009FEC:   ; xref 009FF3
00:9FEC  b7 29        mX LDA  [$29],Y
00:9FEE  97 0f        mX STA  [$0F],Y
00:9FF0  c8           mX INY  
00:9FF1  c4 2c        mX CPY  $2C
00:9FF3  d0 f7        mX BNE  $9FEC
00:9FF5  c2 20        mX REP  #$20
00:9FF7  a5 06        MX LDA  $06
00:9FF9  38           MX SEC  
00:9FFA  e5 2c        MX SBC  $2C
00:9FFC  85 06        MX STA  $06
00:9FFE  a5 0f        MX LDA  $0F
00:A000  18           MX CLC  
00:A001  65 2c        MX ADC  $2C
00:A003  85 0f        MX STA  $0F
00:A005  4c bc 9d     MX JMP  $9DBC

L_00A008:   ; xref 009FBA 009FD9
00:A008  c2 10        mx REP  #$10
00:A00A  a0 00 00     mX LDY  #$0000

L_00A00D:   ; xref 00A027
00:A00D  e2 20        mX SEP  #$20
00:A00F  a7 0c        mX LDA  [$0C]
00:A011  97 0f        mX STA  [$0F],Y
00:A013  c2 20        mX REP  #$20
00:A015  e6 0c        MX INC  $0C
00:A017  a5 0c        MX LDA  $0C
00:A019  d0 09        MX BNE  $A024
00:A01B  a9 00 80     MX LDA  #$8000
00:A01E  85 0c        MX STA  $0C
00:A020  e2 20        MX SEP  #$20
00:A022  e6 0e        mX INC  $0E

L_00A024:   ; xref 00A019
00:A024  c8           mX INY  
00:A025  c4 2c        mX CPY  $2C
00:A027  d0 e4        mX BNE  $A00D
00:A029  c2 20        mX REP  #$20
00:A02B  a5 06        MX LDA  $06
00:A02D  38           MX SEC  
00:A02E  e5 2c        MX SBC  $2C
00:A030  85 06        MX STA  $06
00:A032  a5 0f        MX LDA  $0F
00:A034  18           MX CLC  
00:A035  65 2c        MX ADC  $2C
00:A037  85 0f        MX STA  $0F
00:A039  4c bc 9d     MX JMP  $9DBC

L_00A064:   ; xref 00807C
00:A064  08           mx PHP  
00:A065  e2 30        mx SEP  #$30
00:A067  9c c4 0e     mx STZ  $0EC4
00:A06A  c2 30        mx REP  #$30
00:A06C  64 b4        MX STZ  $B4
00:A06E  64 b6        MX STZ  $B6
00:A070  64 b8        MX STZ  $B8
00:A072  64 ba        MX STZ  $BA
00:A074  28           MX PLP  
00:A075  60           MX RTS  

L_00A076:   ; xref 0082D1
00:A076  22 3f 80 81  MX JSL  $81803F
00:A07A  60           MX RTS  

L_00A07B:   ; xref 00A091
00:A07B  08           mx PHP  
00:A07C  e2 30        mx SEP  #$30
00:A07E  a9 18        mx LDA  #$18
00:A080  9d e0 05     mx STA  $05E0,X
00:A083  9e 10 06     mx STZ  $0610,X
00:A086  a9 06        mx LDA  #$06
00:A088  9d 60 01     mx STA  $0160,X
00:A08B  22 54 85 80  mx JSL  $808554
00:A08F  28           mx PLP  
00:A090  6b           mx RTL  
00:A091  4c 7b a0     mx JMP  $A07B
00:A094  08           mx PHP  
00:A095  e2 30        mx SEP  #$30
00:A097  bd 10 06     mx LDA  $0610,X
00:A09A  f0 07        mx BEQ  $A0A3
00:A09C  e2 30        mx SEP  #$30
00:A09E  de 10 06     mx DEC  $0610,X
00:A0A1  80 14        mx BRA  $A0B7

L_00A0A3:   ; xref 00A09A
00:A0A3  e2 30        mx SEP  #$30
00:A0A5  a9 02        mx LDA  #$02
00:A0A7  9d 10 06     mx STA  $0610,X
00:A0AA  20 b9 a0     mx JSR  $A0B9
00:A0AD  e2 30        mx SEP  #$30
00:A0AF  de e0 05     mx DEC  $05E0,X
00:A0B2  d0 03        mx BNE  $A0B7
00:A0B4  20 a1 9c     mx JSR  $9CA1

L_00A0B7:   ; xref 00A0A1 00A0B2
00:A0B7  28           mx PLP  
00:A0B8  6b           mx RTL  

L_00A0B9:   ; xref 00A0AA
00:A0B9  c2 20        mx REP  #$20
00:A0BB  a5 21        Mx LDA  $21
00:A0BD  85 00        Mx STA  $00
00:A0BF  a5 23        Mx LDA  $23
00:A0C1  85 03        Mx STA  $03
00:A0C3  e2 30        Mx SEP  #$30
00:A0C5  bd e0 05     mx LDA  $05E0,X
00:A0C8  0a           mx ASL  
00:A0C9  0a           mx ASL  
00:A0CA  da           mx PHX  
00:A0CB  aa           mx TAX  
00:A0CC  c2 20        mx REP  #$20
00:A0CE  bd ea a0     Mx LDA  $A0EA,X
00:A0D1  18           Mx CLC  
00:A0D2  65 00        Mx ADC  $00
00:A0D4  85 00        Mx STA  $00
00:A0D6  bd ec a0     Mx LDA  $A0EC,X
00:A0D9  18           Mx CLC  
00:A0DA  65 03        Mx ADC  $03
00:A0DC  85 03        Mx STA  $03
00:A0DE  e2 30        Mx SEP  #$30
00:A0E0  fa           mx PLX  
00:A0E1  c2 20        mx REP  #$20
00:A0E3  a9 0e 00     Mx LDA  #$000E
00:A0E6  20 f8 9b     Mx JSR  $9BF8
00:A0E9  60           Mx RTS  

L_00A14E:   ; xref 00A15C
00:A14E  08           mx PHP  
00:A14F  e2 30        mx SEP  #$30
00:A151  a9 06        mx LDA  #$06
00:A153  9d 60 01     mx STA  $0160,X
00:A156  22 54 85 80  mx JSL  $808554
00:A15A  28           mx PLP  
00:A15B  6b           mx RTL  
00:A15C  4c 4e a1     mx JMP  $A14E
00:A15F  08           mx PHP  
00:A160  e2 30        mx SEP  #$30
00:A162  bd 00 01     mx LDA  $0100,X
00:A165  89 20        mx BIT  #$20
00:A167  f0 03        mx BEQ  $A16C
00:A169  20 a1 9c     mx JSR  $9CA1

L_00A16C:   ; xref 00A167
00:A16C  28           mx PLP  
00:A16D  6b           mx RTL  

L_00A16E:   ; xref 00A17C
00:A16E  08           mx PHP  
00:A16F  e2 30        mx SEP  #$30
00:A171  a9 06        mx LDA  #$06
00:A173  9d 60 01     mx STA  $0160,X
00:A176  22 54 85 80  mx JSL  $808554
00:A17A  28           mx PLP  
00:A17B  6b           mx RTL  
00:A17C  4c 6e a1     mx JMP  $A16E
00:A17F  08           mx PHP  
00:A180  e2 30        mx SEP  #$30
00:A182  bd 00 01     mx LDA  $0100,X
00:A185  89 20        mx BIT  #$20
00:A187  f0 12        mx BEQ  $A19B
00:A189  20 a1 9c     mx JSR  $9CA1
00:A18C  e2 30        mx SEP  #$30
00:A18E  a9 01        mx LDA  #$01
00:A190  8d d6 0e     mx STA  $0ED6
00:A193  c2 20        mx REP  #$20
00:A195  a9 78 00     Mx LDA  #$0078
00:A198  8d da 0e     Mx STA  $0EDA

L_00A19B:   ; xref 00A187
00:A19B  28           Mx PLP  
00:A19C  6b           Mx RTL  

L_00A19D:   ; xref 00A1AB
00:A19D  08           mx PHP  
00:A19E  e2 30        mx SEP  #$30
00:A1A0  a9 06        mx LDA  #$06
00:A1A2  9d 60 01     mx STA  $0160,X
00:A1A5  22 54 85 80  mx JSL  $808554
00:A1A9  28           mx PLP  
00:A1AA  6b           mx RTL  
00:A1AB  4c 9d a1     mx JMP  $A19D
00:A1AE  08           mx PHP  
00:A1AF  c2 30        mx REP  #$30
00:A1B1  a5 23        MX LDA  $23
00:A1B3  c9 e0 00     MX CMP  #$00E0
00:A1B6  f0 41        MX BEQ  $A1F9
00:A1B8  e2 30        MX SEP  #$30
00:A1BA  bd 00 01     mx LDA  $0100,X
00:A1BD  89 20        mx BIT  #$20
00:A1BF  f0 19        mx BEQ  $A1DA
00:A1C1  e2 30        mx SEP  #$30
00:A1C3  bd 60 01     mx LDA  $0160,X
00:A1C6  c9 07        mx CMP  #$07
00:A1C8  f0 10        mx BEQ  $A1DA
00:A1CA  e2 30        mx SEP  #$30
00:A1CC  a9 3c        mx LDA  #$3C
00:A1CE  9d e0 05     mx STA  $05E0,X
00:A1D1  a9 07        mx LDA  #$07
00:A1D3  9d 60 01     mx STA  $0160,X
00:A1D6  22 54 85 80  mx JSL  $808554

L_00A1DA:   ; xref 00A1BF 00A1C8
00:A1DA  e2 30        mx SEP  #$30
00:A1DC  bd 60 01     mx LDA  $0160,X
00:A1DF  c9 07        mx CMP  #$07
00:A1E1  d0 14        mx BNE  $A1F7
00:A1E3  e2 30        mx SEP  #$30
00:A1E5  bd 00 01     mx LDA  $0100,X
00:A1E8  49 02        mx EOR  #$02
00:A1EA  9d 00 01     mx STA  $0100,X
00:A1ED  e2 30        mx SEP  #$30
00:A1EF  de e0 05     mx DEC  $05E0,X
00:A1F2  bd e0 05     mx LDA  $05E0,X
00:A1F5  f0 02        mx BEQ  $A1F9

L_00A1F7:   ; xref 00A1E1
00:A1F7  28           mx PLP  
00:A1F8  6b           mx RTL  

L_00A1F9:   ; xref 00A1B6 00A1F5
00:A1F9  20 a1 9c     mx JSR  $9CA1
00:A1FC  28           mx PLP  
00:A1FD  6b           mx RTL  

L_00A1FE:   ; xref 00A216
00:A1FE  08           mx PHP  
00:A1FF  e2 30        mx SEP  #$30
00:A201  a9 0d        mx LDA  #$0D
00:A203  9d 60 01     mx STA  $0160,X
00:A206  22 54 85 80  mx JSL  $808554
00:A20A  e2 30        mx SEP  #$30
00:A20C  bd 00 01     mx LDA  $0100,X
00:A20F  09 10        mx ORA  #$10
00:A211  9d 00 01     mx STA  $0100,X
00:A214  28           mx PLP  
00:A215  6b           mx RTL  
00:A216  4c fe a1     mx JMP  $A1FE
00:A219  08           mx PHP  
00:A21A  c2 30        mx REP  #$30
00:A21C  e6 23        MX INC  $23
00:A21E  a5 23        MX LDA  $23
00:A220  c9 e0 00     MX CMP  #$00E0
00:A223  d0 03        MX BNE  $A228
00:A225  20 a1 9c     MX JSR  $9CA1

L_00A228:   ; xref 00A223
00:A228  28           MX PLP  
00:A229  6b           MX RTL  

L_00A22A:   ; xref 00A242
00:A22A  08           mx PHP  
00:A22B  e2 30        mx SEP  #$30
00:A22D  a9 0e        mx LDA  #$0E
00:A22F  9d 60 01     mx STA  $0160,X
00:A232  22 54 85 80  mx JSL  $808554
00:A236  e2 30        mx SEP  #$30
00:A238  bd 00 01     mx LDA  $0100,X
00:A23B  09 10        mx ORA  #$10
00:A23D  9d 00 01     mx STA  $0100,X
00:A240  28           mx PLP  
00:A241  6b           mx RTL  
00:A242  4c 2a a2     mx JMP  $A22A
00:A245  08           mx PHP  
00:A246  c2 30        mx REP  #$30
00:A248  e6 23        MX INC  $23
00:A24A  a5 23        MX LDA  $23
00:A24C  c9 e0 00     MX CMP  #$00E0
00:A24F  d0 03        MX BNE  $A254
00:A251  20 a1 9c     MX JSR  $9CA1

L_00A254:   ; xref 00A24F
00:A254  28           MX PLP  
00:A255  6b           MX RTL  

L_00A256:   ; xref 00A278
00:A256  08           mx PHP  
00:A257  e2 30        mx SEP  #$30
00:A259  9e e0 05     mx STZ  $05E0,X
00:A25C  a9 08        mx LDA  #$08
00:A25E  9d 00 07     mx STA  $0700,X
00:A261  e2 30        mx SEP  #$30
00:A263  a9 00        mx LDA  #$00
00:A265  9d 60 01     mx STA  $0160,X
00:A268  22 54 85 80  mx JSL  $808554
00:A26C  e2 30        mx SEP  #$30
00:A26E  bd 00 01     mx LDA  $0100,X
00:A271  09 10        mx ORA  #$10
00:A273  9d 00 01     mx STA  $0100,X
00:A276  28           mx PLP  
00:A277  6b           mx RTL  
00:A278  4c 56 a2     mx JMP  $A256
00:A27B  08           mx PHP  
00:A27C  e2 30        mx SEP  #$30
00:A27E  ad 90 07     mx LDA  $0790
00:A281  eb           mx XBA  
00:A282  ad f0 01     mx LDA  $01F0
00:A285  c2 30        mx REP  #$30
00:A287  38           MX SEC  
00:A288  e5 21        MX SBC  $21
00:A28A  89 00 80     MX BIT  #$8000
00:A28D  f0 04        MX BEQ  $A293
00:A28F  49 ff ff     MX EOR  #$FFFF
00:A292  1a           MX INC  

L_00A293:   ; xref 00A28D
00:A293  c9 18 00     MX CMP  #$0018
00:A296  b0 07        MX BCS  $A29F
00:A298  e2 30        MX SEP  #$30
00:A29A  a9 01        mx LDA  #$01
00:A29C  9d e0 05     mx STA  $05E0,X

L_00A29F:   ; xref 00A296
00:A29F  c2 30        mx REP  #$30
00:A2A1  a9 30 00     MX LDA  #$0030
00:A2A4  c6 21        MX DEC  $21
00:A2A6  e2 30        MX SEP  #$30
00:A2A8  bd e0 05     mx LDA  $05E0,X
00:A2AB  f0 08        mx BEQ  $A2B5
00:A2AD  c2 30        mx REP  #$30
00:A2AF  c6 21        MX DEC  $21
00:A2B1  c6 21        MX DEC  $21
00:A2B3  c6 21        MX DEC  $21

L_00A2B5:   ; xref 00A2AB
00:A2B5  c2 30        MX REP  #$30
00:A2B7  a5 21        MX LDA  $21
00:A2B9  89 00 80     MX BIT  #$8000
00:A2BC  f0 03        MX BEQ  $A2C1
00:A2BE  20 a1 9c     MX JSR  $9CA1

L_00A2C1:   ; xref 00A2BC
00:A2C1  28           MX PLP  
00:A2C2  6b           MX RTL  

L_00A2C3:   ; xref 00A2DB
00:A2C3  08           mx PHP  
00:A2C4  e2 30        mx SEP  #$30
00:A2C6  a9 08        mx LDA  #$08
00:A2C8  9d 60 01     mx STA  $0160,X
00:A2CB  22 54 85 80  mx JSL  $808554
00:A2CF  e2 30        mx SEP  #$30
00:A2D1  bd 00 01     mx LDA  $0100,X
00:A2D4  09 10        mx ORA  #$10
00:A2D6  9d 00 01     mx STA  $0100,X
00:A2D9  28           mx PLP  
00:A2DA  6b           mx RTL  
00:A2DB  4c c3 a2     mx JMP  $A2C3
00:A2DE  08           mx PHP  
00:A2DF  c2 30        mx REP  #$30
00:A2E1  a5 23        MX LDA  $23
00:A2E3  18           MX CLC  
00:A2E4  69 03 00     MX ADC  #$0003
00:A2E7  85 23        MX STA  $23
00:A2E9  a5 23        MX LDA  $23
00:A2EB  c9 e0 00     MX CMP  #$00E0
00:A2EE  90 03        MX BCC  $A2F3
00:A2F0  20 a1 9c     MX JSR  $9CA1

L_00A2F3:   ; xref 00A2EE
00:A2F3  28           MX PLP  
00:A2F4  6b           MX RTL  

L_00A2F5:   ; xref 00A319
00:A2F5  08           mx PHP  
00:A2F6  e2 30        mx SEP  #$30
00:A2F8  a9 01        mx LDA  #$01
00:A2FA  9d 60 01     mx STA  $0160,X
00:A2FD  22 54 85 80  mx JSL  $808554
00:A301  e2 30        mx SEP  #$30
00:A303  a9 43        mx LDA  #$43
00:A305  9d e0 05     mx STA  $05E0,X
00:A308  a9 a3        mx LDA  #$A3
00:A30A  9d 40 09     mx STA  $0940,X
00:A30D  e2 30        mx SEP  #$30
00:A30F  bd 00 01     mx LDA  $0100,X
00:A312  09 10        mx ORA  #$10
00:A314  9d 00 01     mx STA  $0100,X
00:A317  28           mx PLP  
00:A318  6b           mx RTL  
00:A319  4c f5 a2     mx JMP  $A2F5
00:A31C  08           mx PHP  
00:A31D  e2 30        mx SEP  #$30
00:A31F  bd 40 09     mx LDA  $0940,X
00:A322  85 0d        mx STA  $0D
00:A324  bd e0 05     mx LDA  $05E0,X
00:A327  85 0c        mx STA  $0C
00:A329  20 3a a3     mx JSR  $A33A
00:A32C  e2 30        mx SEP  #$30
00:A32E  a5 0d        mx LDA  $0D
00:A330  9d 40 09     mx STA  $0940,X
00:A333  a5 0c        mx LDA  $0C
00:A335  9d e0 05     mx STA  $05E0,X
00:A338  28           mx PLP  
00:A339  6b           mx RTL  

L_00A33A:   ; xref 00A329
00:A33A  e2 30        mx SEP  #$30
00:A33C  a9 80        mx LDA  #$80
00:A33E  85 0e        mx STA  $0E
00:A340  dc 0c 00     mx JML  [$000C]
00:A343  e2 30        mx SEP  #$30
00:A345  a9 20        mx LDA  #$20
00:A347  9d 00 07     mx STA  $0700,X
00:A34A  c2 30        mx REP  #$30
00:A34C  a9 80 00     MX LDA  #$0080
00:A34F  85 21        MX STA  $21
00:A351  a9 80 00     MX LDA  #$0080
00:A354  85 23        MX STA  $23
00:A356  e2 30        MX SEP  #$30
00:A358  a9 1e        mx LDA  #$1E
00:A35A  9d 10 06     mx STA  $0610,X
00:A35D  a9 10        mx LDA  #$10
00:A35F  9d 40 06     mx STA  $0640,X
00:A362  c2 20        mx REP  #$20
00:A364  a9 69 a3     Mx LDA  #$A369
00:A367  85 0c        Mx STA  $0C
00:A369  e2 30        mx SEP  #$30
00:A36B  bd 40 06     mx LDA  $0640,X
00:A36E  09 20        mx ORA  #$20
00:A370  8d 32 21     mx STA  $2132
00:A373  bd 40 06     mx LDA  $0640,X
00:A376  f0 03        mx BEQ  $A37B
00:A378  de 40 06     mx DEC  $0640,X

L_00A37B:   ; xref 00A376
00:A37B  e2 30        mx SEP  #$30
00:A37D  bd 00 01     mx LDA  $0100,X
00:A380  49 02        mx EOR  #$02
00:A382  9d 00 01     mx STA  $0100,X
00:A385  de 10 06     mx DEC  $0610,X
00:A388  f0 01        mx BEQ  $A38B
00:A38A  60           mx RTS  

L_00A38B:   ; xref 00A388
00:A38B  e2 30        mx SEP  #$30
00:A38D  bd 00 01     mx LDA  $0100,X
00:A390  09 02        mx ORA  #$02
00:A392  9d 00 01     mx STA  $0100,X
00:A395  e2 30        mx SEP  #$30
00:A397  a9 00        mx LDA  #$00
00:A399  9d 10 06     mx STA  $0610,X
00:A39C  a9 14        mx LDA  #$14
00:A39E  9d 40 06     mx STA  $0640,X
00:A3A1  a9 3c        mx LDA  #$3C
00:A3A3  9d 70 06     mx STA  $0670,X
00:A3A6  9e a0 06     mx STZ  $06A0,X
00:A3A9  c2 30        mx REP  #$30
00:A3AB  a9 01 00     MX LDA  #$0001
00:A3AE  8d ce 0e     MX STA  $0ECE

L_00A3B1:   ; xref 00A4A2
00:A3B1  c2 20        mx REP  #$20
00:A3B3  a9 b8 a3     Mx LDA  #$A3B8
00:A3B6  85 0c        Mx STA  $0C
00:A3B8  20 58 a5     Mx JSR  $A558
00:A3BB  20 3f a5     Mx JSR  $A53F
00:A3BE  20 14 a5     Mx JSR  $A514
00:A3C1  e2 30        Mx SEP  #$30
00:A3C3  ad 90 07     mx LDA  $0790
00:A3C6  eb           mx XBA  
00:A3C7  ad f0 01     mx LDA  $01F0
00:A3CA  c2 20        mx REP  #$20
00:A3CC  38           Mx SEC  
00:A3CD  e5 21        Mx SBC  $21
00:A3CF  89 00 80     Mx BIT  #$8000
00:A3D2  f0 04        Mx BEQ  $A3D8
00:A3D4  49 ff ff     Mx EOR  #$FFFF
00:A3D7  1a           Mx INC  

L_00A3D8:   ; xref 00A3D2
00:A3D8  c9 18 00     Mx CMP  #$0018
00:A3DB  90 0b        Mx BCC  $A3E8
00:A3DD  c2 30        Mx REP  #$30
00:A3DF  ad cc 0e     MX LDA  $0ECC
00:A3E2  f0 01        MX BEQ  $A3E5
00:A3E4  60           MX RTS  

L_00A3E5:   ; xref 00A3E2
00:A3E5  4c b9 a4     MX JMP  $A4B9

L_00A3E8:   ; xref 00A3DB
00:A3E8  e2 30        Mx SEP  #$30
00:A3EA  a9 1e        mx LDA  #$1E
00:A3EC  9d d0 06     mx STA  $06D0,X
00:A3EF  c2 20        mx REP  #$20
00:A3F1  a9 f6 a3     Mx LDA  #$A3F6
00:A3F4  85 0c        Mx STA  $0C
00:A3F6  c2 30        Mx REP  #$30
00:A3F8  ad cc 0e     MX LDA  $0ECC
00:A3FB  d0 03        MX BNE  $A400
00:A3FD  4c b9 a4     MX JMP  $A4B9

L_00A400:   ; xref 00A3FB
00:A400  20 58 a5     MX JSR  $A558
00:A403  e2 30        MX SEP  #$30
00:A405  de d0 06     mx DEC  $06D0,X
00:A408  f0 01        mx BEQ  $A40B
00:A40A  60           mx RTS  

L_00A40B:   ; xref 00A408
00:A40B  e2 30        mx SEP  #$30
00:A40D  9e d0 06     mx STZ  $06D0,X
00:A410  c2 20        mx REP  #$20
00:A412  a9 17 a4     Mx LDA  #$A417
00:A415  85 0c        Mx STA  $0C
00:A417  c2 30        Mx REP  #$30
00:A419  ad cc 0e     MX LDA  $0ECC
00:A41C  d0 03        MX BNE  $A421
00:A41E  4c b9 a4     MX JMP  $A4B9

L_00A421:   ; xref 00A41C
00:A421  e2 30        MX SEP  #$30
00:A423  bd d0 06     mx LDA  $06D0,X
00:A426  da           mx PHX  
00:A427  aa           mx TAX  
00:A428  bd a5 a4     mx LDA  $A4A5,X
00:A42B  fa           mx PLX  
00:A42C  c2 30        mx REP  #$30
00:A42E  29 ff 00     MX AND  #$00FF
00:A431  18           MX CLC  
00:A432  65 23        MX ADC  $23
00:A434  85 23        MX STA  $23
00:A436  e2 30        MX SEP  #$30
00:A438  bd d0 06     mx LDA  $06D0,X
00:A43B  c9 10        mx CMP  #$10
00:A43D  f0 03        mx BEQ  $A442
00:A43F  fe d0 06     mx INC  $06D0,X

L_00A442:   ; xref 00A43D
00:A442  c2 30        mx REP  #$30
00:A444  a5 23        MX LDA  $23
00:A446  c9 dc 00     MX CMP  #$00DC
00:A449  b0 01        MX BCS  $A44C
00:A44B  60           MX RTS  

L_00A44C:   ; xref 00A449
00:A44C  c2 30        MX REP  #$30
00:A44E  a9 dc 00     MX LDA  #$00DC
00:A451  85 23        MX STA  $23
00:A453  e2 30        MX SEP  #$30
00:A455  a9 3c        mx LDA  #$3C
00:A457  9d d0 06     mx STA  $06D0,X
00:A45A  c2 20        mx REP  #$20
00:A45C  a9 61 a4     Mx LDA  #$A461
00:A45F  85 0c        Mx STA  $0C
00:A461  c2 30        Mx REP  #$30
00:A463  ad cc 0e     MX LDA  $0ECC
00:A466  d0 03        MX BNE  $A46B
00:A468  4c b9 a4     MX JMP  $A4B9

L_00A46B:   ; xref 00A466
00:A46B  e2 30        MX SEP  #$30
00:A46D  de d0 06     mx DEC  $06D0,X
00:A470  f0 01        mx BEQ  $A473
00:A472  60           mx RTS  

L_00A473:   ; xref 00A470
00:A473  e2 30        mx SEP  #$30
00:A475  a9 10        mx LDA  #$10
00:A477  9d d0 06     mx STA  $06D0,X
00:A47A  c2 20        mx REP  #$20
00:A47C  a9 81 a4     Mx LDA  #$A481
00:A47F  85 0c        Mx STA  $0C
00:A481  c2 30        mx REP  #$30
00:A483  ad cc 0e     MX LDA  $0ECC
00:A486  d0 03        MX BNE  $A48B
00:A488  4c b9 a4     MX JMP  $A4B9

L_00A48B:   ; xref 00A486
00:A48B  c2 30        MX REP  #$30
00:A48D  bd d0 06     MX LDA  $06D0,X
00:A490  29 ff 00     MX AND  #$00FF
00:A493  c6 23        MX DEC  $23
00:A495  a5 23        MX LDA  $23
00:A497  c9 80 00     MX CMP  #$0080
00:A49A  f0 01        MX BEQ  $A49D
00:A49C  60           MX RTS  

L_00A49D:   ; xref 00A49A
00:A49D  e2 30        MX SEP  #$30
00:A49F  9e 10 06     mx STZ  $0610,X
00:A4A2  4c b1 a3     mx JMP  $A3B1

L_00A4B9:   ; xref 00A488 00A3E5 00A3FD 00A41E 00A468
00:A4B9  c2 30        MX REP  #$30
00:A4BB  9c ce 0e     MX STZ  $0ECE
00:A4BE  c2 20        MX REP  #$20
00:A4C0  a5 21        MX LDA  $21
00:A4C2  85 00        MX STA  $00
00:A4C4  a5 23        MX LDA  $23
00:A4C6  85 03        MX STA  $03
00:A4C8  a9 0d 00     MX LDA  #$000D
00:A4CB  20 f8 9b     MX JSR  $9BF8
00:A4CE  e2 30        MX SEP  #$30
00:A4D0  a9 78        mx LDA  #$78
00:A4D2  9d 10 06     mx STA  $0610,X
00:A4D5  9e 40 06     mx STZ  $0640,X
00:A4D8  c2 20        mx REP  #$20
00:A4DA  a9 df a4     Mx LDA  #$A4DF
00:A4DD  85 0c        Mx STA  $0C
00:A4DF  e2 30        mx SEP  #$30
00:A4E1  bd 40 06     mx LDA  $0640,X
00:A4E4  09 20        mx ORA  #$20
00:A4E6  8d 32 21     mx STA  $2132
00:A4E9  bd 40 06     mx LDA  $0640,X
00:A4EC  c9 10        mx CMP  #$10
00:A4EE  f0 03        mx BEQ  $A4F3
00:A4F0  fe 40 06     mx INC  $0640,X

L_00A4F3:   ; xref 00A4EE
00:A4F3  e2 30        mx SEP  #$30
00:A4F5  bd 10 06     mx LDA  $0610,X
00:A4F8  89 01        mx BIT  #$01
00:A4FA  f0 04        mx BEQ  $A500
00:A4FC  c2 20        mx REP  #$20
00:A4FE  e6 23        Mx INC  $23

L_00A500:   ; xref 00A4FA
00:A500  e2 30        Mx SEP  #$30
00:A502  bd 00 01     mx LDA  $0100,X
00:A505  49 02        mx EOR  #$02
00:A507  9d 00 01     mx STA  $0100,X
00:A50A  de 10 06     mx DEC  $0610,X
00:A50D  f0 01        mx BEQ  $A510
00:A50F  60           mx RTS  

L_00A510:   ; xref 00A50D
00:A510  20 a1 9c     mx JSR  $9CA1
00:A513  60           mx RTS  

L_00A514:   ; xref 00A3BE
00:A514  e2 30        Mx SEP  #$30
00:A516  bd a0 06     mx LDA  $06A0,X
00:A519  d0 12        mx BNE  $A52D
00:A51B  c2 30        mx REP  #$30
00:A51D  c6 21        MX DEC  $21
00:A51F  a5 21        MX LDA  $21
00:A521  c9 30 00     MX CMP  #$0030
00:A524  f0 01        MX BEQ  $A527
00:A526  60           MX RTS  

L_00A527:   ; xref 00A524
00:A527  e2 30        MX SEP  #$30
00:A529  fe a0 06     mx INC  $06A0,X
00:A52C  60           mx RTS  

L_00A52D:   ; xref 00A519
00:A52D  c2 30        mx REP  #$30
00:A52F  e6 21        MX INC  $21
00:A531  a5 21        MX LDA  $21
00:A533  c9 d0 00     MX CMP  #$00D0
00:A536  f0 01        MX BEQ  $A539
00:A538  60           MX RTS  

L_00A539:   ; xref 00A536
00:A539  e2 30        MX SEP  #$30
00:A53B  9e a0 06     mx STZ  $06A0,X
00:A53E  60           mx RTS  

L_00A53F:   ; xref 00A3BB
00:A53F  e2 30        Mx SEP  #$30
00:A541  de 70 06     mx DEC  $0670,X
00:A544  f0 01        mx BEQ  $A547
00:A546  60           mx RTS  

L_00A547:   ; xref 00A544
00:A547  a9 3c        mx LDA  #$3C
00:A549  9d 70 06     mx STA  $0670,X
00:A54C  de 40 06     mx DEC  $0640,X
00:A54F  f0 01        mx BEQ  $A552
00:A551  60           mx RTS  

L_00A552:   ; xref 00A54F
00:A552  c2 30        mx REP  #$30
00:A554  9c cc 0e     MX STZ  $0ECC
00:A557  60           MX RTS  

L_00A558:   ; xref 00A3B8 00A400
00:A558  e2 30        MX SEP  #$30
00:A55A  bd 10 06     mx LDA  $0610,X
00:A55D  fe 10 06     mx INC  $0610,X
00:A560  c2 30        mx REP  #$30
00:A562  29 ff 00     MX AND  #$00FF
00:A565  0a           MX ASL  
00:A566  da           MX PHX  
00:A567  aa           MX TAX  
00:A568  bd 2d a7     MX LDA  $A72D,X
00:A56B  fa           MX PLX  
00:A56C  c9 00 00     MX CMP  #$0000
00:A56F  d0 0a        MX BNE  $A57B
00:A571  e2 30        MX SEP  #$30
00:A573  9e 10 06     mx STZ  $0610,X
00:A576  c2 30        mx REP  #$30
00:A578  a9 00 00     MX LDA  #$0000

L_00A57B:   ; xref 00A56F
00:A57B  18           MX CLC  
00:A57C  65 23        MX ADC  $23
00:A57E  85 23        MX STA  $23
00:A580  60           MX RTS  

L_00A581:   ; xref 00A599
00:A581  08           mx PHP  
00:A582  e2 30        mx SEP  #$30
00:A584  a9 03        mx LDA  #$03
00:A586  9d 60 01     mx STA  $0160,X
00:A589  22 54 85 80  mx JSL  $808554
00:A58D  e2 30        mx SEP  #$30
00:A58F  bd 00 01     mx LDA  $0100,X
00:A592  09 10        mx ORA  #$10
00:A594  9d 00 01     mx STA  $0100,X
00:A597  28           mx PLP  
00:A598  6b           mx RTL  
00:A599  4c 81 a5     mx JMP  $A581
00:A59C  08           mx PHP  
00:A59D  c2 30        mx REP  #$30
00:A59F  a5 23        MX LDA  $23
00:A5A1  1a           MX INC  
00:A5A2  85 23        MX STA  $23
00:A5A4  c9 00 01     MX CMP  #$0100
00:A5A7  d0 03        MX BNE  $A5AC
00:A5A9  20 a1 9c     MX JSR  $9CA1

L_00A5AC:   ; xref 00A5A7
00:A5AC  28           MX PLP  
00:A5AD  6b           MX RTL  

L_00A5AE:   ; xref 00A5D1
00:A5AE  08           mx PHP  
00:A5AF  e2 30        mx SEP  #$30
00:A5B1  9e e0 05     mx STZ  $05E0,X
00:A5B4  9e 10 06     mx STZ  $0610,X
00:A5B7  9e 40 06     mx STZ  $0640,X
00:A5BA  e2 30        mx SEP  #$30
00:A5BC  a9 04        mx LDA  #$04
00:A5BE  9d 60 01     mx STA  $0160,X
00:A5C1  22 54 85 80  mx JSL  $808554
00:A5C5  e2 30        mx SEP  #$30
00:A5C7  bd 00 01     mx LDA  $0100,X
00:A5CA  09 10        mx ORA  #$10
00:A5CC  9d 00 01     mx STA  $0100,X
00:A5CF  28           mx PLP  
00:A5D0  6b           mx RTL  
00:A5D1  4c ae a5     mx JMP  $A5AE
00:A5D4  08           mx PHP  
00:A5D5  20 f7 a5     mx JSR  $A5F7
00:A5D8  20 40 a6     mx JSR  $A640
00:A5DB  20 82 a6     mx JSR  $A682
00:A5DE  c2 30        mx REP  #$30
00:A5E0  18           MX CLC  
00:A5E1  65 21        MX ADC  $21
00:A5E3  85 21        MX STA  $21
00:A5E5  c2 30        MX REP  #$30
00:A5E7  a5 23        MX LDA  $23
00:A5E9  1a           MX INC  
00:A5EA  1a           MX INC  
00:A5EB  85 23        MX STA  $23
00:A5ED  c9 00 01     MX CMP  #$0100
00:A5F0  d0 03        MX BNE  $A5F5
00:A5F2  20 a1 9c     MX JSR  $9CA1

L_00A5F5:   ; xref 00A5F0
00:A5F5  28           MX PLP  
00:A5F6  6b           MX RTL  

L_00A5F7:   ; xref 00A5D5
00:A5F7  e2 30        mx SEP  #$30
00:A5F9  bd 10 06     mx LDA  $0610,X
00:A5FC  c9 04        mx CMP  #$04
00:A5FE  d0 01        mx BNE  $A601
00:A600  60           mx RTS  

L_00A601:   ; xref 00A5FE
00:A601  c9 00        mx CMP  #$00
00:A603  d0 1d        mx BNE  $A622
00:A605  e2 30        mx SEP  #$30
00:A607  ad 90 07     mx LDA  $0790
00:A60A  eb           mx XBA  
00:A60B  ad f0 01     mx LDA  $01F0
00:A60E  c2 30        mx REP  #$30
00:A610  38           MX SEC  
00:A611  e5 21        MX SBC  $21
00:A613  89 00 80     MX BIT  #$8000
00:A616  f0 04        MX BEQ  $A61C
00:A618  49 ff ff     MX EOR  #$FFFF
00:A61B  1a           MX INC  

L_00A61C:   ; xref 00A616
00:A61C  c9 08 00     MX CMP  #$0008
00:A61F  90 01        MX BCC  $A622
00:A621  60           MX RTS  

L_00A622:   ; xref 00A603 00A61F
00:A622  e2 30        MX SEP  #$30
00:A624  bd 40 06     mx LDA  $0640,X
00:A627  f0 04        mx BEQ  $A62D
00:A629  de 40 06     mx DEC  $0640,X
00:A62C  60           mx RTS  

L_00A62D:   ; xref 00A627
00:A62D  e2 30        mx SEP  #$30
00:A62F  a9 18        mx LDA  #$18
00:A631  9d 40 06     mx STA  $0640,X
00:A634  fe 10 06     mx INC  $0610,X
00:A637  c2 30        mx REP  #$30
00:A639  a9 0a 00     MX LDA  #$000A
00:A63C  20 f3 9b     MX JSR  $9BF3
00:A63F  60           MX RTS  

L_00A640:   ; xref 00A5D8
00:A640  e2 30        mx SEP  #$30
00:A642  ad 90 07     mx LDA  $0790
00:A645  eb           mx XBA  
00:A646  ad f0 01     mx LDA  $01F0
00:A649  c2 30        mx REP  #$30
00:A64B  c5 21        MX CMP  $21
00:A64D  90 18        MX BCC  $A667
00:A64F  e2 30        MX SEP  #$30
00:A651  fe e0 05     mx INC  $05E0,X
00:A654  bd e0 05     mx LDA  $05E0,X
00:A657  89 80        mx BIT  #$80
00:A659  f0 01        mx BEQ  $A65C
00:A65B  60           mx RTS  

L_00A65C:   ; xref 00A659
00:A65C  c9 1c        mx CMP  #$1C
00:A65E  f0 01        mx BEQ  $A661
00:A660  60           mx RTS  

L_00A661:   ; xref 00A65E
00:A661  a9 1b        mx LDA  #$1B
00:A663  9d e0 05     mx STA  $05E0,X
00:A666  60           mx RTS  

L_00A667:   ; xref 00A64D
00:A667  e2 30        MX SEP  #$30
00:A669  de e0 05     mx DEC  $05E0,X
00:A66C  bd e0 05     mx LDA  $05E0,X
00:A66F  89 80        mx BIT  #$80
00:A671  d0 01        mx BNE  $A674
00:A673  60           mx RTS  

L_00A674:   ; xref 00A671
00:A674  49 ff        mx EOR  #$FF
00:A676  1a           mx INC  
00:A677  c9 1c        mx CMP  #$1C
00:A679  f0 01        mx BEQ  $A67C
00:A67B  60           mx RTS  

L_00A67C:   ; xref 00A679
00:A67C  a9 e5        mx LDA  #$E5
00:A67E  9d e0 05     mx STA  $05E0,X
00:A681  60           mx RTS  

L_00A682:   ; xref 00A5DB
00:A682  e2 30        mx SEP  #$30
00:A684  bd e0 05     mx LDA  $05E0,X
00:A687  89 80        mx BIT  #$80
00:A689  f0 0e        mx BEQ  $A699
00:A68B  49 ff        mx EOR  #$FF
00:A68D  1a           mx INC  
00:A68E  da           mx PHX  
00:A68F  aa           mx TAX  
00:A690  bd b2 a6     mx LDA  $A6B2,X
00:A693  49 ff        mx EOR  #$FF
00:A695  1a           mx INC  
00:A696  fa           mx PLX  
00:A697  80 0a        mx BRA  $A6A3

L_00A699:   ; xref 00A689
00:A699  e2 30        mx SEP  #$30
00:A69B  da           mx PHX  
00:A69C  aa           mx TAX  
00:A69D  bd b2 a6     mx LDA  $A6B2,X
00:A6A0  fa           mx PLX  
00:A6A1  80 00        mx BRA  $A6A3

L_00A6A3:   ; xref 00A697 00A6A1
00:A6A3  c2 30        mx REP  #$30
00:A6A5  29 ff 00     MX AND  #$00FF
00:A6A8  89 80 00     MX BIT  #$0080
00:A6AB  d0 01        MX BNE  $A6AE
00:A6AD  60           MX RTS  

L_00A6AE:   ; xref 00A6AB
00:A6AE  09 00 ff     MX ORA  #$FF00
00:A6B1  60           MX RTS  

L_00A6CE:   ; xref 00A6EB
00:A6CE  08           mx PHP  
00:A6CF  e2 30        mx SEP  #$30
00:A6D1  9e e0 05     mx STZ  $05E0,X
00:A6D4  e2 30        mx SEP  #$30
00:A6D6  a9 05        mx LDA  #$05
00:A6D8  9d 60 01     mx STA  $0160,X
00:A6DB  22 54 85 80  mx JSL  $808554
00:A6DF  e2 30        mx SEP  #$30
00:A6E1  bd 00 01     mx LDA  $0100,X
00:A6E4  09 10        mx ORA  #$10
00:A6E6  9d 00 01     mx STA  $0100,X
00:A6E9  28           mx PLP  
00:A6EA  6b           mx RTL  
00:A6EB  4c ce a6     mx JMP  $A6CE
00:A6EE  08           mx PHP  
00:A6EF  e2 30        mx SEP  #$30
00:A6F1  bd e0 05     mx LDA  $05E0,X
00:A6F4  fe e0 05     mx INC  $05E0,X
00:A6F7  c2 30        mx REP  #$30
00:A6F9  da           MX PHX  
00:A6FA  29 ff 00     MX AND  #$00FF
00:A6FD  0a           MX ASL  
00:A6FE  aa           MX TAX  
00:A6FF  bd 2d a7     MX LDA  $A72D,X
00:A702  c2 30        MX REP  #$30
00:A704  fa           MX PLX  
00:A705  c9 00 00     MX CMP  #$0000
00:A708  d0 0a        MX BNE  $A714
00:A70A  e2 30        MX SEP  #$30
00:A70C  9e e0 05     mx STZ  $05E0,X
00:A70F  c2 30        mx REP  #$30
00:A711  a9 00 00     MX LDA  #$0000

L_00A714:   ; xref 00A708
00:A714  c2 30        MX REP  #$30
00:A716  18           MX CLC  
00:A717  65 21        MX ADC  $21
00:A719  85 21        MX STA  $21
00:A71B  c2 30        MX REP  #$30
00:A71D  a5 23        MX LDA  $23
00:A71F  1a           MX INC  
00:A720  1a           MX INC  
00:A721  85 23        MX STA  $23
00:A723  c9 00 01     MX CMP  #$0100
00:A726  d0 03        MX BNE  $A72B
00:A728  20 a1 9c     MX JSR  $9CA1

L_00A72B:   ; xref 00A726
00:A72B  28           MX PLP  
00:A72C  6b           MX RTL  

L_00A77F:   ; xref 00A797
00:A77F  08           mx PHP  
00:A780  e2 30        mx SEP  #$30
00:A782  a9 09        mx LDA  #$09
00:A784  9d 60 01     mx STA  $0160,X
00:A787  22 54 85 80  mx JSL  $808554
00:A78B  e2 30        mx SEP  #$30
00:A78D  bd 00 01     mx LDA  $0100,X
00:A790  09 10        mx ORA  #$10
00:A792  9d 00 01     mx STA  $0100,X
00:A795  28           mx PLP  
00:A796  6b           mx RTL  
00:A797  4c 7f a7     mx JMP  $A77F
00:A79A  08           mx PHP  
00:A79B  c2 30        mx REP  #$30
00:A79D  a5 23        MX LDA  $23
00:A79F  38           MX SEC  
00:A7A0  e9 04 00     MX SBC  #$0004
00:A7A3  85 23        MX STA  $23
00:A7A5  89 00 80     MX BIT  #$8000
00:A7A8  f0 08        MX BEQ  $A7B2
00:A7AA  20 a1 9c     MX JSR  $9CA1
00:A7AD  e2 30        MX SEP  #$30
00:A7AF  ce c5 0e     mx DEC  $0EC5

L_00A7B2:   ; xref 00A7A8
00:A7B2  28           mx PLP  
00:A7B3  6b           mx RTL  

L_00A7B4:   ; xref 00A7EB
00:A7B4  08           mx PHP  
00:A7B5  e2 30        mx SEP  #$30
00:A7B7  9c c5 0e     mx STZ  $0EC5
00:A7BA  9c c6 0e     mx STZ  $0EC6
00:A7BD  9c c7 0e     mx STZ  $0EC7
00:A7C0  c2 30        mx REP  #$30
00:A7C2  9c c8 0e     MX STZ  $0EC8
00:A7C5  9c d4 0e     MX STZ  $0ED4
00:A7C8  9c ca 0e     MX STZ  $0ECA
00:A7CB  9c cc 0e     MX STZ  $0ECC
00:A7CE  9c ce 0e     MX STZ  $0ECE
00:A7D1  9c d0 0e     MX STZ  $0ED0
00:A7D4  e2 30        MX SEP  #$30
00:A7D6  a9 0a        mx LDA  #$0A
00:A7D8  9d 60 01     mx STA  $0160,X
00:A7DB  22 54 85 80  mx JSL  $808554
00:A7DF  e2 30        mx SEP  #$30
00:A7E1  bd 00 01     mx LDA  $0100,X
00:A7E4  09 10        mx ORA  #$10
00:A7E6  9d 00 01     mx STA  $0100,X
00:A7E9  28           mx PLP  
00:A7EA  6b           mx RTL  
00:A7EB  4c b4 a7     mx JMP  $A7B4
00:A7EE  08           mx PHP  
00:A7EF  20 f4 a7     mx JSR  $A7F4
00:A7F2  28           mx PLP  
00:A7F3  6b           mx RTL  

L_00A7F4:   ; xref 00A7EF
00:A7F4  e2 30        mx SEP  #$30
00:A7F6  da           mx PHX  
00:A7F7  ad d6 0e     mx LDA  $0ED6
00:A7FA  0a           mx ASL  
00:A7FB  aa           mx TAX  
00:A7FC  7c ff a7     mx JMP  ($A7FF,X)

L_00A807:   ; xref 00A7FC
00:A807  c2 20        mx REP  #$20
00:A809  a9 2c 01     Mx LDA  #$012C
00:A80C  85 23        Mx STA  $23

L_00A80E:   ; xref 00A7FC
00:A80E  e2 30        Mx SEP  #$30
00:A810  fa           mx PLX  
00:A811  60           mx RTS  

L_00A812:   ; xref 00A7FC
00:A812  e2 30        mx SEP  #$30
00:A814  fa           mx PLX  
00:A815  c2 20        mx REP  #$20
00:A817  ad dc 0e     Mx LDA  $0EDC
00:A81A  f0 23        Mx BEQ  $A83F
00:A81C  c2 20        Mx REP  #$20
00:A81E  ce dc 0e     Mx DEC  $0EDC
00:A821  ad dc 0e     Mx LDA  $0EDC
00:A824  c9 3c 00     Mx CMP  #$003C
00:A827  90 05        Mx BCC  $A82E
00:A829  20 4a a8     Mx JSR  $A84A
00:A82C  80 16        Mx BRA  $A844

L_00A82E:   ; xref 00A827
00:A82E  c2 20        Mx REP  #$20
00:A830  ad dc 0e     Mx LDA  $0EDC
00:A833  29 0b 00     Mx AND  #$000B
00:A836  d0 05        Mx BNE  $A83D
00:A838  20 4a a8     Mx JSR  $A84A
00:A83B  80 07        Mx BRA  $A844

L_00A83D:   ; xref 00A836
00:A83D  80 05        Mx BRA  $A844

L_00A83F:   ; xref 00A81A
00:A83F  e2 30        Mx SEP  #$30
00:A841  9c d6 0e     mx STZ  $0ED6

L_00A844:   ; xref 00A82C 00A83B 00A83D
00:A844  e2 30        Mx SEP  #$30
00:A846  da           mx PHX  
00:A847  4c 55 a8     mx JMP  $A855

L_00A84A:   ; xref 00A829 00A838
00:A84A  e2 30        Mx SEP  #$30
00:A84C  ad 00 01     mx LDA  $0100
00:A84F  49 02        mx EOR  #$02
00:A851  8d 00 01     mx STA  $0100
00:A854  60           mx RTS  

L_00A855:   ; xref 00A7FC 00A847
00:A855  e2 30        mx SEP  #$30
00:A857  fa           mx PLX  
00:A858  20 6a a9     mx JSR  $A96A
00:A85B  20 73 a8     mx JSR  $A873
00:A85E  e2 30        mx SEP  #$30
00:A860  c9 00        mx CMP  #$00
00:A862  d0 02        mx BNE  $A866
00:A864  a9 0a        mx LDA  #$0A

L_00A866:   ; xref 00A862
00:A866  dd 60 01     mx CMP  $0160,X
00:A869  f0 07        mx BEQ  $A872
00:A86B  9d 60 01     mx STA  $0160,X
00:A86E  22 54 85 80  mx JSL  $808554

L_00A872:   ; xref 00A869
00:A872  60           mx RTS  

L_00A873:   ; xref 00A85B
00:A873  e2 30        mx SEP  #$30
00:A875  a5 ae        mx LDA  $AE
00:A877  05 af        mx ORA  $AF
00:A879  d0 01        mx BNE  $A87C
00:A87B  60           mx RTS  

L_00A87C:   ; xref 00A879
00:A87C  20 bc a8     mx JSR  $A8BC
00:A87F  20 83 a8     mx JSR  $A883
00:A882  60           mx RTS  

L_00A883:   ; xref 00A87F
00:A883  e2 30        mx SEP  #$30
00:A885  a5 af        mx LDA  $AF
00:A887  89 02        mx BIT  #$02
00:A889  f0 05        mx BEQ  $A890
00:A88B  e2 30        mx SEP  #$30
00:A88D  a9 02        mx LDA  #$02
00:A88F  60           mx RTS  

L_00A890:   ; xref 00A889
00:A890  e2 30        mx SEP  #$30
00:A892  a5 af        mx LDA  $AF
00:A894  89 01        mx BIT  #$01
00:A896  f0 05        mx BEQ  $A89D
00:A898  e2 30        mx SEP  #$30
00:A89A  a9 0c        mx LDA  #$0C
00:A89C  60           mx RTS  

L_00A89D:   ; xref 00A896
00:A89D  e2 30        mx SEP  #$30
00:A89F  a5 af        mx LDA  $AF
00:A8A1  89 08        mx BIT  #$08
00:A8A3  f0 05        mx BEQ  $A8AA
00:A8A5  e2 30        mx SEP  #$30
00:A8A7  a9 10        mx LDA  #$10
00:A8A9  60           mx RTS  

L_00A8AA:   ; xref 00A8A3
00:A8AA  e2 30        mx SEP  #$30
00:A8AC  a5 af        mx LDA  $AF
00:A8AE  89 04        mx BIT  #$04
00:A8B0  f0 05        mx BEQ  $A8B7
00:A8B2  e2 30        mx SEP  #$30
00:A8B4  a9 0f        mx LDA  #$0F
00:A8B6  60           mx RTS  

L_00A8B7:   ; xref 00A8B0
00:A8B7  e2 30        mx SEP  #$30
00:A8B9  a9 0a        mx LDA  #$0A
00:A8BB  60           mx RTS  

L_00A8BC:   ; xref 00A87C
00:A8BC  e2 30        mx SEP  #$30
00:A8BE  a5 b1        mx LDA  $B1
00:A8C0  89 40        mx BIT  #$40
00:A8C2  f0 03        mx BEQ  $A8C7
00:A8C4  20 4c a9     mx JSR  $A94C

L_00A8C7:   ; xref 00A8C2
00:A8C7  e2 30        mx SEP  #$30
00:A8C9  a5 af        mx LDA  $AF
00:A8CB  89 02        mx BIT  #$02
00:A8CD  f0 03        mx BEQ  $A8D2
00:A8CF  20 20 a9     mx JSR  $A920

L_00A8D2:   ; xref 00A8CD
00:A8D2  e2 30        mx SEP  #$30
00:A8D4  a5 af        mx LDA  $AF
00:A8D6  89 01        mx BIT  #$01
00:A8D8  f0 03        mx BEQ  $A8DD
00:A8DA  20 36 a9     mx JSR  $A936

L_00A8DD:   ; xref 00A8D8
00:A8DD  e2 30        mx SEP  #$30
00:A8DF  a5 af        mx LDA  $AF
00:A8E1  89 08        mx BIT  #$08
00:A8E3  f0 03        mx BEQ  $A8E8
00:A8E5  20 f4 a8     mx JSR  $A8F4

L_00A8E8:   ; xref 00A8E3
00:A8E8  e2 30        mx SEP  #$30
00:A8EA  a5 af        mx LDA  $AF
00:A8EC  89 04        mx BIT  #$04
00:A8EE  f0 03        mx BEQ  $A8F3
00:A8F0  20 0a a9     mx JSR  $A90A

L_00A8F3:   ; xref 00A8EE
00:A8F3  60           mx RTS  

L_00A8F4:   ; xref 00A8E5
00:A8F4  c2 30        mx REP  #$30
00:A8F6  a5 23        MX LDA  $23
00:A8F8  c9 28 00     MX CMP  #$0028
00:A8FB  d0 04        MX BNE  $A901
00:A8FD  a9 00 00     MX LDA  #$0000
00:A900  60           MX RTS  

L_00A901:   ; xref 00A8FB
00:A901  a5 23        MX LDA  $23
00:A903  38           MX SEC  
00:A904  e9 02 00     MX SBC  #$0002
00:A907  85 23        MX STA  $23
00:A909  60           MX RTS  

L_00A90A:   ; xref 00A8F0
00:A90A  c2 30        mx REP  #$30
00:A90C  a5 23        MX LDA  $23
00:A90E  c9 e0 00     MX CMP  #$00E0
00:A911  d0 04        MX BNE  $A917
00:A913  a9 00 00     MX LDA  #$0000
00:A916  60           MX RTS  

L_00A917:   ; xref 00A911
00:A917  a5 23        MX LDA  $23
00:A919  18           MX CLC  
00:A91A  69 02 00     MX ADC  #$0002
00:A91D  85 23        MX STA  $23
00:A91F  60           MX RTS  

L_00A920:   ; xref 00A8CF
00:A920  c2 30        mx REP  #$30
00:A922  a5 21        MX LDA  $21
00:A924  c9 10 00     MX CMP  #$0010
00:A927  d0 04        MX BNE  $A92D
00:A929  a9 00 00     MX LDA  #$0000
00:A92C  60           MX RTS  

L_00A92D:   ; xref 00A927
00:A92D  a5 21        MX LDA  $21
00:A92F  38           MX SEC  
00:A930  e9 02 00     MX SBC  #$0002
00:A933  85 21        MX STA  $21
00:A935  60           MX RTS  

L_00A936:   ; xref 00A8DA
00:A936  c2 30        mx REP  #$30
00:A938  a5 21        MX LDA  $21
00:A93A  c9 f0 00     MX CMP  #$00F0
00:A93D  d0 04        MX BNE  $A943
00:A93F  a9 00 00     MX LDA  #$0000
00:A942  60           MX RTS  

L_00A943:   ; xref 00A93D
00:A943  a5 21        MX LDA  $21
00:A945  18           MX CLC  
00:A946  69 02 00     MX ADC  #$0002
00:A949  85 21        MX STA  $21
00:A94B  60           MX RTS  

L_00A94C:   ; xref 00A8C4
00:A94C  e2 30        mx SEP  #$30
00:A94E  ad c5 0e     mx LDA  $0EC5
00:A951  c9 04        mx CMP  #$04
00:A953  d0 01        mx BNE  $A956
00:A955  60           mx RTS  

L_00A956:   ; xref 00A953
00:A956  ee c5 0e     mx INC  $0EC5
00:A959  c2 30        mx REP  #$30
00:A95B  a5 21        MX LDA  $21
00:A95D  85 00        MX STA  $00
00:A95F  a5 23        MX LDA  $23
00:A961  85 03        MX STA  $03
00:A963  a9 01 00     MX LDA  #$0001
00:A966  20 1c 9c     MX JSR  $9C1C
00:A969  60           MX RTS  

L_00A96A:   ; xref 00A858
00:A96A  c2 30        mx REP  #$30
00:A96C  ad cc 0e     MX LDA  $0ECC
00:A96F  f0 01        MX BEQ  $A972
00:A971  60           MX RTS  

L_00A972:   ; xref 00A96F
00:A972  c2 30        MX REP  #$30
00:A974  ad c8 0e     MX LDA  $0EC8
00:A977  f0 04        MX BEQ  $A97D
00:A979  ce c8 0e     MX DEC  $0EC8
00:A97C  60           MX RTS  

L_00A97D:   ; xref 00A977
00:A97D  c2 30        MX REP  #$30
00:A97F  ad d4 0e     MX LDA  $0ED4
00:A982  c9 1e 00     MX CMP  #$001E
00:A985  90 16        MX BCC  $A99D
00:A987  c2 30        MX REP  #$30
00:A989  9c d4 0e     MX STZ  $0ED4
00:A98C  9c ca 0e     MX STZ  $0ECA
00:A98F  a9 05 00     MX LDA  #$0005
00:A992  20 0a 9c     MX JSR  $9C0A
00:A995  c2 30        MX REP  #$30
00:A997  a9 01 00     MX LDA  #$0001
00:A99A  8d cc 0e     MX STA  $0ECC

L_00A99D:   ; xref 00A985
00:A99D  c2 30        MX REP  #$30
00:A99F  ee ca 0e     MX INC  $0ECA
00:A9A2  c2 30        MX REP  #$30
00:A9A4  da           MX PHX  
00:A9A5  e2 30        MX SEP  #$30

L_00A9A7:   ; xref 00A9B4
00:A9A7  ae c7 0e     mx LDX  $0EC7
00:A9AA  bd 42 aa     mx LDA  $AA42,X
00:A9AD  c9 ff        mx CMP  #$FF
00:A9AF  d0 06        mx BNE  $A9B7
00:A9B1  9c c7 0e     mx STZ  $0EC7
00:A9B4  4c a7 a9     mx JMP  $A9A7

L_00A9B7:   ; xref 00A9AF
00:A9B7  c2 30        mx REP  #$30
00:A9B9  29 ff 00     MX AND  #$00FF
00:A9BC  85 00        MX STA  $00
00:A9BE  64 03        MX STZ  $03
00:A9C0  e2 30        MX SEP  #$30

L_00A9C2:   ; xref 00A9D1
00:A9C2  ad c6 0e     mx LDA  $0EC6
00:A9C5  0a           mx ASL  
00:A9C6  aa           mx TAX  
00:A9C7  bd 55 aa     mx LDA  $AA55,X
00:A9CA  c9 ff        mx CMP  #$FF
00:A9CC  d0 06        mx BNE  $A9D4
00:A9CE  9c c6 0e     mx STZ  $0EC6
00:A9D1  4c c2 a9     mx JMP  $A9C2

L_00A9D4:   ; xref 00A9CC
00:A9D4  c2 30        mx REP  #$30
00:A9D6  29 ff 00     MX AND  #$00FF
00:A9D9  8d c8 0e     MX STA  $0EC8
00:A9DC  e2 30        MX SEP  #$30
00:A9DE  bd 56 aa     mx LDA  $AA56,X
00:A9E1  c2 30        mx REP  #$30
00:A9E3  29 ff 00     MX AND  #$00FF
00:A9E6  20 f5 a9     MX JSR  $A9F5
00:A9E9  e2 30        MX SEP  #$30
00:A9EB  ee c7 0e     mx INC  $0EC7
00:A9EE  ee c6 0e     mx INC  $0EC6
00:A9F1  c2 30        mx REP  #$30
00:A9F3  fa           MX PLX  
00:A9F4  60           MX RTS  

L_00A9F5:   ; xref 00A9E6
00:A9F5  c2 30        MX REP  #$30
00:A9F7  c9 09 00     MX CMP  #$0009
00:A9FA  f0 08        MX BEQ  $AA04
00:A9FC  18           MX CLC  
00:A9FD  69 02 00     MX ADC  #$0002
00:AA00  20 1c 9c     MX JSR  $9C1C
00:AA03  60           MX RTS  

L_00AA04:   ; xref 00A9FA
00:AA04  c2 30        MX REP  #$30
00:AA06  48           MX PHA  
00:AA07  a9 00 01     MX LDA  #$0100
00:AA0A  85 00        MX STA  $00
00:AA0C  da           MX PHX  
00:AA0D  ad d0 0e     MX LDA  $0ED0
00:AA10  0a           MX ASL  
00:AA11  aa           MX TAX  
00:AA12  bd 2e aa     MX LDA  $AA2E,X
00:AA15  c9 ff ff     MX CMP  #$FFFF
00:AA18  d0 09        MX BNE  $AA23
00:AA1A  9c d0 0e     MX STZ  $0ED0
00:AA1D  a2 00 00     MX LDX  #$0000
00:AA20  bd 2e aa     MX LDA  $AA2E,X

L_00AA23:   ; xref 00AA18
00:AA23  fa           MX PLX  
00:AA24  ee d0 0e     MX INC  $0ED0
00:AA27  85 03        MX STA  $03
00:AA29  68           MX PLA  
00:AA2A  20 1c 9c     MX JSR  $9C1C
00:AA2D  60           MX RTS  

L_00AA92:   ; xref 00AAB1
00:AA92  08           mx PHP  
00:AA93  e2 30        mx SEP  #$30
00:AA95  a9 ff        mx LDA  #$FF
00:AA97  9d 70 06     mx STA  $0670,X
00:AA9A  e2 30        mx SEP  #$30
00:AA9C  a9 0d        mx LDA  #$0D
00:AA9E  9d 60 01     mx STA  $0160,X
00:AAA1  22 54 85 80  mx JSL  $808554
00:AAA5  e2 30        mx SEP  #$30
00:AAA7  bd 00 01     mx LDA  $0100,X
00:AAAA  09 10        mx ORA  #$10
00:AAAC  9d 00 01     mx STA  $0100,X
00:AAAF  28           mx PLP  
00:AAB0  6b           mx RTL  
00:AAB1  4c 92 aa     mx JMP  $AA92
00:AAB4  08           mx PHP  
00:AAB5  e2 30        mx SEP  #$30
00:AAB7  bd 70 06     mx LDA  $0670,X
00:AABA  c9 ff        mx CMP  #$FF
00:AABC  d0 03        mx BNE  $AAC1
00:AABE  4c d6 aa     mx JMP  $AAD6

L_00AAC1:   ; xref 00AABC
00:AAC1  c9 fe        mx CMP  #$FE
00:AAC3  d0 05        mx BNE  $AACA
00:AAC5  20 d8 aa     mx JSR  $AAD8
00:AAC8  80 0c        mx BRA  $AAD6

L_00AACA:   ; xref 00AAC3
00:AACA  c9 fd        mx CMP  #$FD
00:AACC  d0 05        mx BNE  $AAD3
00:AACE  20 e0 aa     mx JSR  $AAE0
00:AAD1  80 03        mx BRA  $AAD6

L_00AAD3:   ; xref 00AACC
00:AAD3  20 e7 aa     mx JSR  $AAE7

L_00AAD6:   ; xref 00AABE 00AAC8 00AAD1
00:AAD6  28           mx PLP  
00:AAD7  6b           mx RTL  

L_00AAD8:   ; xref 00AAC5
00:AAD8  e2 30        mx SEP  #$30
00:AADA  9e 10 06     mx STZ  $0610,X
00:AADD  9e 40 06     mx STZ  $0640,X

L_00AAE0:   ; xref 00AACE
00:AAE0  e2 30        mx SEP  #$30
00:AAE2  9e 70 06     mx STZ  $0670,X
00:AAE5  80 23        mx BRA  $AB0A

L_00AAE7:   ; xref 00AAD3
00:AAE7  e2 30        mx SEP  #$30
00:AAE9  bd 10 06     mx LDA  $0610,X
00:AAEC  48           mx PHA  
00:AAED  bd 40 06     mx LDA  $0640,X
00:AAF0  48           mx PHA  
00:AAF1  20 69 ab     mx JSR  $AB69
00:AAF4  20 0a ab     mx JSR  $AB0A
00:AAF7  e2 30        mx SEP  #$30
00:AAF9  68           mx PLA  
00:AAFA  dd 40 06     mx CMP  $0640,X
00:AAFD  f0 03        mx BEQ  $AB02
00:AAFF  68           mx PLA  
00:AB00  80 07        mx BRA  $AB09

L_00AB02:   ; xref 00AAFD
00:AB02  68           mx PLA  
00:AB03  dd 10 06     mx CMP  $0610,X
00:AB06  d0 01        mx BNE  $AB09
00:AB08  60           mx RTS  

L_00AB09:   ; xref 00AB00 00AB06
00:AB09  60           mx RTS  

L_00AB0A:   ; xref 00AAE5 00AAF4
00:AB0A  e2 30        mx SEP  #$30
00:AB0C  bd e0 05     mx LDA  $05E0,X
00:AB0F  85 0c        mx STA  $0C
00:AB11  bd 40 09     mx LDA  $0940,X
00:AB14  85 0d        mx STA  $0D
00:AB16  bd a0 06     mx LDA  $06A0,X
00:AB19  85 0e        mx STA  $0E
00:AB1B  a0 00        mx LDY  #$00
00:AB1D  b7 0c        mx LDA  [$0C],Y
00:AB1F  dd 10 06     mx CMP  $0610,X
00:AB22  d0 03        mx BNE  $AB27
00:AB24  de 10 06     mx DEC  $0610,X

L_00AB27:   ; xref 00AB22
00:AB27  c8           mx INY  
00:AB28  b7 0c        mx LDA  [$0C],Y
00:AB2A  dd 40 06     mx CMP  $0640,X
00:AB2D  d0 03        mx BNE  $AB32
00:AB2F  de 40 06     mx DEC  $0640,X

L_00AB32:   ; xref 00AB2D
00:AB32  a0 00        mx LDY  #$00
00:AB34  b7 0c        mx LDA  [$0C],Y
00:AB36  8d 1b 21     mx STA  $211B
00:AB39  9c 1b 21     mx STZ  $211B
00:AB3C  bd 40 06     mx LDA  $0640,X
00:AB3F  8d 1c 21     mx STA  $211C
00:AB42  bd 10 06     mx LDA  $0610,X
00:AB45  c2 20        mx REP  #$20
00:AB47  29 ff 00     Mx AND  #$00FF
00:AB4A  18           Mx CLC  
00:AB4B  6d 34 21     Mx ADC  $2134
00:AB4E  0a           Mx ASL  
00:AB4F  18           Mx CLC  
00:AB50  65 0c        Mx ADC  $0C
00:AB52  18           Mx CLC  
00:AB53  69 02 00     Mx ADC  #$0002
00:AB56  85 0c        Mx STA  $0C
00:AB58  e2 30        Mx SEP  #$30
00:AB5A  a7 0c        mx LDA  [$0C]
00:AB5C  85 21        mx STA  $21
00:AB5E  64 22        mx STZ  $22
00:AB60  a0 01        mx LDY  #$01
00:AB62  b7 0c        mx LDA  [$0C],Y
00:AB64  85 23        mx STA  $23
00:AB66  64 24        mx STZ  $24
00:AB68  60           mx RTS  

L_00AB69:   ; xref 00AAF1
00:AB69  e2 30        mx SEP  #$30
00:AB6B  9e 70 06     mx STZ  $0670,X
00:AB6E  a5 b4        mx LDA  $B4
00:AB70  05 b5        mx ORA  $B5
00:AB72  d0 01        mx BNE  $AB75
00:AB74  60           mx RTS  

L_00AB75:   ; xref 00AB72
00:AB75  fe 70 06     mx INC  $0670,X
00:AB78  a5 b5        mx LDA  $B5
00:AB7A  89 02        mx BIT  #$02
00:AB7C  d0 47        mx BNE  $ABC5
00:AB7E  fe 70 06     mx INC  $0670,X
00:AB81  a5 b5        mx LDA  $B5
00:AB83  89 01        mx BIT  #$01
00:AB85  d0 48        mx BNE  $ABCF
00:AB87  fe 70 06     mx INC  $0670,X
00:AB8A  a5 b5        mx LDA  $B5
00:AB8C  89 08        mx BIT  #$08
00:AB8E  d0 26        mx BNE  $ABB6
00:AB90  fe 70 06     mx INC  $0670,X
00:AB93  a5 b5        mx LDA  $B5
00:AB95  89 04        mx BIT  #$04
00:AB97  d0 27        mx BNE  $ABC0
00:AB99  fe 70 06     mx INC  $0670,X
00:AB9C  a5 b1        mx LDA  $B1
00:AB9E  89 40        mx BIT  #$40
00:ABA0  d0 32        mx BNE  $ABD4
00:ABA2  a5 b0        mx LDA  $B0
00:ABA4  89 c0        mx BIT  #$C0
00:ABA6  d0 2c        mx BNE  $ABD4
00:ABA8  fe 70 06     mx INC  $0670,X
00:ABAB  a5 b1        mx LDA  $B1
00:ABAD  89 80        mx BIT  #$80
00:ABAF  d0 23        mx BNE  $ABD4
00:ABB1  9e 70 06     mx STZ  $0670,X
00:ABB4  80 1e        mx BRA  $ABD4

L_00ABB6:   ; xref 00AB8E
00:ABB6  bd 40 06     mx LDA  $0640,X
00:ABB9  f0 19        mx BEQ  $ABD4
00:ABBB  de 40 06     mx DEC  $0640,X
00:ABBE  80 14        mx BRA  $ABD4

L_00ABC0:   ; xref 00AB97
00:ABC0  fe 40 06     mx INC  $0640,X
00:ABC3  80 0f        mx BRA  $ABD4

L_00ABC5:   ; xref 00AB7C
00:ABC5  bd 10 06     mx LDA  $0610,X
00:ABC8  f0 0a        mx BEQ  $ABD4
00:ABCA  de 10 06     mx DEC  $0610,X
00:ABCD  80 05        mx BRA  $ABD4

L_00ABCF:   ; xref 00AB85
00:ABCF  fe 10 06     mx INC  $0610,X
00:ABD2  80 00        mx BRA  $ABD4

L_00ABD4:   ; xref 00ABA0 00ABA6 00ABAF 00ABB4 00ABC3 00ABB9
00:ABD4  60           mx RTS  

L_00ABD5:   ; xref 008271
00:ABD5  20 5f ad     MX JSR  $AD5F
00:ABD8  20 dc ab     MX JSR  $ABDC
00:ABDB  60           MX RTS  

L_00ABDC:   ; xref 00ABD8
00:ABDC  e2 30        MX SEP  #$30
00:ABDE  ad d6 0e     mx LDA  $0ED6
00:ABE1  f0 01        mx BEQ  $ABE4
00:ABE3  60           mx RTS  

L_00ABE4:   ; xref 00ABE1
00:ABE4  e2 30        mx SEP  #$30
00:ABE6  ad 90 04     mx LDA  $0490
00:ABE9  85 c6        mx STA  $C6
00:ABEB  ad e0 08     mx LDA  $08E0
00:ABEE  85 c8        mx STA  $C8
00:ABF0  ad c0 04     mx LDA  $04C0
00:ABF3  85 c7        mx STA  $C7
00:ABF5  ad 10 09     mx LDA  $0910
00:ABF8  85 c9        mx STA  $C9
00:ABFA  ad 70 09     mx LDA  $0970
00:ABFD  85 ca        mx STA  $CA
00:ABFF  ad f0 01     mx LDA  $01F0
00:AC02  85 c2        mx STA  $C2
00:AC04  ad 90 07     mx LDA  $0790
00:AC07  85 c3        mx STA  $C3
00:AC09  ad 20 02     mx LDA  $0220
00:AC0C  85 c4        mx STA  $C4
00:AC0E  ad c0 07     mx LDA  $07C0
00:AC11  85 c5        mx STA  $C5
00:AC13  c2 30        mx REP  #$30
00:AC15  ad 80 08     MX LDA  $0880
00:AC18  29 ff 00     MX AND  #$00FF
00:AC1B  89 80 00     MX BIT  #$0080
00:AC1E  f0 03        MX BEQ  $AC23
00:AC20  09 00 ff     MX ORA  #$FF00

L_00AC23:   ; xref 00AC1E
00:AC23  18           MX CLC  
00:AC24  65 c2        MX ADC  $C2
00:AC26  85 cf        MX STA  $CF
00:AC28  ad b0 08     MX LDA  $08B0
00:AC2B  29 ff 00     MX AND  #$00FF
00:AC2E  89 80 00     MX BIT  #$0080
00:AC31  f0 03        MX BEQ  $AC36
00:AC33  09 00 ff     MX ORA  #$FF00

L_00AC36:   ; xref 00AC31
00:AC36  18           MX CLC  
00:AC37  65 c4        MX ADC  $C4
00:AC39  85 d1        MX STA  $D1
00:AC3B  ad 30 04     MX LDA  $0430
00:AC3E  29 ff 00     MX AND  #$00FF
00:AC41  89 80 00     MX BIT  #$0080
00:AC44  f0 03        MX BEQ  $AC49
00:AC46  09 00 ff     MX ORA  #$FF00

L_00AC49:   ; xref 00AC44
00:AC49  18           MX CLC  
00:AC4A  65 c2        MX ADC  $C2
00:AC4C  85 cb        MX STA  $CB
00:AC4E  ad 60 04     MX LDA  $0460
00:AC51  29 ff 00     MX AND  #$00FF
00:AC54  89 80 00     MX BIT  #$0080
00:AC57  f0 03        MX BEQ  $AC5C
00:AC59  09 00 ff     MX ORA  #$FF00

L_00AC5C:   ; xref 00AC57
00:AC5C  18           MX CLC  
00:AC5D  65 c4        MX ADC  $C4
00:AC5F  85 cd        MX STA  $CD
00:AC61  c2 30        MX REP  #$30
00:AC63  da           MX PHX  
00:AC64  a2 01 00     MX LDX  #$0001

L_00AC67:   ; xref 00AC83
00:AC67  e2 30        MX SEP  #$30
00:AC69  bd 00 01     mx LDA  $0100,X
00:AC6C  10 12        mx BPL  $AC80
00:AC6E  bd 30 01     mx LDA  $0130,X
00:AC71  da           mx PHX  
00:AC72  aa           mx TAX  
00:AC73  bd 50 ad     mx LDA  $AD50,X
00:AC76  fa           mx PLX  
00:AC77  c9 00        mx CMP  #$00
00:AC79  f0 03        mx BEQ  $AC7E
00:AC7B  20 89 ac     mx JSR  $AC89

L_00AC7E:   ; xref 00AC79
00:AC7E  e2 30        mx SEP  #$30

L_00AC80:   ; xref 00AC6C
00:AC80  e8           mx INX  
00:AC81  e0 30        mx CPX  #$30
00:AC83  d0 e2        mx BNE  $AC67
00:AC85  c2 30        mx REP  #$30
00:AC87  fa           MX PLX  
00:AC88  60           MX RTS  

L_00AC89:   ; xref 00AC7B
00:AC89  e2 30        mx SEP  #$30
00:AC8B  da           mx PHX  
00:AC8C  e2 30        mx SEP  #$30
00:AC8E  3a           mx DEC  
00:AC8F  0a           mx ASL  
00:AC90  aa           mx TAX  
00:AC91  7c 94 ac     mx JMP  ($AC94,X)

L_00AC9C:   ; xref 00AC91
00:AC9C  e2 30        mx SEP  #$30
00:AC9E  fa           mx PLX  
00:AC9F  c2 30        mx REP  #$30
00:ACA1  ad ce 0e     MX LDA  $0ECE
00:ACA4  d0 01        MX BNE  $ACA7
00:ACA6  60           MX RTS  

L_00ACA7:   ; xref 00ACA4
00:ACA7  20 36 ad     MX JSR  $AD36
00:ACAA  e2 30        MX SEP  #$30
00:ACAC  bd 60 07     mx LDA  $0760,X
00:ACAF  89 08        mx BIT  #$08
00:ACB1  f0 0c        mx BEQ  $ACBF
00:ACB3  e2 30        mx SEP  #$30
00:ACB5  a9 01        mx LDA  #$01
00:ACB7  8d d6 0e     mx STA  $0ED6
00:ACBA  c2 20        mx REP  #$20
00:ACBC  9c da 0e     Mx STZ  $0EDA

L_00ACBF:   ; xref 00ACB1
00:ACBF  60           Mx RTS  

L_00ACC0:   ; xref 00AC91
00:ACC0  e2 30        mx SEP  #$30
00:ACC2  fa           mx PLX  
00:ACC3  20 36 ad     mx JSR  $AD36
00:ACC6  e2 30        mx SEP  #$30
00:ACC8  bd 60 07     mx LDA  $0760,X
00:ACCB  89 08        mx BIT  #$08
00:ACCD  f0 28        mx BEQ  $ACF7
00:ACCF  e2 30        mx SEP  #$30
00:ACD1  a9 03        mx LDA  #$03
00:ACD3  8d d6 0e     mx STA  $0ED6
00:ACD6  e2 30        mx SEP  #$30
00:ACD8  ad f0 01     mx LDA  $01F0
00:ACDB  85 00        mx STA  $00
00:ACDD  ad 90 07     mx LDA  $0790
00:ACE0  85 01        mx STA  $01
00:ACE2  ad 20 02     mx LDA  $0220
00:ACE5  85 03        mx STA  $03
00:ACE7  ad c0 07     mx LDA  $07C0
00:ACEA  85 04        mx STA  $04
00:ACEC  c2 20        mx REP  #$20
00:ACEE  a9 0c 00     Mx LDA  #$000C
00:ACF1  20 f3 9b     Mx JSR  $9BF3
00:ACF4  20 a1 9c     Mx JSR  $9CA1

L_00ACF7:   ; xref 00ACCD
00:ACF7  60           Mx RTS  

L_00ACF8:   ; xref 00AC91
00:ACF8  e2 30        mx SEP  #$30
00:ACFA  fa           mx PLX  
00:ACFB  20 36 ad     mx JSR  $AD36
00:ACFE  e2 30        mx SEP  #$30
00:AD00  bd 60 07     mx LDA  $0760,X
00:AD03  89 08        mx BIT  #$08
00:AD05  f0 12        mx BEQ  $AD19
00:AD07  e2 30        mx SEP  #$30
00:AD09  a9 02        mx LDA  #$02
00:AD0B  8d d6 0e     mx STA  $0ED6
00:AD0E  c2 20        mx REP  #$20
00:AD10  a9 e0 01     Mx LDA  #$01E0
00:AD13  8d dc 0e     Mx STA  $0EDC
00:AD16  20 a1 9c     Mx JSR  $9CA1

L_00AD19:   ; xref 00AD05
00:AD19  60           Mx RTS  

L_00AD1A:   ; xref 00AC91
00:AD1A  e2 30        mx SEP  #$30
00:AD1C  fa           mx PLX  
00:AD1D  20 36 ad     mx JSR  $AD36
00:AD20  e2 30        mx SEP  #$30
00:AD22  bd 60 07     mx LDA  $0760,X
00:AD25  89 08        mx BIT  #$08
00:AD27  f0 0c        mx BEQ  $AD35
00:AD29  e2 30        mx SEP  #$30
00:AD2B  a9 01        mx LDA  #$01
00:AD2D  8d d6 0e     mx STA  $0ED6
00:AD30  c2 20        mx REP  #$20
00:AD32  9c da 0e     Mx STZ  $0EDA

L_00AD35:   ; xref 00AD27
00:AD35  60           Mx RTS  

L_00AD36:   ; xref 00ACA7 00ACFB 00ACC3 00AD1D
00:AD36  e2 30        MX SEP  #$30
00:AD38  bd f0 01     mx LDA  $01F0,X
00:AD3B  85 d7        mx STA  $D7
00:AD3D  bd 90 07     mx LDA  $0790,X
00:AD40  85 d8        mx STA  $D8
00:AD42  bd 20 02     mx LDA  $0220,X
00:AD45  85 d9        mx STA  $D9
00:AD47  bd c0 07     mx LDA  $07C0,X
00:AD4A  85 da        mx STA  $DA
00:AD4C  20 67 af     mx JSR  $AF67
00:AD4F  60           mx RTS  

L_00AD5F:   ; xref 00ABD5
00:AD5F  c2 30        MX REP  #$30
00:AD61  a2 01 00     MX LDX  #$0001

L_00AD64:   ; xref 00AD90
00:AD64  e2 30        MX SEP  #$30
00:AD66  bd 00 01     mx LDA  $0100,X
00:AD69  10 22        mx BPL  $AD8D
00:AD6B  bd 30 01     mx LDA  $0130,X
00:AD6E  c9 01        mx CMP  #$01
00:AD70  d0 19        mx BNE  $AD8B
00:AD72  da           mx PHX  
00:AD73  9c d2 0e     mx STZ  $0ED2
00:AD76  20 93 ad     mx JSR  $AD93
00:AD79  e2 30        mx SEP  #$30
00:AD7B  ad d2 0e     mx LDA  $0ED2
00:AD7E  f0 0a        mx BEQ  $AD8A
00:AD80  e2 30        mx SEP  #$30
00:AD82  a9 ff        mx LDA  #$FF
00:AD84  9d 20 02     mx STA  $0220,X
00:AD87  9d c0 07     mx STA  $07C0,X

L_00AD8A:   ; xref 00AD7E
00:AD8A  fa           mx PLX  

L_00AD8B:   ; xref 00AD70
00:AD8B  e2 30        mx SEP  #$30

L_00AD8D:   ; xref 00AD69
00:AD8D  e8           mx INX  
00:AD8E  e0 30        mx CPX  #$30
00:AD90  d0 d2        mx BNE  $AD64
00:AD92  60           mx RTS  

L_00AD93:   ; xref 00AD76
00:AD93  e2 30        mx SEP  #$30
00:AD95  bd 90 04     mx LDA  $0490,X
00:AD98  85 c6        mx STA  $C6
00:AD9A  bd e0 08     mx LDA  $08E0,X
00:AD9D  85 c8        mx STA  $C8
00:AD9F  bd c0 04     mx LDA  $04C0,X
00:ADA2  85 c7        mx STA  $C7
00:ADA4  bd 10 09     mx LDA  $0910,X
00:ADA7  85 c9        mx STA  $C9
00:ADA9  bd 70 09     mx LDA  $0970,X
00:ADAC  85 ca        mx STA  $CA
00:ADAE  bd f0 01     mx LDA  $01F0,X
00:ADB1  85 c2        mx STA  $C2
00:ADB3  bd 90 07     mx LDA  $0790,X
00:ADB6  85 c3        mx STA  $C3
00:ADB8  bd 20 02     mx LDA  $0220,X
00:ADBB  85 c4        mx STA  $C4
00:ADBD  bd c0 07     mx LDA  $07C0,X
00:ADC0  85 c5        mx STA  $C5
00:ADC2  c2 30        mx REP  #$30
00:ADC4  bd 80 08     MX LDA  $0880,X
00:ADC7  29 ff 00     MX AND  #$00FF
00:ADCA  89 80 00     MX BIT  #$0080
00:ADCD  f0 03        MX BEQ  $ADD2
00:ADCF  09 00 ff     MX ORA  #$FF00

L_00ADD2:   ; xref 00ADCD
00:ADD2  18           MX CLC  
00:ADD3  65 c2        MX ADC  $C2
00:ADD5  85 cf        MX STA  $CF
00:ADD7  bd b0 08     MX LDA  $08B0,X
00:ADDA  29 ff 00     MX AND  #$00FF
00:ADDD  89 80 00     MX BIT  #$0080
00:ADE0  f0 03        MX BEQ  $ADE5
00:ADE2  09 00 ff     MX ORA  #$FF00

L_00ADE5:   ; xref 00ADE0
00:ADE5  18           MX CLC  
00:ADE6  65 c4        MX ADC  $C4
00:ADE8  85 d1        MX STA  $D1
00:ADEA  bd 30 04     MX LDA  $0430,X
00:ADED  29 ff 00     MX AND  #$00FF
00:ADF0  89 80 00     MX BIT  #$0080
00:ADF3  f0 03        MX BEQ  $ADF8
00:ADF5  09 00 ff     MX ORA  #$FF00

L_00ADF8:   ; xref 00ADF3
00:ADF8  18           MX CLC  
00:ADF9  65 c2        MX ADC  $C2
00:ADFB  85 cb        MX STA  $CB
00:ADFD  bd 60 04     MX LDA  $0460,X
00:AE00  29 ff 00     MX AND  #$00FF
00:AE03  89 80 00     MX BIT  #$0080
00:AE06  f0 03        MX BEQ  $AE0B
00:AE08  09 00 ff     MX ORA  #$FF00

L_00AE0B:   ; xref 00AE06
00:AE0B  18           MX CLC  
00:AE0C  65 c4        MX ADC  $C4
00:AE0E  85 cd        MX STA  $CD
00:AE10  c2 30        MX REP  #$30
00:AE12  da           MX PHX  
00:AE13  a2 01 00     MX LDX  #$0001

L_00AE16:   ; xref 00AE36
00:AE16  e2 30        MX SEP  #$30
00:AE18  bd 00 01     mx LDA  $0100,X
00:AE1B  10 16        mx BPL  $AE33
00:AE1D  bd 30 01     mx LDA  $0130,X
00:AE20  da           mx PHX  
00:AE21  aa           mx TAX  
00:AE22  bd 58 af     mx LDA  $AF58,X
00:AE25  fa           mx PLX  
00:AE26  c9 00        mx CMP  #$00
00:AE28  f0 07        mx BEQ  $AE31
00:AE2A  da           mx PHX  
00:AE2B  20 3c ae     mx JSR  $AE3C
00:AE2E  e2 30        mx SEP  #$30
00:AE30  fa           mx PLX  

L_00AE31:   ; xref 00AE28
00:AE31  e2 30        mx SEP  #$30

L_00AE33:   ; xref 00AE1B
00:AE33  e8           mx INX  
00:AE34  e0 30        mx CPX  #$30
00:AE36  d0 de        mx BNE  $AE16
00:AE38  c2 30        mx REP  #$30
00:AE3A  fa           MX PLX  
00:AE3B  60           MX RTS  

L_00AE3C:   ; xref 00AE2B
00:AE3C  e2 30        mx SEP  #$30
00:AE3E  48           mx PHA  
00:AE3F  e2 30        mx SEP  #$30
00:AE41  bd f0 01     mx LDA  $01F0,X
00:AE44  85 d7        mx STA  $D7
00:AE46  bd 90 07     mx LDA  $0790,X
00:AE49  85 d8        mx STA  $D8
00:AE4B  bd 20 02     mx LDA  $0220,X
00:AE4E  85 d9        mx STA  $D9
00:AE50  bd c0 07     mx LDA  $07C0,X
00:AE53  85 da        mx STA  $DA
00:AE55  20 67 af     mx JSR  $AF67
00:AE58  e2 30        mx SEP  #$30
00:AE5A  68           mx PLA  
00:AE5B  3a           mx DEC  
00:AE5C  da           mx PHX  
00:AE5D  0a           mx ASL  
00:AE5E  aa           mx TAX  
00:AE5F  7c 62 ae     mx JMP  ($AE62,X)

L_00AE68:   ; xref 00AE5F
00:AE68  e2 30        mx SEP  #$30
00:AE6A  fa           mx PLX  
00:AE6B  bd 60 07     mx LDA  $0760,X
00:AE6E  89 04        mx BIT  #$04
00:AE70  f0 1a        mx BEQ  $AE8C
00:AE72  e2 30        mx SEP  #$30
00:AE74  ee d2 0e     mx INC  $0ED2
00:AE77  de 00 07     mx DEC  $0700,X
00:AE7A  d0 10        mx BNE  $AE8C
00:AE7C  e2 30        mx SEP  #$30
00:AE7E  9c cc 0e     mx STZ  $0ECC
00:AE81  e2 30        mx SEP  #$30
00:AE83  ad 4d 12     mx LDA  $124D
00:AE86  18           mx CLC  
00:AE87  69 64        mx ADC  #$64
00:AE89  8d 4d 12     mx STA  $124D

L_00AE8C:   ; xref 00AE70 00AE7A
00:AE8C  60           mx RTS  

L_00AE8D:   ; xref 00AE5F
00:AE8D  e2 30        mx SEP  #$30
00:AE8F  fa           mx PLX  
00:AE90  bd 60 07     mx LDA  $0760,X
00:AE93  89 04        mx BIT  #$04
00:AE95  f0 30        mx BEQ  $AEC7
00:AE97  e2 30        mx SEP  #$30
00:AE99  ee d2 0e     mx INC  $0ED2
00:AE9C  de 00 07     mx DEC  $0700,X
00:AE9F  d0 26        mx BNE  $AEC7
00:AEA1  e2 30        mx SEP  #$30
00:AEA3  ee d4 0e     mx INC  $0ED4
00:AEA6  c2 30        mx REP  #$30
00:AEA8  a5 d7        MX LDA  $D7
00:AEAA  85 00        MX STA  $00
00:AEAC  a5 d9        MX LDA  $D9
00:AEAE  85 03        MX STA  $03
00:AEB0  a9 0d 00     MX LDA  #$000D
00:AEB3  20 1c 9c     MX JSR  $9C1C
00:AEB6  20 fc ae     MX JSR  $AEFC
00:AEB9  20 a1 9c     MX JSR  $9CA1
00:AEBC  e2 30        MX SEP  #$30
00:AEBE  ad 4d 12     mx LDA  $124D
00:AEC1  18           mx CLC  
00:AEC2  69 32        mx ADC  #$32
00:AEC4  8d 4d 12     mx STA  $124D

L_00AEC7:   ; xref 00AE95 00AE9F
00:AEC7  60           mx RTS  

L_00AEC8:   ; xref 00AE5F
00:AEC8  e2 30        mx SEP  #$30
00:AECA  fa           mx PLX  
00:AECB  bd 60 07     mx LDA  $0760,X
00:AECE  89 04        mx BIT  #$04
00:AED0  f0 29        mx BEQ  $AEFB
00:AED2  e2 30        mx SEP  #$30
00:AED4  ee d2 0e     mx INC  $0ED2
00:AED7  ee d4 0e     mx INC  $0ED4
00:AEDA  c2 30        mx REP  #$30
00:AEDC  a5 d7        MX LDA  $D7
00:AEDE  85 00        MX STA  $00
00:AEE0  a5 d9        MX LDA  $D9
00:AEE2  85 03        MX STA  $03
00:AEE4  a9 0b 00     MX LDA  #$000B
00:AEE7  20 1c 9c     MX JSR  $9C1C
00:AEEA  20 fc ae     MX JSR  $AEFC
00:AEED  20 a1 9c     MX JSR  $9CA1
00:AEF0  e2 30        MX SEP  #$30
00:AEF2  ad 4d 12     mx LDA  $124D
00:AEF5  18           mx CLC  
00:AEF6  69 05        mx ADC  #$05
00:AEF8  8d 4d 12     mx STA  $124D

L_00AEFB:   ; xref 00AED0
00:AEFB  60           mx RTS  

L_00AEFC:   ; xref 00AEB6 00AEEA
00:AEFC  e2 30        MX SEP  #$30
00:AEFE  da           mx PHX  
00:AEFF  ae d8 0e     mx LDX  $0ED8
00:AF02  bd 2f af     mx LDA  $AF2F,X
00:AF05  c9 ff        mx CMP  #$FF
00:AF07  d0 06        mx BNE  $AF0F
00:AF09  9c d8 0e     mx STZ  $0ED8
00:AF0C  ad 2f af     mx LDA  $AF2F

L_00AF0F:   ; xref 00AF07
00:AF0F  fa           mx PLX  
00:AF10  ee d8 0e     mx INC  $0ED8
00:AF13  c9 00        mx CMP  #$00
00:AF15  d0 01        mx BNE  $AF18
00:AF17  60           mx RTS  

L_00AF18:   ; xref 00AF15
00:AF18  c2 30        mx REP  #$30
00:AF1A  48           MX PHA  
00:AF1B  a5 d7        MX LDA  $D7
00:AF1D  85 00        MX STA  $00
00:AF1F  a5 d9        MX LDA  $D9
00:AF21  85 03        MX STA  $03
00:AF23  68           MX PLA  
00:AF24  18           MX CLC  
00:AF25  69 06 00     MX ADC  #$0006
00:AF28  29 ff 00     MX AND  #$00FF
00:AF2B  20 1c 9c     MX JSR  $9C1C
00:AF2E  60           MX RTS  

L_00AF67:   ; xref 00AD4C 00AE55
00:AF67  08           mx PHP  
00:AF68  e2 30        mx SEP  #$30
00:AF6A  9e 30 07     mx STZ  $0730,X
00:AF6D  e2 30        mx SEP  #$30
00:AF6F  bd 70 09     mx LDA  $0970,X
00:AF72  89 40        mx BIT  #$40
00:AF74  d0 46        mx BNE  $AFBC
00:AF76  a5 ca        mx LDA  $CA
00:AF78  89 80        mx BIT  #$80
00:AF7A  d0 40        mx BNE  $AFBC
00:AF7C  c2 20        mx REP  #$20
00:AF7E  bd 30 04     Mx LDA  $0430,X
00:AF81  09 00 ff     Mx ORA  #$FF00
00:AF84  18           Mx CLC  
00:AF85  65 d7        Mx ADC  $D7
00:AF87  30 33        Mx BMI  $AFBC
00:AF89  85 d3        Mx STA  $D3
00:AF8B  bd 60 04     Mx LDA  $0460,X
00:AF8E  09 00 ff     Mx ORA  #$FF00
00:AF91  18           Mx CLC  
00:AF92  65 d9        Mx ADC  $D9
00:AF94  30 26        Mx BMI  $AFBC
00:AF96  85 d5        Mx STA  $D5
00:AF98  a5 cf        Mx LDA  $CF
00:AF9A  30 20        Mx BMI  $AFBC
00:AF9C  a5 d1        Mx LDA  $D1
00:AF9E  30 1c        Mx BMI  $AFBC
00:AFA0  a5 d5        Mx LDA  $D5
00:AFA2  c5 d1        Mx CMP  $D1
00:AFA4  b0 05        Mx BCS  $AFAB
00:AFA6  20 86 b0     Mx JSR  $B086
00:AFA9  80 03        Mx BRA  $AFAE

L_00AFAB:   ; xref 00AFA4
00:AFAB  20 a3 b0     Mx JSR  $B0A3

L_00AFAE:   ; xref 00AFA9
00:AFAE  a5 d3        Mx LDA  $D3
00:AFB0  c5 cf        Mx CMP  $CF
00:AFB2  b0 05        Mx BCS  $AFB9
00:AFB4  20 4d b0     Mx JSR  $B04D
00:AFB7  80 03        Mx BRA  $AFBC

L_00AFB9:   ; xref 00AFB2
00:AFB9  20 6a b0     Mx JSR  $B06A

L_00AFBC:   ; xref 00AF74 00AF7A 00AF87 00AF94 00AF9A 00AF9E
00:AFBC  e2 30        Mx SEP  #$30
00:AFBE  bd 70 09     mx LDA  $0970,X
00:AFC1  89 80        mx BIT  #$80
00:AFC3  d0 56        mx BNE  $B01B
00:AFC5  a5 ca        mx LDA  $CA
00:AFC7  89 40        mx BIT  #$40
00:AFC9  d0 50        mx BNE  $B01B
00:AFCB  c2 20        mx REP  #$20
00:AFCD  bd 80 08     Mx LDA  $0880,X
00:AFD0  29 ff 00     Mx AND  #$00FF
00:AFD3  89 80 00     Mx BIT  #$0080
00:AFD6  f0 03        Mx BEQ  $AFDB
00:AFD8  09 00 ff     Mx ORA  #$FF00

L_00AFDB:   ; xref 00AFD6
00:AFDB  18           Mx CLC  
00:AFDC  65 d7        Mx ADC  $D7
00:AFDE  30 3b        Mx BMI  $B01B
00:AFE0  85 d3        Mx STA  $D3
00:AFE2  bd b0 08     Mx LDA  $08B0,X
00:AFE5  29 ff 00     Mx AND  #$00FF
00:AFE8  89 80 00     Mx BIT  #$0080
00:AFEB  f0 03        Mx BEQ  $AFF0
00:AFED  09 00 ff     Mx ORA  #$FF00

L_00AFF0:   ; xref 00AFEB
00:AFF0  18           Mx CLC  
00:AFF1  65 d9        Mx ADC  $D9
00:AFF3  30 26        Mx BMI  $B01B
00:AFF5  85 d5        Mx STA  $D5
00:AFF7  a5 cb        Mx LDA  $CB
00:AFF9  30 20        Mx BMI  $B01B
00:AFFB  a5 cd        Mx LDA  $CD
00:AFFD  30 1c        Mx BMI  $B01B
00:AFFF  a5 d5        Mx LDA  $D5
00:B001  c5 cd        Mx CMP  $CD
00:B003  b0 05        Mx BCS  $B00A
00:B005  20 f8 b0     Mx JSR  $B0F8
00:B008  80 03        Mx BRA  $B00D

L_00B00A:   ; xref 00B003
00:B00A  20 15 b1     Mx JSR  $B115

L_00B00D:   ; xref 00B008
00:B00D  a5 d3        Mx LDA  $D3
00:B00F  c5 cb        Mx CMP  $CB
00:B011  b0 05        Mx BCS  $B018
00:B013  20 bf b0     Mx JSR  $B0BF
00:B016  80 03        Mx BRA  $B01B

L_00B018:   ; xref 00B011
00:B018  20 dc b0     Mx JSR  $B0DC

L_00B01B:   ; xref 00AFC3 00AFC9 00AFDE 00AFF3 00AFF9 00AFFD
00:B01B  e2 30        Mx SEP  #$30
00:B01D  bd 60 07     mx LDA  $0760,X
00:B020  29 f3        mx AND  #$F3
00:B022  9d 60 07     mx STA  $0760,X
00:B025  bd 30 07     mx LDA  $0730,X
00:B028  89 03        mx BIT  #$03
00:B02A  f0 0c        mx BEQ  $B038
00:B02C  89 0c        mx BIT  #$0C
00:B02E  f0 08        mx BEQ  $B038
00:B030  bd 60 07     mx LDA  $0760,X
00:B033  09 04        mx ORA  #$04
00:B035  9d 60 07     mx STA  $0760,X

L_00B038:   ; xref 00B02A 00B02E
00:B038  bd 30 07     mx LDA  $0730,X
00:B03B  89 30        mx BIT  #$30
00:B03D  f0 0c        mx BEQ  $B04B
00:B03F  89 c0        mx BIT  #$C0
00:B041  f0 08        mx BEQ  $B04B
00:B043  bd 60 07     mx LDA  $0760,X
00:B046  09 08        mx ORA  #$08
00:B048  9d 60 07     mx STA  $0760,X

L_00B04B:   ; xref 00B03D 00B041
00:B04B  28           mx PLP  
00:B04C  60           mx RTS  

L_00B04D:   ; xref 00AFB4
00:B04D  c2 20        Mx REP  #$20
00:B04F  bd 90 04     Mx LDA  $0490,X
00:B052  29 ff 00     Mx AND  #$00FF
00:B055  18           Mx CLC  
00:B056  65 d3        Mx ADC  $D3
00:B058  38           Mx SEC  
00:B059  e5 cf        Mx SBC  $CF
00:B05B  30 0c        Mx BMI  $B069
00:B05D  e2 20        Mx SEP  #$20
00:B05F  bd 30 07     mx LDA  $0730,X
00:B062  09 04        mx ORA  #$04
00:B064  9d 30 07     mx STA  $0730,X
00:B067  c2 20        mx REP  #$20

L_00B069:   ; xref 00B05B
00:B069  60           Mx RTS  

L_00B06A:   ; xref 00AFB9
00:B06A  c2 20        Mx REP  #$20
00:B06C  a5 c8        Mx LDA  $C8
00:B06E  29 ff 00     Mx AND  #$00FF
00:B071  18           Mx CLC  
00:B072  65 cf        Mx ADC  $CF
00:B074  38           Mx SEC  
00:B075  e5 d3        Mx SBC  $D3
00:B077  30 0c        Mx BMI  $B085
00:B079  e2 20        Mx SEP  #$20
00:B07B  bd 30 07     mx LDA  $0730,X
00:B07E  09 08        mx ORA  #$08
00:B080  9d 30 07     mx STA  $0730,X
00:B083  c2 20        mx REP  #$20

L_00B085:   ; xref 00B077
00:B085  60           Mx RTS  

L_00B086:   ; xref 00AFA6
00:B086  c2 20        Mx REP  #$20
00:B088  bd c0 04     Mx LDA  $04C0,X
00:B08B  29 ff 00     Mx AND  #$00FF
00:B08E  18           Mx CLC  
00:B08F  65 d5        Mx ADC  $D5
00:B091  38           Mx SEC  
00:B092  e5 d1        Mx SBC  $D1
00:B094  30 0c        Mx BMI  $B0A2
00:B096  e2 20        Mx SEP  #$20
00:B098  bd 30 07     mx LDA  $0730,X
00:B09B  09 01        mx ORA  #$01
00:B09D  9d 30 07     mx STA  $0730,X
00:B0A0  c2 20        mx REP  #$20

L_00B0A2:   ; xref 00B094
00:B0A2  60           Mx RTS  

L_00B0A3:   ; xref 00AFAB
00:B0A3  c2 20        Mx REP  #$20
00:B0A5  a5 c9        Mx LDA  $C9
00:B0A7  29 ff 00     Mx AND  #$00FF
00:B0AA  18           Mx CLC  
00:B0AB  65 d1        Mx ADC  $D1
00:B0AD  38           Mx SEC  
00:B0AE  e5 d5        Mx SBC  $D5
00:B0B0  30 0c        Mx BMI  $B0BE
00:B0B2  e2 20        Mx SEP  #$20
00:B0B4  bd 30 07     mx LDA  $0730,X
00:B0B7  09 02        mx ORA  #$02
00:B0B9  9d 30 07     mx STA  $0730,X
00:B0BC  c2 20        mx REP  #$20

L_00B0BE:   ; xref 00B0B0
00:B0BE  60           Mx RTS  

L_00B0BF:   ; xref 00B013
00:B0BF  c2 20        Mx REP  #$20
00:B0C1  bd e0 08     Mx LDA  $08E0,X
00:B0C4  29 ff 00     Mx AND  #$00FF
00:B0C7  18           Mx CLC  
00:B0C8  65 d3        Mx ADC  $D3
00:B0CA  38           Mx SEC  
00:B0CB  e5 cb        Mx SBC  $CB
00:B0CD  30 0c        Mx BMI  $B0DB
00:B0CF  e2 20        Mx SEP  #$20
00:B0D1  bd 30 07     mx LDA  $0730,X
00:B0D4  09 40        mx ORA  #$40
00:B0D6  9d 30 07     mx STA  $0730,X
00:B0D9  c2 20        mx REP  #$20

L_00B0DB:   ; xref 00B0CD
00:B0DB  60           Mx RTS  

L_00B0DC:   ; xref 00B018
00:B0DC  c2 20        Mx REP  #$20
00:B0DE  a5 c6        Mx LDA  $C6
00:B0E0  29 ff 00     Mx AND  #$00FF
00:B0E3  18           Mx CLC  
00:B0E4  65 cb        Mx ADC  $CB
00:B0E6  38           Mx SEC  
00:B0E7  e5 d3        Mx SBC  $D3
00:B0E9  30 0c        Mx BMI  $B0F7
00:B0EB  e2 20        Mx SEP  #$20
00:B0ED  bd 30 07     mx LDA  $0730,X
00:B0F0  09 80        mx ORA  #$80
00:B0F2  9d 30 07     mx STA  $0730,X
00:B0F5  c2 20        mx REP  #$20

L_00B0F7:   ; xref 00B0E9
00:B0F7  60           Mx RTS  

L_00B0F8:   ; xref 00B005
00:B0F8  c2 20        Mx REP  #$20
00:B0FA  bd 10 09     Mx LDA  $0910,X
00:B0FD  29 ff 00     Mx AND  #$00FF
00:B100  18           Mx CLC  
00:B101  65 d5        Mx ADC  $D5
00:B103  38           Mx SEC  
00:B104  e5 cd        Mx SBC  $CD
00:B106  30 0c        Mx BMI  $B114
00:B108  e2 20        Mx SEP  #$20
00:B10A  bd 30 07     mx LDA  $0730,X
00:B10D  09 10        mx ORA  #$10
00:B10F  9d 30 07     mx STA  $0730,X
00:B112  c2 20        mx REP  #$20

L_00B114:   ; xref 00B106
00:B114  60           Mx RTS  

L_00B115:   ; xref 00B00A
00:B115  c2 20        Mx REP  #$20
00:B117  a5 c7        Mx LDA  $C7
00:B119  29 ff 00     Mx AND  #$00FF
00:B11C  18           Mx CLC  
00:B11D  65 cd        Mx ADC  $CD
00:B11F  38           Mx SEC  
00:B120  e5 d5        Mx SBC  $D5
00:B122  30 0c        Mx BMI  $B130
00:B124  e2 20        Mx SEP  #$20
00:B126  bd 30 07     mx LDA  $0730,X
00:B129  09 20        mx ORA  #$20
00:B12B  9d 30 07     mx STA  $0730,X
00:B12E  c2 20        mx REP  #$20

L_00B130:   ; xref 00B122
00:B130  60           Mx RTS  

L_00B135:   ; xref 00C5F0 00BDA8 00C027 00BC53
00:B135  08           mx PHP  
00:B136  e2 30        mx SEP  #$30
00:B138  c2 20        mx REP  #$20
00:B13A  a9 00 20     Mx LDA  #$2000
00:B13D  20 79 b1     Mx JSR  $B179
00:B140  c2 20        Mx REP  #$20
00:B142  a9 00 80     Mx LDA  #$8000
00:B145  85 2d        Mx STA  $2D
00:B147  a9 00 7c     Mx LDA  #$7C00
00:B14A  85 2f        Mx STA  $2F
00:B14C  a9 00 08     Mx LDA  #$0800
00:B14F  85 31        Mx STA  $31
00:B151  e2 20        Mx SEP  #$20
00:B153  a9 7f        mx LDA  #$7F
00:B155  85 2c        mx STA  $2C
00:B157  a9 01        mx LDA  #$01
00:B159  85 29        mx STA  $29
00:B15B  a9 80        mx LDA  #$80
00:B15D  85 2a        mx STA  $2A
00:B15F  a9 18        mx LDA  #$18
00:B161  85 2b        mx STA  $2B
00:B163  20 ed 82     mx JSR  $82ED
00:B166  20 c3 83     mx JSR  $83C3
00:B169  c2 20        mx REP  #$20
00:B16B  a9 00 00     Mx LDA  #$0000
00:B16E  20 79 b1     Mx JSR  $B179
00:B171  20 c3 83     Mx JSR  $83C3
00:B174  20 93 b1     Mx JSR  $B193
00:B177  28           Mx PLP  
00:B178  60           Mx RTS  

L_00B179:   ; xref 00B13D 00B16E
00:B179  c2 30        Mx REP  #$30
00:B17B  a2 00 00     MX LDX  #$0000

L_00B17E:   ; xref 00B188
00:B17E  9f 00 80 7f  MX STA  $7F8000,X
00:B182  e8           MX INX  
00:B183  e8           MX INX  
00:B184  1a           MX INC  
00:B185  e0 00 08     MX CPX  #$0800
00:B188  d0 f4        MX BNE  $B17E
00:B18A  60           MX RTS  

L_00B193:   ; xref 00B174
00:B193  20 9a b1     Mx JSR  $B19A
00:B196  20 cf b1     Mx JSR  $B1CF
00:B199  60           Mx RTS  

L_00B19A:   ; xref 00B193
00:B19A  08           Mx PHP  
00:B19B  c2 20        Mx REP  #$20
00:B19D  a9 00 00     Mx LDA  #$0000
00:B1A0  8f 00 80 7f  Mx STA  $7F8000
00:B1A4  c2 20        Mx REP  #$20
00:B1A6  a9 00 80     Mx LDA  #$8000
00:B1A9  85 2d        Mx STA  $2D
00:B1AB  a9 00 5c     Mx LDA  #$5C00
00:B1AE  85 2f        Mx STA  $2F
00:B1B0  a9 00 08     Mx LDA  #$0800
00:B1B3  85 31        Mx STA  $31
00:B1B5  e2 20        Mx SEP  #$20
00:B1B7  a9 7f        mx LDA  #$7F
00:B1B9  85 2c        mx STA  $2C
00:B1BB  a9 09        mx LDA  #$09
00:B1BD  85 29        mx STA  $29
00:B1BF  a9 80        mx LDA  #$80
00:B1C1  85 2a        mx STA  $2A
00:B1C3  a9 18        mx LDA  #$18
00:B1C5  85 2b        mx STA  $2B
00:B1C7  20 ed 82     mx JSR  $82ED
00:B1CA  20 c3 83     mx JSR  $83C3
00:B1CD  28           mx PLP  
00:B1CE  60           mx RTS  

L_00B1CF:   ; xref 00C683 00C6A7 00C6C2 00B196 00C4CF 00C428
00:B1CF  08           MX PHP  
00:B1D0  c2 20        MX REP  #$20
00:B1D2  a9 00 00     MX LDA  #$0000
00:B1D5  8f 00 80 7f  MX STA  $7F8000
00:B1D9  c2 20        MX REP  #$20
00:B1DB  a9 00 80     MX LDA  #$8000
00:B1DE  85 2d        MX STA  $2D
00:B1E0  a9 00 60     MX LDA  #$6000
00:B1E3  85 2f        MX STA  $2F
00:B1E5  a9 00 0c     MX LDA  #$0C00
00:B1E8  85 31        MX STA  $31
00:B1EA  e2 20        MX SEP  #$20
00:B1EC  a9 7f        mX LDA  #$7F
00:B1EE  85 2c        mX STA  $2C
00:B1F0  a9 09        mX LDA  #$09
00:B1F2  85 29        mX STA  $29
00:B1F4  a9 80        mX LDA  #$80
00:B1F6  85 2a        mX STA  $2A
00:B1F8  a9 18        mX LDA  #$18
00:B1FA  85 2b        mX STA  $2B
00:B1FC  20 ed 82     mX JSR  $82ED
00:B1FF  20 c3 83     mX JSR  $83C3
00:B202  c2 20        mX REP  #$20
00:B204  a9 00 80     MX LDA  #$8000
00:B207  85 2d        MX STA  $2D
00:B209  a9 00 66     MX LDA  #$6600
00:B20C  85 2f        MX STA  $2F
00:B20E  a9 00 0c     MX LDA  #$0C00
00:B211  85 31        MX STA  $31
00:B213  e2 20        MX SEP  #$20
00:B215  a9 7f        mX LDA  #$7F
00:B217  85 2c        mX STA  $2C
00:B219  a9 09        mX LDA  #$09
00:B21B  85 29        mX STA  $29
00:B21D  a9 80        mX LDA  #$80
00:B21F  85 2a        mX STA  $2A
00:B221  a9 18        mX LDA  #$18
00:B223  85 2b        mX STA  $2B
00:B225  20 ed 82     mX JSR  $82ED
00:B228  20 c3 83     mX JSR  $83C3
00:B22B  c2 20        mX REP  #$20
00:B22D  a9 00 80     MX LDA  #$8000
00:B230  85 2d        MX STA  $2D
00:B232  a9 00 6c     MX LDA  #$6C00
00:B235  85 2f        MX STA  $2F
00:B237  a9 00 0c     MX LDA  #$0C00
00:B23A  85 31        MX STA  $31
00:B23C  e2 20        MX SEP  #$20
00:B23E  a9 7f        mX LDA  #$7F
00:B240  85 2c        mX STA  $2C
00:B242  a9 09        mX LDA  #$09
00:B244  85 29        mX STA  $29
00:B246  a9 80        mX LDA  #$80
00:B248  85 2a        mX STA  $2A
00:B24A  a9 18        mX LDA  #$18
00:B24C  85 2b        mX STA  $2B
00:B24E  20 ed 82     mX JSR  $82ED
00:B251  20 c3 83     mX JSR  $83C3
00:B254  c2 20        mX REP  #$20
00:B256  a9 00 80     MX LDA  #$8000
00:B259  85 2d        MX STA  $2D
00:B25B  a9 00 72     MX LDA  #$7200
00:B25E  85 2f        MX STA  $2F
00:B260  a9 00 0c     MX LDA  #$0C00
00:B263  85 31        MX STA  $31
00:B265  e2 20        MX SEP  #$20
00:B267  a9 7f        mX LDA  #$7F
00:B269  85 2c        mX STA  $2C
00:B26B  a9 09        mX LDA  #$09
00:B26D  85 29        mX STA  $29
00:B26F  a9 80        mX LDA  #$80
00:B271  85 2a        mX STA  $2A
00:B273  a9 18        mX LDA  #$18
00:B275  85 2b        mX STA  $2B
00:B277  20 ed 82     mX JSR  $82ED
00:B27A  20 c3 83     mX JSR  $83C3
00:B27D  c2 20        mX REP  #$20
00:B27F  a9 00 80     MX LDA  #$8000
00:B282  85 2d        MX STA  $2D
00:B284  a9 00 78     MX LDA  #$7800
00:B287  85 2f        MX STA  $2F
00:B289  a9 00 08     MX LDA  #$0800
00:B28C  85 31        MX STA  $31
00:B28E  e2 20        MX SEP  #$20
00:B290  a9 7f        mX LDA  #$7F
00:B292  85 2c        mX STA  $2C
00:B294  a9 09        mX LDA  #$09
00:B296  85 29        mX STA  $29
00:B298  a9 80        mX LDA  #$80
00:B29A  85 2a        mX STA  $2A
00:B29C  a9 18        mX LDA  #$18
00:B29E  85 2b        mX STA  $2B
00:B2A0  20 ed 82     mX JSR  $82ED
00:B2A3  20 c3 83     mX JSR  $83C3
00:B2A6  28           mX PLP  
00:B2A7  60           mX RTS  

L_00B2A8:   ; xref 00C6A4
00:B2A8  08           MX PHP  
00:B2A9  c2 20        MX REP  #$20
00:B2AB  a9 00 00     MX LDA  #$0000
00:B2AE  8f 00 80 7f  MX STA  $7F8000
00:B2B2  c2 20        MX REP  #$20
00:B2B4  a9 00 80     MX LDA  #$8000
00:B2B7  85 2d        MX STA  $2D
00:B2B9  a9 00 20     MX LDA  #$2000
00:B2BC  85 2f        MX STA  $2F
00:B2BE  a9 00 0c     MX LDA  #$0C00
00:B2C1  85 31        MX STA  $31
00:B2C3  e2 20        MX SEP  #$20
00:B2C5  a9 7f        mX LDA  #$7F
00:B2C7  85 2c        mX STA  $2C
00:B2C9  a9 09        mX LDA  #$09
00:B2CB  85 29        mX STA  $29
00:B2CD  a9 80        mX LDA  #$80
00:B2CF  85 2a        mX STA  $2A
00:B2D1  a9 18        mX LDA  #$18
00:B2D3  85 2b        mX STA  $2B
00:B2D5  20 ed 82     mX JSR  $82ED
00:B2D8  20 c3 83     mX JSR  $83C3
00:B2DB  c2 20        mX REP  #$20
00:B2DD  a9 00 80     MX LDA  #$8000
00:B2E0  85 2d        MX STA  $2D
00:B2E2  a9 00 26     MX LDA  #$2600
00:B2E5  85 2f        MX STA  $2F
00:B2E7  a9 00 0c     MX LDA  #$0C00
00:B2EA  85 31        MX STA  $31
00:B2EC  e2 20        MX SEP  #$20
00:B2EE  a9 7f        mX LDA  #$7F
00:B2F0  85 2c        mX STA  $2C
00:B2F2  a9 09        mX LDA  #$09
00:B2F4  85 29        mX STA  $29
00:B2F6  a9 80        mX LDA  #$80
00:B2F8  85 2a        mX STA  $2A
00:B2FA  a9 18        mX LDA  #$18
00:B2FC  85 2b        mX STA  $2B
00:B2FE  20 ed 82     mX JSR  $82ED
00:B301  20 c3 83     mX JSR  $83C3
00:B304  c2 20        mX REP  #$20
00:B306  a9 00 80     MX LDA  #$8000
00:B309  85 2d        MX STA  $2D
00:B30B  a9 00 2c     MX LDA  #$2C00
00:B30E  85 2f        MX STA  $2F
00:B310  a9 00 0c     MX LDA  #$0C00
00:B313  85 31        MX STA  $31
00:B315  e2 20        MX SEP  #$20
00:B317  a9 7f        mX LDA  #$7F
00:B319  85 2c        mX STA  $2C
00:B31B  a9 09        mX LDA  #$09
00:B31D  85 29        mX STA  $29
00:B31F  a9 80        mX LDA  #$80
00:B321  85 2a        mX STA  $2A
00:B323  a9 18        mX LDA  #$18
00:B325  85 2b        mX STA  $2B
00:B327  20 ed 82     mX JSR  $82ED
00:B32A  20 c3 83     mX JSR  $83C3
00:B32D  c2 20        mX REP  #$20
00:B32F  a9 00 80     MX LDA  #$8000
00:B332  85 2d        MX STA  $2D
00:B334  a9 00 32     MX LDA  #$3200
00:B337  85 2f        MX STA  $2F
00:B339  a9 00 0c     MX LDA  #$0C00
00:B33C  85 31        MX STA  $31
00:B33E  e2 20        MX SEP  #$20
00:B340  a9 7f        mX LDA  #$7F
00:B342  85 2c        mX STA  $2C
00:B344  a9 09        mX LDA  #$09
00:B346  85 29        mX STA  $29
00:B348  a9 80        mX LDA  #$80
00:B34A  85 2a        mX STA  $2A
00:B34C  a9 18        mX LDA  #$18
00:B34E  85 2b        mX STA  $2B
00:B350  20 ed 82     mX JSR  $82ED
00:B353  20 c3 83     mX JSR  $83C3
00:B356  c2 20        mX REP  #$20
00:B358  a9 00 80     MX LDA  #$8000
00:B35B  85 2d        MX STA  $2D
00:B35D  a9 00 38     MX LDA  #$3800
00:B360  85 2f        MX STA  $2F
00:B362  a9 00 0c     MX LDA  #$0C00
00:B365  85 31        MX STA  $31
00:B367  e2 20        MX SEP  #$20
00:B369  a9 7f        mX LDA  #$7F
00:B36B  85 2c        mX STA  $2C
00:B36D  a9 09        mX LDA  #$09
00:B36F  85 29        mX STA  $29
00:B371  a9 80        mX LDA  #$80
00:B373  85 2a        mX STA  $2A
00:B375  a9 18        mX LDA  #$18
00:B377  85 2b        mX STA  $2B
00:B379  20 ed 82     mX JSR  $82ED
00:B37C  20 c3 83     mX JSR  $83C3
00:B37F  c2 20        mX REP  #$20
00:B381  a9 00 80     MX LDA  #$8000
00:B384  85 2d        MX STA  $2D
00:B386  a9 00 3e     MX LDA  #$3E00
00:B389  85 2f        MX STA  $2F
00:B38B  a9 00 0c     MX LDA  #$0C00
00:B38E  85 31        MX STA  $31
00:B390  e2 20        MX SEP  #$20
00:B392  a9 7f        mX LDA  #$7F
00:B394  85 2c        mX STA  $2C
00:B396  a9 09        mX LDA  #$09
00:B398  85 29        mX STA  $29
00:B39A  a9 80        mX LDA  #$80
00:B39C  85 2a        mX STA  $2A
00:B39E  a9 18        mX LDA  #$18
00:B3A0  85 2b        mX STA  $2B
00:B3A2  20 ed 82     mX JSR  $82ED
00:B3A5  20 c3 83     mX JSR  $83C3
00:B3A8  c2 20        mX REP  #$20
00:B3AA  a9 00 80     MX LDA  #$8000
00:B3AD  85 2d        MX STA  $2D
00:B3AF  a9 00 44     MX LDA  #$4400
00:B3B2  85 2f        MX STA  $2F
00:B3B4  a9 00 0c     MX LDA  #$0C00
00:B3B7  85 31        MX STA  $31
00:B3B9  e2 20        MX SEP  #$20
00:B3BB  a9 7f        mX LDA  #$7F
00:B3BD  85 2c        mX STA  $2C
00:B3BF  a9 09        mX LDA  #$09
00:B3C1  85 29        mX STA  $29
00:B3C3  a9 80        mX LDA  #$80
00:B3C5  85 2a        mX STA  $2A
00:B3C7  a9 18        mX LDA  #$18
00:B3C9  85 2b        mX STA  $2B
00:B3CB  20 ed 82     mX JSR  $82ED
00:B3CE  20 c3 83     mX JSR  $83C3
00:B3D1  c2 20        mX REP  #$20
00:B3D3  a9 00 80     MX LDA  #$8000
00:B3D6  85 2d        MX STA  $2D
00:B3D8  a9 00 4a     MX LDA  #$4A00
00:B3DB  85 2f        MX STA  $2F
00:B3DD  a9 00 0c     MX LDA  #$0C00
00:B3E0  85 31        MX STA  $31
00:B3E2  e2 20        MX SEP  #$20
00:B3E4  a9 7f        mX LDA  #$7F
00:B3E6  85 2c        mX STA  $2C
00:B3E8  a9 09        mX LDA  #$09
00:B3EA  85 29        mX STA  $29
00:B3EC  a9 80        mX LDA  #$80
00:B3EE  85 2a        mX STA  $2A
00:B3F0  a9 18        mX LDA  #$18
00:B3F2  85 2b        mX STA  $2B
00:B3F4  20 ed 82     mX JSR  $82ED
00:B3F7  20 c3 83     mX JSR  $83C3
00:B3FA  c2 20        mX REP  #$20
00:B3FC  a9 00 80     MX LDA  #$8000
00:B3FF  85 2d        MX STA  $2D
00:B401  a9 00 50     MX LDA  #$5000
00:B404  85 2f        MX STA  $2F
00:B406  a9 00 0c     MX LDA  #$0C00
00:B409  85 31        MX STA  $31
00:B40B  e2 20        MX SEP  #$20
00:B40D  a9 7f        mX LDA  #$7F
00:B40F  85 2c        mX STA  $2C
00:B411  a9 09        mX LDA  #$09
00:B413  85 29        mX STA  $29
00:B415  a9 80        mX LDA  #$80
00:B417  85 2a        mX STA  $2A
00:B419  a9 18        mX LDA  #$18
00:B41B  85 2b        mX STA  $2B
00:B41D  20 ed 82     mX JSR  $82ED
00:B420  20 c3 83     mX JSR  $83C3
00:B423  c2 20        mX REP  #$20
00:B425  a9 00 80     MX LDA  #$8000
00:B428  85 2d        MX STA  $2D
00:B42A  a9 00 56     MX LDA  #$5600
00:B42D  85 2f        MX STA  $2F
00:B42F  a9 00 04     MX LDA  #$0400
00:B432  85 31        MX STA  $31
00:B434  e2 20        MX SEP  #$20
00:B436  a9 7f        mX LDA  #$7F
00:B438  85 2c        mX STA  $2C
00:B43A  a9 09        mX LDA  #$09
00:B43C  85 29        mX STA  $29
00:B43E  a9 80        mX LDA  #$80
00:B440  85 2a        mX STA  $2A
00:B442  a9 18        mX LDA  #$18
00:B444  85 2b        mX STA  $2B
00:B446  20 ed 82     mX JSR  $82ED
00:B449  20 c3 83     mX JSR  $83C3
00:B44C  28           mX PLP  
00:B44D  60           mX RTS  

L_00B44E:   ; xref 008268
00:B44E  e2 30        MX SEP  #$30
00:B450  9c 44 12     mx STZ  $1244
00:B453  9c 45 12     mx STZ  $1245
00:B456  9c 46 12     mx STZ  $1246
00:B459  9c 47 12     mx STZ  $1247
00:B45C  9c 48 12     mx STZ  $1248
00:B45F  9c 49 12     mx STZ  $1249
00:B462  9c 4a 12     mx STZ  $124A
00:B465  9c 4b 12     mx STZ  $124B
00:B468  9c 4c 12     mx STZ  $124C
00:B46B  9c 4d 12     mx STZ  $124D
00:B46E  20 ee b4     mx JSR  $B4EE
00:B471  60           mx RTS  

L_00B472:   ; xref 00826B
00:B472  e2 30        MX SEP  #$30
00:B474  ad 4d 12     mx LDA  $124D
00:B477  d0 01        mx BNE  $B47A
00:B479  60           mx RTS  

L_00B47A:   ; xref 00B477
00:B47A  ce 4d 12     mx DEC  $124D
00:B47D  e2 30        mx SEP  #$30
00:B47F  ee 44 12     mx INC  $1244
00:B482  ad 44 12     mx LDA  $1244
00:B485  c9 09        mx CMP  #$09
00:B487  d0 61        mx BNE  $B4EA
00:B489  9c 44 12     mx STZ  $1244
00:B48C  ee 45 12     mx INC  $1245
00:B48F  ad 45 12     mx LDA  $1245
00:B492  c9 09        mx CMP  #$09
00:B494  d0 54        mx BNE  $B4EA
00:B496  9c 45 12     mx STZ  $1245
00:B499  ee 46 12     mx INC  $1246
00:B49C  ad 46 12     mx LDA  $1246
00:B49F  c9 09        mx CMP  #$09
00:B4A1  d0 47        mx BNE  $B4EA
00:B4A3  9c 46 12     mx STZ  $1246
00:B4A6  ee 47 12     mx INC  $1247
00:B4A9  ad 47 12     mx LDA  $1247
00:B4AC  c9 09        mx CMP  #$09
00:B4AE  d0 3a        mx BNE  $B4EA
00:B4B0  9c 47 12     mx STZ  $1247
00:B4B3  ee 47 12     mx INC  $1247
00:B4B6  ad 48 12     mx LDA  $1248
00:B4B9  c9 09        mx CMP  #$09
00:B4BB  d0 2d        mx BNE  $B4EA
00:B4BD  9c 48 12     mx STZ  $1248
00:B4C0  ee 49 12     mx INC  $1249
00:B4C3  ad 49 12     mx LDA  $1249
00:B4C6  c9 09        mx CMP  #$09
00:B4C8  d0 20        mx BNE  $B4EA
00:B4CA  9c 49 12     mx STZ  $1249
00:B4CD  ee 4a 12     mx INC  $124A
00:B4D0  ad 4a 12     mx LDA  $124A
00:B4D3  c9 09        mx CMP  #$09
00:B4D5  d0 13        mx BNE  $B4EA
00:B4D7  9c 4a 12     mx STZ  $124A
00:B4DA  ee 4b 12     mx INC  $124B
00:B4DD  ad 4b 12     mx LDA  $124B
00:B4E0  c9 09        mx CMP  #$09
00:B4E2  d0 06        mx BNE  $B4EA
00:B4E4  9c 4b 12     mx STZ  $124B
00:B4E7  ee 4c 12     mx INC  $124C

L_00B4EA:   ; xref 00B487 00B494 00B4A1 00B4AE 00B4BB 00B4C8
00:B4EA  20 ee b4     mx JSR  $B4EE
00:B4ED  60           mx RTS  

L_00B4EE:   ; xref 00B4EA 00B46E
00:B4EE  08           mx PHP  
00:B4EF  c2 20        mx REP  #$20
00:B4F1  64 06        Mx STZ  $06
00:B4F3  e2 30        Mx SEP  #$30
00:B4F5  a2 00        mx LDX  #$00
00:B4F7  20 4f b5     mx JSR  $B54F
00:B4FA  e2 30        mx SEP  #$30
00:B4FC  a2 01        mx LDX  #$01

L_00B4FE:   ; xref 00B508
00:B4FE  da           mx PHX  
00:B4FF  20 4f b5     mx JSR  $B54F
00:B502  e2 30        mx SEP  #$30
00:B504  fa           mx PLX  
00:B505  e8           mx INX  
00:B506  e0 09        mx CPX  #$09
00:B508  d0 f4        mx BNE  $B4FE
00:B50A  c2 30        mx REP  #$30
00:B50C  a5 06        MX LDA  $06
00:B50E  f0 25        MX BEQ  $B535
00:B510  c2 20        MX REP  #$20
00:B512  a9 00 80     MX LDA  #$8000
00:B515  85 2d        MX STA  $2D
00:B517  a9 00 00     MX LDA  #$0000
00:B51A  85 2f        MX STA  $2F
00:B51C  a5 06        MX LDA  $06
00:B51E  85 31        MX STA  $31
00:B520  e2 20        MX SEP  #$20
00:B522  a9 7f        mX LDA  #$7F
00:B524  85 2c        mX STA  $2C
00:B526  a9 04        mX LDA  #$04
00:B528  85 29        mX STA  $29
00:B52A  a9 80        mX LDA  #$80
00:B52C  85 2a        mX STA  $2A
00:B52E  a9 16        mX LDA  #$16
00:B530  85 2b        mX STA  $2B
00:B532  20 ed 82     mX JSR  $82ED

L_00B535:   ; xref 00B50E
00:B535  28           mX PLP  
00:B536  60           mX RTS  

L_00B54F:   ; xref 00B4F7 00B4FF
00:B54F  c2 30        mx REP  #$30
00:B551  bd 44 12     MX LDA  $1244,X
00:B554  29 ff 00     MX AND  #$00FF
00:B557  85 00        MX STA  $00
00:B559  c2 30        MX REP  #$30
00:B55B  8a           MX TXA  
00:B55C  29 ff 00     MX AND  #$00FF
00:B55F  0a           MX ASL  
00:B560  aa           MX TAX  
00:B561  bd de b5     MX LDA  $B5DE,X
00:B564  29 ff 00     MX AND  #$00FF
00:B567  18           MX CLC  
00:B568  6d 50 12     MX ADC  $1250
00:B56B  0a           MX ASL  
00:B56C  0a           MX ASL  
00:B56D  0a           MX ASL  
00:B56E  0a           MX ASL  
00:B56F  0a           MX ASL  
00:B570  85 03        MX STA  $03
00:B572  bd dd b5     MX LDA  $B5DD,X
00:B575  29 ff 00     MX AND  #$00FF
00:B578  18           MX CLC  
00:B579  6d 4e 12     MX ADC  $124E
00:B57C  18           MX CLC  
00:B57D  65 03        MX ADC  $03
00:B57F  18           MX CLC  
00:B580  69 00 5c     MX ADC  #$5C00
00:B583  85 03        MX STA  $03
00:B585  a5 00        MX LDA  $00
00:B587  0a           MX ASL  
00:B588  0a           MX ASL  
00:B589  0a           MX ASL  
00:B58A  a8           MX TAY  
00:B58B  a6 06        MX LDX  $06
00:B58D  a5 03        MX LDA  $03
00:B58F  9f 00 80 7f  MX STA  $7F8000,X
00:B593  e8           MX INX  
00:B594  e8           MX INX  
00:B595  b9 ef b5     MX LDA  $B5EF,Y
00:B598  9f 00 80 7f  MX STA  $7F8000,X
00:B59C  e8           MX INX  
00:B59D  e8           MX INX  
00:B59E  a5 03        MX LDA  $03
00:B5A0  1a           MX INC  
00:B5A1  9f 00 80 7f  MX STA  $7F8000,X
00:B5A5  e8           MX INX  
00:B5A6  e8           MX INX  
00:B5A7  b9 f1 b5     MX LDA  $B5F1,Y
00:B5AA  9f 00 80 7f  MX STA  $7F8000,X
00:B5AE  e8           MX INX  
00:B5AF  e8           MX INX  
00:B5B0  a5 03        MX LDA  $03
00:B5B2  18           MX CLC  
00:B5B3  69 20 00     MX ADC  #$0020
00:B5B6  9f 00 80 7f  MX STA  $7F8000,X
00:B5BA  e8           MX INX  
00:B5BB  e8           MX INX  
00:B5BC  b9 f3 b5     MX LDA  $B5F3,Y
00:B5BF  9f 00 80 7f  MX STA  $7F8000,X
00:B5C3  e8           MX INX  
00:B5C4  e8           MX INX  
00:B5C5  a5 03        MX LDA  $03
00:B5C7  18           MX CLC  
00:B5C8  69 21 00     MX ADC  #$0021
00:B5CB  9f 00 80 7f  MX STA  $7F8000,X
00:B5CF  e8           MX INX  
00:B5D0  e8           MX INX  
00:B5D1  b9 f5 b5     MX LDA  $B5F5,Y
00:B5D4  9f 00 80 7f  MX STA  $7F8000,X
00:B5D8  e8           MX INX  
00:B5D9  e8           MX INX  
00:B5DA  86 06        MX STX  $06
00:B5DC  60           MX RTS  

L_00B722:   ; xref 00C693 00BDBB 00C4E2 00C43B 00C345 00C236
00:B722  08           Mx PHP  
00:B723  c2 20        Mx REP  #$20
00:B725  64 06        Mx STZ  $06

L_00B727:   ; xref 00B73D
00:B727  c2 20        Mx REP  #$20
00:B729  a7 0c        Mx LDA  [$0C]
00:B72B  c9 ff ff     Mx CMP  #$FFFF
00:B72E  f0 10        Mx BEQ  $B740
00:B730  20 45 b7     Mx JSR  $B745
00:B733  c2 20        Mx REP  #$20
00:B735  a5 0c        Mx LDA  $0C
00:B737  18           Mx CLC  
00:B738  69 0a 00     Mx ADC  #$000A
00:B73B  85 0c        Mx STA  $0C
00:B73D  4c 27 b7     Mx JMP  $B727

L_00B740:   ; xref 00B72E
00:B740  20 fb b9     Mx JSR  $B9FB
00:B743  28           Mx PLP  
00:B744  60           Mx RTS  

L_00B745:   ; xref 00B730
00:B745  c2 30        Mx REP  #$30
00:B747  a0 02 00     MX LDY  #$0002
00:B74A  b7 0c        MX LDA  [$0C],Y
00:B74C  0a           MX ASL  
00:B74D  0a           MX ASL  
00:B74E  0a           MX ASL  
00:B74F  0a           MX ASL  
00:B750  0a           MX ASL  
00:B751  18           MX CLC  
00:B752  67 0c        MX ADC  [$0C]
00:B754  85 03        MX STA  $03
00:B756  a0 06 00     MX LDY  #$0006
00:B759  b7 0c        MX LDA  [$0C],Y
00:B75B  a6 06        MX LDX  $06

L_00B75D:   ; xref 00B798
00:B75D  48           MX PHA  
00:B75E  a5 03        MX LDA  $03
00:B760  a0 08 00     MX LDY  #$0008
00:B763  18           MX CLC  
00:B764  77 0c        MX ADC  [$0C],Y
00:B766  85 09        MX STA  $09
00:B768  a5 03        MX LDA  $03
00:B76A  18           MX CLC  
00:B76B  69 00 58     MX ADC  #$5800
00:B76E  85 0f        MX STA  $0F
00:B770  a0 04 00     MX LDY  #$0004
00:B773  b7 0c        MX LDA  [$0C],Y

L_00B775:   ; xref 00B78C
00:B775  48           MX PHA  
00:B776  a5 0f        MX LDA  $0F
00:B778  9f 00 80 7f  MX STA  $7F8000,X
00:B77C  e8           MX INX  
00:B77D  e8           MX INX  
00:B77E  a5 09        MX LDA  $09
00:B780  9f 00 80 7f  MX STA  $7F8000,X
00:B784  e8           MX INX  
00:B785  e8           MX INX  
00:B786  e6 0f        MX INC  $0F
00:B788  e6 09        MX INC  $09
00:B78A  68           MX PLA  
00:B78B  3a           MX DEC  
00:B78C  d0 e7        MX BNE  $B775
00:B78E  a5 03        MX LDA  $03
00:B790  18           MX CLC  
00:B791  69 20 00     MX ADC  #$0020
00:B794  85 03        MX STA  $03
00:B796  68           MX PLA  
00:B797  3a           MX DEC  
00:B798  d0 c3        MX BNE  $B75D
00:B79A  8a           MX TXA  
00:B79B  85 06        MX STA  $06
00:B79D  60           MX RTS  

L_00B7A2:   ; xref 00C5EC 00C5BB 00C58A 00C559 00BD72 00BD41
00:B7A2  08           Mx PHP  
00:B7A3  e2 30        Mx SEP  #$30
00:B7A5  a9 80        mx LDA  #$80
00:B7A7  85 0e        mx STA  $0E
00:B7A9  c2 20        mx REP  #$20
00:B7AB  64 06        Mx STZ  $06
00:B7AD  20 b2 b7     Mx JSR  $B7B2
00:B7B0  28           Mx PLP  
00:B7B1  60           Mx RTS  

L_00B7B2:   ; xref 00B7AD
00:B7B2  c2 30        Mx REP  #$30
00:B7B4  a0 00 00     MX LDY  #$0000

L_00B7B7:   ; xref 00B7EE
00:B7B7  b7 0c        MX LDA  [$0C],Y
00:B7B9  c8           MX INY  
00:B7BA  c8           MX INY  
00:B7BB  8d e4 0e     MX STA  $0EE4
00:B7BE  b7 0c        MX LDA  [$0C],Y
00:B7C0  c8           MX INY  
00:B7C1  c8           MX INY  
00:B7C2  8d e6 0e     MX STA  $0EE6
00:B7C5  20 f2 b7     MX JSR  $B7F2
00:B7C8  c2 30        MX REP  #$30
00:B7CA  5a           MX PHY  
00:B7CB  a5 0c        MX LDA  $0C
00:B7CD  48           MX PHA  
00:B7CE  e2 30        MX SEP  #$30
00:B7D0  a5 0e        mx LDA  $0E
00:B7D2  48           mx PHA  
00:B7D3  20 fb b9     mx JSR  $B9FB
00:B7D6  e2 30        mx SEP  #$30
00:B7D8  68           mx PLA  
00:B7D9  e2 30        mx SEP  #$30
00:B7DB  85 0e        mx STA  $0E
00:B7DD  c2 30        mx REP  #$30
00:B7DF  68           MX PLA  
00:B7E0  85 0c        MX STA  $0C
00:B7E2  64 06        MX STZ  $06
00:B7E4  7a           MX PLY  
00:B7E5  c2 30        MX REP  #$30
00:B7E7  b7 0c        MX LDA  [$0C],Y
00:B7E9  c9 ff ff     MX CMP  #$FFFF
00:B7EC  f0 03        MX BEQ  $B7F1
00:B7EE  4c b7 b7     MX JMP  $B7B7

L_00B7F1:   ; xref 00B7EC
00:B7F1  60           MX RTS  

L_00B7F2:   ; xref 00B7C5
00:B7F2  c2 30        MX REP  #$30

L_00B7F4:   ; xref 00B805
00:B7F4  b7 0c        MX LDA  [$0C],Y
00:B7F6  c8           MX INY  
00:B7F7  c8           MX INY  
00:B7F8  c9 ff ff     MX CMP  #$FFFF
00:B7FB  f0 0b        MX BEQ  $B808
00:B7FD  20 09 b8     MX JSR  $B809
00:B800  c2 30        MX REP  #$30
00:B802  ee e4 0e     MX INC  $0EE4
00:B805  4c f4 b7     MX JMP  $B7F4

L_00B808:   ; xref 00B7FB
00:B808  60           MX RTS  

L_00B809:   ; xref 00B7FD
00:B809  08           MX PHP  
00:B80A  c2 30        MX REP  #$30
00:B80C  48           MX PHA  
00:B80D  20 e8 b8     MX JSR  $B8E8
00:B810  c2 30        MX REP  #$30
00:B812  68           MX PLA  
00:B813  48           MX PHA  
00:B814  4a           MX LSR  
00:B815  4a           MX LSR  
00:B816  4a           MX LSR  
00:B817  4a           MX LSR  
00:B818  eb           MX XBA  
00:B819  29 00 ff     MX AND  #$FF00
00:B81C  85 00        MX STA  $00
00:B81E  68           MX PLA  
00:B81F  29 0f 00     MX AND  #$000F
00:B822  0a           MX ASL  
00:B823  0a           MX ASL  
00:B824  0a           MX ASL  
00:B825  0a           MX ASL  
00:B826  18           MX CLC  
00:B827  65 00        MX ADC  $00
00:B829  18           MX CLC  
00:B82A  69 00 80     MX ADC  #$8000
00:B82D  85 12        MX STA  $12
00:B82F  e2 20        MX SEP  #$20
00:B831  a9 83        mX LDA  #$83
00:B833  69 00        mX ADC  #$00
00:B835  85 0b        mX STA  $0B
00:B837  c2 30        mX REP  #$30
00:B839  a5 12        MX LDA  $12
00:B83B  c9 00 80     MX CMP  #$8000
00:B83E  b0 06        MX BCS  $B846
00:B840  18           MX CLC  
00:B841  69 00 80     MX ADC  #$8000
00:B844  85 12        MX STA  $12

L_00B846:   ; xref 00B83E
00:B846  c2 30        MX REP  #$30
00:B848  a5 0f        MX LDA  $0F
00:B84A  85 03        MX STA  $03
00:B84C  a5 12        MX LDA  $12
00:B84E  85 09        MX STA  $09
00:B850  a9 08 00     MX LDA  #$0008
00:B853  85 00        MX STA  $00
00:B855  a6 06        MX LDX  $06
00:B857  20 de b9     MX JSR  $B9DE
00:B85A  8a           MX TXA  
00:B85B  85 06        MX STA  $06
00:B85D  28           MX PLP  
00:B85E  60           MX RTS  

L_00B869:   ; xref 00C6B1 00C6CC 00C5D6 00C5E1 00C5A5 00C5B0
00:B869  08           MX PHP  
00:B86A  e2 30        MX SEP  #$30
00:B86C  a9 80        mx LDA  #$80
00:B86E  85 0e        mx STA  $0E
00:B870  c2 20        mx REP  #$20
00:B872  64 06        Mx STZ  $06
00:B874  20 79 b8     Mx JSR  $B879
00:B877  28           Mx PLP  
00:B878  60           Mx RTS  

L_00B879:   ; xref 00B874
00:B879  c2 30        Mx REP  #$30
00:B87B  a0 00 00     MX LDY  #$0000

L_00B87E:   ; xref 00B8B5
00:B87E  b7 0c        MX LDA  [$0C],Y
00:B880  c8           MX INY  
00:B881  c8           MX INY  
00:B882  8d e4 0e     MX STA  $0EE4
00:B885  b7 0c        MX LDA  [$0C],Y
00:B887  c8           MX INY  
00:B888  c8           MX INY  
00:B889  8d e6 0e     MX STA  $0EE6
00:B88C  20 b9 b8     MX JSR  $B8B9
00:B88F  c2 30        MX REP  #$30
00:B891  5a           MX PHY  
00:B892  a5 0c        MX LDA  $0C
00:B894  48           MX PHA  
00:B895  e2 30        MX SEP  #$30
00:B897  a5 0e        mx LDA  $0E
00:B899  48           mx PHA  
00:B89A  20 fb b9     mx JSR  $B9FB
00:B89D  e2 30        mx SEP  #$30
00:B89F  68           mx PLA  
00:B8A0  e2 30        mx SEP  #$30
00:B8A2  85 0e        mx STA  $0E
00:B8A4  c2 30        mx REP  #$30
00:B8A6  68           MX PLA  
00:B8A7  85 0c        MX STA  $0C
00:B8A9  64 06        MX STZ  $06
00:B8AB  7a           MX PLY  
00:B8AC  c2 30        MX REP  #$30
00:B8AE  b7 0c        MX LDA  [$0C],Y
00:B8B0  c9 ff ff     MX CMP  #$FFFF
00:B8B3  f0 03        MX BEQ  $B8B8
00:B8B5  4c 7e b8     MX JMP  $B87E

L_00B8B8:   ; xref 00B8B3
00:B8B8  60           MX RTS  

L_00B8B9:   ; xref 00B88C
00:B8B9  c2 30        MX REP  #$30

L_00B8BB:   ; xref 00B8E4
00:B8BB  b7 0c        MX LDA  [$0C],Y
00:B8BD  c8           MX INY  
00:B8BE  c8           MX INY  
00:B8BF  c9 ff ff     MX CMP  #$FFFF
00:B8C2  f0 23        MX BEQ  $B8E7
00:B8C4  c9 10 00     MX CMP  #$0010
00:B8C7  b0 0a        MX BCS  $B8D3
00:B8C9  20 03 b9     MX JSR  $B903
00:B8CC  c2 30        MX REP  #$30
00:B8CE  a9 01 00     MX LDA  #$0001
00:B8D1  80 08        MX BRA  $B8DB

L_00B8D3:   ; xref 00B8C7
00:B8D3  20 71 b9     MX JSR  $B971
00:B8D6  c2 30        MX REP  #$30
00:B8D8  a9 02 00     MX LDA  #$0002

L_00B8DB:   ; xref 00B8D1
00:B8DB  c2 30        MX REP  #$30
00:B8DD  18           MX CLC  
00:B8DE  6d e4 0e     MX ADC  $0EE4
00:B8E1  8d e4 0e     MX STA  $0EE4
00:B8E4  4c bb b8     MX JMP  $B8BB

L_00B8E7:   ; xref 00B8C2
00:B8E7  60           MX RTS  

L_00B8E8:   ; xref 00B907 00B973 00B80D
00:B8E8  c2 30        MX REP  #$30
00:B8EA  ad e4 0e     MX LDA  $0EE4
00:B8ED  0a           MX ASL  
00:B8EE  0a           MX ASL  
00:B8EF  0a           MX ASL  
00:B8F0  85 00        MX STA  $00
00:B8F2  ad e6 0e     MX LDA  $0EE6
00:B8F5  eb           MX XBA  
00:B8F6  29 00 ff     MX AND  #$FF00
00:B8F9  18           MX CLC  
00:B8FA  65 00        MX ADC  $00
00:B8FC  18           MX CLC  
00:B8FD  69 00 60     MX ADC  #$6000
00:B900  85 0f        MX STA  $0F
00:B902  60           MX RTS  

L_00B903:   ; xref 00B8C9
00:B903  08           MX PHP  
00:B904  c2 30        MX REP  #$30
00:B906  48           MX PHA  
00:B907  20 e8 b8     MX JSR  $B8E8
00:B90A  c2 30        MX REP  #$30
00:B90C  68           MX PLA  
00:B90D  48           MX PHA  
00:B90E  4a           MX LSR  
00:B90F  4a           MX LSR  
00:B910  4a           MX LSR  
00:B911  4a           MX LSR  
00:B912  eb           MX XBA  
00:B913  29 00 ff     MX AND  #$FF00
00:B916  85 00        MX STA  $00
00:B918  68           MX PLA  
00:B919  29 0f 00     MX AND  #$000F
00:B91C  0a           MX ASL  
00:B91D  0a           MX ASL  
00:B91E  0a           MX ASL  
00:B91F  0a           MX ASL  
00:B920  18           MX CLC  
00:B921  65 00        MX ADC  $00
00:B923  18           MX CLC  
00:B924  69 00 80     MX ADC  #$8000
00:B927  85 12        MX STA  $12
00:B929  e2 20        MX SEP  #$20
00:B92B  a9 83        mX LDA  #$83
00:B92D  69 00        mX ADC  #$00
00:B92F  85 0b        mX STA  $0B
00:B931  c2 30        mX REP  #$30
00:B933  a5 12        MX LDA  $12
00:B935  c9 00 80     MX CMP  #$8000
00:B938  b0 06        MX BCS  $B940
00:B93A  18           MX CLC  
00:B93B  69 00 80     MX ADC  #$8000
00:B93E  85 12        MX STA  $12

L_00B940:   ; xref 00B938
00:B940  c2 30        MX REP  #$30
00:B942  a5 0f        MX LDA  $0F
00:B944  85 03        MX STA  $03
00:B946  a5 12        MX LDA  $12
00:B948  85 09        MX STA  $09
00:B94A  a9 08 00     MX LDA  #$0008
00:B94D  85 00        MX STA  $00
00:B94F  a6 06        MX LDX  $06
00:B951  20 de b9     MX JSR  $B9DE
00:B954  a5 0f        MX LDA  $0F
00:B956  18           MX CLC  
00:B957  69 00 01     MX ADC  #$0100
00:B95A  85 03        MX STA  $03
00:B95C  a5 12        MX LDA  $12
00:B95E  18           MX CLC  
00:B95F  69 00 01     MX ADC  #$0100
00:B962  85 09        MX STA  $09
00:B964  a9 08 00     MX LDA  #$0008
00:B967  85 00        MX STA  $00
00:B969  20 de b9     MX JSR  $B9DE
00:B96C  8a           MX TXA  
00:B96D  85 06        MX STA  $06
00:B96F  28           MX PLP  
00:B970  60           MX RTS  

L_00B971:   ; xref 00B8D3
00:B971  08           MX PHP  
00:B972  48           MX PHA  
00:B973  20 e8 b8     MX JSR  $B8E8
00:B976  c2 30        MX REP  #$30
00:B978  68           MX PLA  
00:B979  48           MX PHA  
00:B97A  4a           MX LSR  
00:B97B  4a           MX LSR  
00:B97C  4a           MX LSR  
00:B97D  eb           MX XBA  
00:B97E  29 00 ff     MX AND  #$FF00
00:B981  0a           MX ASL  
00:B982  85 00        MX STA  $00
00:B984  68           MX PLA  
00:B985  29 07 00     MX AND  #$0007
00:B988  0a           MX ASL  
00:B989  0a           MX ASL  
00:B98A  0a           MX ASL  
00:B98B  0a           MX ASL  
00:B98C  0a           MX ASL  
00:B98D  18           MX CLC  
00:B98E  65 00        MX ADC  $00
00:B990  18           MX CLC  
00:B991  69 00 80     MX ADC  #$8000
00:B994  85 12        MX STA  $12
00:B996  e2 20        MX SEP  #$20
00:B998  a9 83        mX LDA  #$83
00:B99A  69 00        mX ADC  #$00
00:B99C  85 0b        mX STA  $0B
00:B99E  c2 30        mX REP  #$30
00:B9A0  a5 12        MX LDA  $12
00:B9A2  c9 00 80     MX CMP  #$8000
00:B9A5  b0 06        MX BCS  $B9AD
00:B9A7  18           MX CLC  
00:B9A8  69 00 80     MX ADC  #$8000
00:B9AB  85 12        MX STA  $12

L_00B9AD:   ; xref 00B9A5
00:B9AD  c2 30        MX REP  #$30
00:B9AF  a5 0f        MX LDA  $0F
00:B9B1  85 03        MX STA  $03
00:B9B3  a5 12        MX LDA  $12
00:B9B5  85 09        MX STA  $09
00:B9B7  a9 10 00     MX LDA  #$0010
00:B9BA  85 00        MX STA  $00
00:B9BC  a6 06        MX LDX  $06
00:B9BE  20 de b9     MX JSR  $B9DE
00:B9C1  a5 0f        MX LDA  $0F
00:B9C3  18           MX CLC  
00:B9C4  69 00 01     MX ADC  #$0100
00:B9C7  85 03        MX STA  $03
00:B9C9  a5 12        MX LDA  $12
00:B9CB  18           MX CLC  
00:B9CC  69 00 01     MX ADC  #$0100
00:B9CF  85 09        MX STA  $09
00:B9D1  a9 10 00     MX LDA  #$0010
00:B9D4  85 00        MX STA  $00
00:B9D6  20 de b9     MX JSR  $B9DE
00:B9D9  8a           MX TXA  
00:B9DA  85 06        MX STA  $06
00:B9DC  28           MX PLP  
00:B9DD  60           MX RTS  

L_00B9DE:   ; xref 00B951 00B969 00B9BE 00B9D6 00B857
00:B9DE  c2 30        MX REP  #$30

L_00B9E0:   ; xref 00B9F8
00:B9E0  a5 03        MX LDA  $03
00:B9E2  9f 00 80 7f  MX STA  $7F8000,X
00:B9E6  e8           MX INX  
00:B9E7  e8           MX INX  
00:B9E8  e6 03        MX INC  $03
00:B9EA  a7 09        MX LDA  [$09]
00:B9EC  9f 00 80 7f  MX STA  $7F8000,X
00:B9F0  e8           MX INX  
00:B9F1  e8           MX INX  
00:B9F2  e6 09        MX INC  $09
00:B9F4  e6 09        MX INC  $09
00:B9F6  c6 00        MX DEC  $00
00:B9F8  d0 e6        MX BNE  $B9E0
00:B9FA  60           MX RTS  

L_00B9FB:   ; xref 00B89A 00B740 00B7D3
00:B9FB  c2 30        mx REP  #$30
00:B9FD  a5 06        MX LDA  $06
00:B9FF  d0 01        MX BNE  $BA02
00:BA01  60           MX RTS  

L_00BA02:   ; xref 00B9FF
00:BA02  c2 20        MX REP  #$20
00:BA04  a9 00 80     MX LDA  #$8000
00:BA07  85 2d        MX STA  $2D
00:BA09  a9 00 00     MX LDA  #$0000
00:BA0C  85 2f        MX STA  $2F
00:BA0E  a5 06        MX LDA  $06
00:BA10  85 31        MX STA  $31
00:BA12  e2 20        MX SEP  #$20
00:BA14  a9 7f        mX LDA  #$7F
00:BA16  85 2c        mX STA  $2C
00:BA18  a9 04        mX LDA  #$04
00:BA1A  85 29        mX STA  $29
00:BA1C  a9 80        mX LDA  #$80
00:BA1E  85 2a        mX STA  $2A
00:BA20  a9 16        mX LDA  #$16
00:BA22  85 2b        mX STA  $2B
00:BA24  20 ed 82     mX JSR  $82ED
00:BA27  20 c3 83     mX JSR  $83C3
00:BA2A  60           mX RTS  

L_00BC53:   ; xref 008194
00:BC53  20 35 b1     mx JSR  $B135
00:BC56  e2 30        mx SEP  #$30
00:BC58  a9 80        mx LDA  #$80
00:BC5A  8d a0 06     mx STA  $06A0
00:BC5D  a9 db        mx LDA  #$DB
00:BC5F  8d e0 05     mx STA  $05E0
00:BC62  a9 bc        mx LDA  #$BC
00:BC64  8d 40 09     mx STA  $0940
00:BC67  a9 fe        mx LDA  #$FE
00:BC69  8d 70 06     mx STA  $0670
00:BC6C  20 cf b1     mx JSR  $B1CF
00:BC6F  c2 30        mx REP  #$30
00:BC71  a9 05 8b     MX LDA  #$8B05
00:BC74  85 0c        MX STA  $0C
00:BC76  20 69 b8     MX JSR  $B869
00:BC79  20 78 9d     MX JSR  $9D78

L_00BC7C:   ; xref 00BC8A
00:BC7C  20 d1 82     MX JSR  $82D1
00:BC7F  e2 30        MX SEP  #$30
00:BC81  ad 70 06     mx LDA  $0670
00:BC84  c9 06        mx CMP  #$06
00:BC86  f0 04        mx BEQ  $BC8C
00:BC88  c9 05        mx CMP  #$05
00:BC8A  d0 f0        mx BNE  $BC7C

L_00BC8C:   ; xref 00BC86
00:BC8C  e2 30        mx SEP  #$30
00:BC8E  ad 40 06     mx LDA  $0640
00:BC91  8d 52 12     mx STA  $1252
00:BC94  20 7d 9d     mx JSR  $9D7D
00:BC97  e2 30        mx SEP  #$30
00:BC99  a9 04        mx LDA  #$04
00:BC9B  8d 2c 21     mx STA  $212C
00:BC9E  20 cf b1     mx JSR  $B1CF
00:BCA1  20 e3 bc     mx JSR  $BCE3
00:BCA4  20 78 9d     mx JSR  $9D78
00:BCA7  c2 30        mx REP  #$30
00:BCA9  a9 ff ff     MX LDA  #$FFFF
00:BCAC  20 eb c6     MX JSR  $C6EB
00:BCAF  20 7d 9d     MX JSR  $9D7D
00:BCB2  20 cf b1     MX JSR  $B1CF
00:BCB5  20 14 bd     MX JSR  $BD14
00:BCB8  20 78 9d     MX JSR  $9D78
00:BCBB  c2 30        MX REP  #$30
00:BCBD  a9 ff ff     MX LDA  #$FFFF
00:BCC0  20 eb c6     MX JSR  $C6EB
00:BCC3  20 7d 9d     MX JSR  $9D7D
00:BCC6  20 cf b1     MX JSR  $B1CF
00:BCC9  20 45 bd     MX JSR  $BD45
00:BCCC  20 78 9d     MX JSR  $9D78
00:BCCF  c2 30        MX REP  #$30
00:BCD1  a9 ff ff     MX LDA  #$FFFF
00:BCD4  20 eb c6     MX JSR  $C6EB
00:BCD7  20 7d 9d     MX JSR  $9D7D
00:BCDA  60           MX RTS  

L_00BCE3:   ; xref 00BCA1
00:BCE3  e2 30        mx SEP  #$30
00:BCE5  ad 52 12     mx LDA  $1252
00:BCE8  0a           mx ASL  
00:BCE9  aa           mx TAX  
00:BCEA  7c ed bc     mx JMP  ($BCED,X)

L_00BCF3:   ; xref 00BCEA
00:BCF3  c2 30        mx REP  #$30
00:BCF5  a9 89 90     MX LDA  #$9089
00:BCF8  85 0c        MX STA  $0C
00:BCFA  20 69 b8     MX JSR  $B869
00:BCFD  60           MX RTS  

L_00BCFE:   ; xref 00BCEA
00:BCFE  c2 30        mx REP  #$30
00:BD00  a9 0b 8c     MX LDA  #$8C0B
00:BD03  85 0c        MX STA  $0C
00:BD05  20 69 b8     MX JSR  $B869
00:BD08  60           MX RTS  

L_00BD09:   ; xref 00BCEA
00:BD09  c2 30        mx REP  #$30
00:BD0B  a9 95 98     MX LDA  #$9895
00:BD0E  85 0c        MX STA  $0C
00:BD10  20 a2 b7     MX JSR  $B7A2
00:BD13  60           MX RTS  

L_00BD14:   ; xref 00BCB5
00:BD14  e2 30        MX SEP  #$30
00:BD16  ad 52 12     mx LDA  $1252
00:BD19  0a           mx ASL  
00:BD1A  aa           mx TAX  
00:BD1B  7c 1e bd     mx JMP  ($BD1E,X)

L_00BD24:   ; xref 00BD1B
00:BD24  c2 30        mx REP  #$30
00:BD26  a9 23 91     MX LDA  #$9123
00:BD29  85 0c        MX STA  $0C
00:BD2B  20 69 b8     MX JSR  $B869
00:BD2E  60           MX RTS  

L_00BD2F:   ; xref 00BD1B
00:BD2F  c2 30        mx REP  #$30
00:BD31  a9 69 8d     MX LDA  #$8D69
00:BD34  85 0c        MX STA  $0C
00:BD36  20 69 b8     MX JSR  $B869
00:BD39  60           MX RTS  

L_00BD3A:   ; xref 00BD1B
00:BD3A  c2 30        mx REP  #$30
00:BD3C  a9 5d 9a     MX LDA  #$9A5D
00:BD3F  85 0c        MX STA  $0C
00:BD41  20 a2 b7     MX JSR  $B7A2
00:BD44  60           MX RTS  

L_00BD45:   ; xref 00BCC9
00:BD45  e2 30        MX SEP  #$30
00:BD47  ad 52 12     mx LDA  $1252
00:BD4A  0a           mx ASL  
00:BD4B  aa           mx TAX  
00:BD4C  7c 4f bd     mx JMP  ($BD4F,X)

L_00BD55:   ; xref 00BD4C
00:BD55  c2 30        mx REP  #$30
00:BD57  a9 33 90     MX LDA  #$9033
00:BD5A  85 0c        MX STA  $0C
00:BD5C  20 69 b8     MX JSR  $B869
00:BD5F  60           MX RTS  

L_00BD60:   ; xref 00BD4C
00:BD60  c2 30        mx REP  #$30
00:BD62  a9 a7 8b     MX LDA  #$8BA7
00:BD65  85 0c        MX STA  $0C
00:BD67  20 69 b8     MX JSR  $B869
00:BD6A  60           MX RTS  

L_00BD6B:   ; xref 00BD4C
00:BD6B  c2 30        mx REP  #$30
00:BD6D  a9 f3 97     MX LDA  #$97F3
00:BD70  85 0c        MX STA  $0C
00:BD72  20 a2 b7     MX JSR  $B7A2
00:BD75  60           MX RTS  

L_00BD76:   ; xref 008254
00:BD76  e2 30        mx SEP  #$30
00:BD78  a9 84        mx LDA  #$84
00:BD7A  85 0e        mx STA  $0E
00:BD7C  a9 80        mx LDA  #$80
00:BD7E  85 11        mx STA  $11
00:BD80  c2 20        mx REP  #$20
00:BD82  a9 25 a7     Mx LDA  #$A725
00:BD85  85 0c        Mx STA  $0C
00:BD87  a9 c0 0b     Mx LDA  #$0BC0
00:BD8A  85 0f        Mx STA  $0F
00:BD8C  20 a6 9d     Mx JSR  $9DA6
00:BD8F  e2 30        Mx SEP  #$30
00:BD91  a9 84        mx LDA  #$84
00:BD93  85 0e        mx STA  $0E
00:BD95  a9 80        mx LDA  #$80
00:BD97  85 11        mx STA  $11
00:BD99  c2 20        mx REP  #$20
00:BD9B  a9 e7 d4     Mx LDA  #$D4E7
00:BD9E  85 0c        Mx STA  $0C
00:BDA0  a9 c0 0b     Mx LDA  #$0BC0
00:BDA3  85 0f        Mx STA  $0F
00:BDA5  20 a6 9d     Mx JSR  $9DA6
00:BDA8  20 35 b1     Mx JSR  $B135
00:BDAB  20 cb bd     Mx JSR  $BDCB
00:BDAE  e2 20        Mx SEP  #$20
00:BDB0  a9 80        mx LDA  #$80
00:BDB2  85 0e        mx STA  $0E
00:BDB4  c2 20        mx REP  #$20
00:BDB6  a9 bf bd     Mx LDA  #$BDBF
00:BDB9  85 0c        Mx STA  $0C
00:BDBB  20 22 b7     Mx JSR  $B722
00:BDBE  60           Mx RTS  

L_00BDCB:   ; xref 00BDAB
00:BDCB  e2 30        Mx SEP  #$30
00:BDCD  ad 53 12     mx LDA  $1253
00:BDD0  c9 06        mx CMP  #$06
00:BDD2  90 05        mx BCC  $BDD9
00:BDD4  9c 53 12     mx STZ  $1253
00:BDD7  a9 00        mx LDA  #$00

L_00BDD9:   ; xref 00BDD2
00:BDD9  ee 53 12     mx INC  $1253
00:BDDC  0a           mx ASL  
00:BDDD  aa           mx TAX  
00:BDDE  7c e1 bd     mx JMP  ($BDE1,X)

L_00BDED:   ; xref 00BDDE
00:BDED  e2 30        mx SEP  #$30
00:BDEF  a9 88        mx LDA  #$88
00:BDF1  85 0e        mx STA  $0E
00:BDF3  a9 7f        mx LDA  #$7F
00:BDF5  85 11        mx STA  $11
00:BDF7  c2 20        mx REP  #$20
00:BDF9  a9 a4 b8     Mx LDA  #$B8A4
00:BDFC  85 0c        Mx STA  $0C
00:BDFE  a9 00 90     Mx LDA  #$9000
00:BE01  85 0f        Mx STA  $0F
00:BE03  20 a6 9d     Mx JSR  $9DA6
00:BE06  c2 20        Mx REP  #$20
00:BE08  a9 00 90     Mx LDA  #$9000
00:BE0B  85 2d        Mx STA  $2D
00:BE0D  a9 00 20     Mx LDA  #$2000
00:BE10  85 2f        Mx STA  $2F
00:BE12  a9 00 70     Mx LDA  #$7000
00:BE15  85 31        Mx STA  $31
00:BE17  e2 20        Mx SEP  #$20
00:BE19  a9 7f        mx LDA  #$7F
00:BE1B  85 2c        mx STA  $2C
00:BE1D  a9 01        mx LDA  #$01
00:BE1F  85 29        mx STA  $29
00:BE21  a9 80        mx LDA  #$80
00:BE23  85 2a        mx STA  $2A
00:BE25  a9 18        mx LDA  #$18
00:BE27  85 2b        mx STA  $2B
00:BE29  20 ed 82     mx JSR  $82ED
00:BE2C  20 b3 83     mx JSR  $83B3
00:BE2F  e2 30        mx SEP  #$30
00:BE31  a9 88        mx LDA  #$88
00:BE33  85 0e        mx STA  $0E
00:BE35  a9 80        mx LDA  #$80
00:BE37  85 11        mx STA  $11
00:BE39  c2 20        mx REP  #$20
00:BE3B  a9 80 b8     Mx LDA  #$B880
00:BE3E  85 0c        Mx STA  $0C
00:BE40  a9 e0 0b     Mx LDA  #$0BE0
00:BE43  85 0f        Mx STA  $0F
00:BE45  20 a6 9d     Mx JSR  $9DA6
00:BE48  20 b3 83     Mx JSR  $83B3
00:BE4B  60           Mx RTS  

L_00BE4C:   ; xref 00BDDE
00:BE4C  e2 30        mx SEP  #$30
00:BE4E  a9 88        mx LDA  #$88
00:BE50  85 0e        mx STA  $0E
00:BE52  a9 7f        mx LDA  #$7F
00:BE54  85 11        mx STA  $11
00:BE56  c2 20        mx REP  #$20
00:BE58  a9 a0 82     Mx LDA  #$82A0
00:BE5B  85 0c        Mx STA  $0C
00:BE5D  a9 00 90     Mx LDA  #$9000
00:BE60  85 0f        Mx STA  $0F
00:BE62  20 a6 9d     Mx JSR  $9DA6
00:BE65  c2 20        Mx REP  #$20
00:BE67  a9 00 90     Mx LDA  #$9000
00:BE6A  85 2d        Mx STA  $2D
00:BE6C  a9 00 20     Mx LDA  #$2000
00:BE6F  85 2f        Mx STA  $2F
00:BE71  a9 00 70     Mx LDA  #$7000
00:BE74  85 31        Mx STA  $31
00:BE76  e2 20        Mx SEP  #$20
00:BE78  a9 7f        mx LDA  #$7F
00:BE7A  85 2c        mx STA  $2C
00:BE7C  a9 01        mx LDA  #$01
00:BE7E  85 29        mx STA  $29
00:BE80  a9 80        mx LDA  #$80
00:BE82  85 2a        mx STA  $2A
00:BE84  a9 18        mx LDA  #$18
00:BE86  85 2b        mx STA  $2B
00:BE88  20 ed 82     mx JSR  $82ED
00:BE8B  20 b3 83     mx JSR  $83B3
00:BE8E  e2 30        mx SEP  #$30
00:BE90  a9 88        mx LDA  #$88
00:BE92  85 0e        mx STA  $0E
00:BE94  a9 80        mx LDA  #$80
00:BE96  85 11        mx STA  $11
00:BE98  c2 20        mx REP  #$20
00:BE9A  a9 7c 82     Mx LDA  #$827C
00:BE9D  85 0c        Mx STA  $0C
00:BE9F  a9 e0 0b     Mx LDA  #$0BE0
00:BEA2  85 0f        Mx STA  $0F
00:BEA4  20 a6 9d     Mx JSR  $9DA6
00:BEA7  20 b3 83     Mx JSR  $83B3
00:BEAA  60           Mx RTS  

L_00BEAB:   ; xref 00BDDE
00:BEAB  e2 30        mx SEP  #$30
00:BEAD  a9 88        mx LDA  #$88
00:BEAF  85 0e        mx STA  $0E
00:BEB1  a9 7f        mx LDA  #$7F
00:BEB3  85 11        mx STA  $11
00:BEB5  c2 20        mx REP  #$20
00:BEB7  a9 6c f3     Mx LDA  #$F36C
00:BEBA  85 0c        Mx STA  $0C
00:BEBC  a9 00 90     Mx LDA  #$9000
00:BEBF  85 0f        Mx STA  $0F
00:BEC1  20 a6 9d     Mx JSR  $9DA6
00:BEC4  c2 20        Mx REP  #$20
00:BEC6  a9 00 90     Mx LDA  #$9000
00:BEC9  85 2d        Mx STA  $2D
00:BECB  a9 00 20     Mx LDA  #$2000
00:BECE  85 2f        Mx STA  $2F
00:BED0  a9 00 70     Mx LDA  #$7000
00:BED3  85 31        Mx STA  $31
00:BED5  e2 20        Mx SEP  #$20
00:BED7  a9 7f        mx LDA  #$7F
00:BED9  85 2c        mx STA  $2C
00:BEDB  a9 01        mx LDA  #$01
00:BEDD  85 29        mx STA  $29
00:BEDF  a9 80        mx LDA  #$80
00:BEE1  85 2a        mx STA  $2A
00:BEE3  a9 18        mx LDA  #$18
00:BEE5  85 2b        mx STA  $2B
00:BEE7  20 ed 82     mx JSR  $82ED
00:BEEA  20 b3 83     mx JSR  $83B3
00:BEED  e2 30        mx SEP  #$30
00:BEEF  a9 88        mx LDA  #$88
00:BEF1  85 0e        mx STA  $0E
00:BEF3  a9 80        mx LDA  #$80
00:BEF5  85 11        mx STA  $11
00:BEF7  c2 20        mx REP  #$20
00:BEF9  a9 48 f3     Mx LDA  #$F348
00:BEFC  85 0c        Mx STA  $0C
00:BEFE  a9 e0 0b     Mx LDA  #$0BE0
00:BF01  85 0f        Mx STA  $0F
00:BF03  20 a6 9d     Mx JSR  $9DA6
00:BF06  20 b3 83     Mx JSR  $83B3
00:BF09  60           Mx RTS  

L_00BF0A:   ; xref 00BDDE
00:BF0A  e2 30        mx SEP  #$30
00:BF0C  a9 89        mx LDA  #$89
00:BF0E  85 0e        mx STA  $0E
00:BF10  a9 7f        mx LDA  #$7F
00:BF12  85 11        mx STA  $11
00:BF14  c2 20        mx REP  #$20
00:BF16  a9 00 d4     Mx LDA  #$D400
00:BF19  85 0c        Mx STA  $0C
00:BF1B  a9 00 90     Mx LDA  #$9000
00:BF1E  85 0f        Mx STA  $0F
00:BF20  20 a6 9d     Mx JSR  $9DA6
00:BF23  c2 20        Mx REP  #$20
00:BF25  a9 00 90     Mx LDA  #$9000
00:BF28  85 2d        Mx STA  $2D
00:BF2A  a9 00 20     Mx LDA  #$2000
00:BF2D  85 2f        Mx STA  $2F
00:BF2F  a9 00 70     Mx LDA  #$7000
00:BF32  85 31        Mx STA  $31
00:BF34  e2 20        Mx SEP  #$20
00:BF36  a9 7f        mx LDA  #$7F
00:BF38  85 2c        mx STA  $2C
00:BF3A  a9 01        mx LDA  #$01
00:BF3C  85 29        mx STA  $29
00:BF3E  a9 80        mx LDA  #$80
00:BF40  85 2a        mx STA  $2A
00:BF42  a9 18        mx LDA  #$18
00:BF44  85 2b        mx STA  $2B
00:BF46  20 ed 82     mx JSR  $82ED
00:BF49  20 b3 83     mx JSR  $83B3
00:BF4C  e2 30        mx SEP  #$30
00:BF4E  a9 89        mx LDA  #$89
00:BF50  85 0e        mx STA  $0E
00:BF52  a9 80        mx LDA  #$80
00:BF54  85 11        mx STA  $11
00:BF56  c2 20        mx REP  #$20
00:BF58  a9 dc d3     Mx LDA  #$D3DC
00:BF5B  85 0c        Mx STA  $0C
00:BF5D  a9 e0 0b     Mx LDA  #$0BE0
00:BF60  85 0f        Mx STA  $0F
00:BF62  20 a6 9d     Mx JSR  $9DA6
00:BF65  20 b3 83     Mx JSR  $83B3
00:BF68  60           Mx RTS  

L_00BF69:   ; xref 00BDDE
00:BF69  e2 30        mx SEP  #$30
00:BF6B  a9 8a        mx LDA  #$8A
00:BF6D  85 0e        mx STA  $0E
00:BF6F  a9 7f        mx LDA  #$7F
00:BF71  85 11        mx STA  $11
00:BF73  c2 20        mx REP  #$20
00:BF75  a9 7d a3     Mx LDA  #$A37D
00:BF78  85 0c        Mx STA  $0C
00:BF7A  a9 00 90     Mx LDA  #$9000
00:BF7D  85 0f        Mx STA  $0F
00:BF7F  20 a6 9d     Mx JSR  $9DA6
00:BF82  c2 20        Mx REP  #$20
00:BF84  a9 00 90     Mx LDA  #$9000
00:BF87  85 2d        Mx STA  $2D
00:BF89  a9 00 20     Mx LDA  #$2000
00:BF8C  85 2f        Mx STA  $2F
00:BF8E  a9 00 70     Mx LDA  #$7000
00:BF91  85 31        Mx STA  $31
00:BF93  e2 20        Mx SEP  #$20
00:BF95  a9 7f        mx LDA  #$7F
00:BF97  85 2c        mx STA  $2C
00:BF99  a9 01        mx LDA  #$01
00:BF9B  85 29        mx STA  $29
00:BF9D  a9 80        mx LDA  #$80
00:BF9F  85 2a        mx STA  $2A
00:BFA1  a9 18        mx LDA  #$18
00:BFA3  85 2b        mx STA  $2B
00:BFA5  20 ed 82     mx JSR  $82ED
00:BFA8  20 b3 83     mx JSR  $83B3
00:BFAB  e2 30        mx SEP  #$30
00:BFAD  a9 8a        mx LDA  #$8A
00:BFAF  85 0e        mx STA  $0E
00:BFB1  a9 80        mx LDA  #$80
00:BFB3  85 11        mx STA  $11
00:BFB5  c2 20        mx REP  #$20
00:BFB7  a9 59 a3     Mx LDA  #$A359
00:BFBA  85 0c        Mx STA  $0C
00:BFBC  a9 e0 0b     Mx LDA  #$0BE0
00:BFBF  85 0f        Mx STA  $0F
00:BFC1  20 a6 9d     Mx JSR  $9DA6
00:BFC4  20 b3 83     Mx JSR  $83B3
00:BFC7  60           Mx RTS  

L_00BFC8:   ; xref 00BDDE
00:BFC8  e2 30        mx SEP  #$30
00:BFCA  a9 8a        mx LDA  #$8A
00:BFCC  85 0e        mx STA  $0E
00:BFCE  a9 7f        mx LDA  #$7F
00:BFD0  85 11        mx STA  $11
00:BFD2  c2 20        mx REP  #$20
00:BFD4  a9 48 d2     Mx LDA  #$D248
00:BFD7  85 0c        Mx STA  $0C
00:BFD9  a9 00 90     Mx LDA  #$9000
00:BFDC  85 0f        Mx STA  $0F
00:BFDE  20 a6 9d     Mx JSR  $9DA6
00:BFE1  c2 20        Mx REP  #$20
00:BFE3  a9 00 90     Mx LDA  #$9000
00:BFE6  85 2d        Mx STA  $2D
00:BFE8  a9 00 20     Mx LDA  #$2000
00:BFEB  85 2f        Mx STA  $2F
00:BFED  a9 00 70     Mx LDA  #$7000
00:BFF0  85 31        Mx STA  $31
00:BFF2  e2 20        Mx SEP  #$20
00:BFF4  a9 7f        mx LDA  #$7F
00:BFF6  85 2c        mx STA  $2C
00:BFF8  a9 01        mx LDA  #$01
00:BFFA  85 29        mx STA  $29
00:BFFC  a9 80        mx LDA  #$80
00:BFFE  85 2a        mx STA  $2A
00:C000  a9 18        mx LDA  #$18
00:C002  85 2b        mx STA  $2B
00:C004  20 ed 82     mx JSR  $82ED
00:C007  20 b3 83     mx JSR  $83B3
00:C00A  e2 30        mx SEP  #$30
00:C00C  a9 8a        mx LDA  #$8A
00:C00E  85 0e        mx STA  $0E
00:C010  a9 80        mx LDA  #$80
00:C012  85 11        mx STA  $11
00:C014  c2 20        mx REP  #$20
00:C016  a9 24 d2     Mx LDA  #$D224
00:C019  85 0c        Mx STA  $0C
00:C01B  a9 e0 0b     Mx LDA  #$0BE0
00:C01E  85 0f        Mx STA  $0F
00:C020  20 a6 9d     Mx JSR  $9DA6
00:C023  20 b3 83     Mx JSR  $83B3
00:C026  60           Mx RTS  

L_00C027:   ; xref 0081CF 00C0A2 00C0BD 00C0D8 00C0EC
00:C027  20 35 b1     mx JSR  $B135
00:C02A  20 ef c0     mx JSR  $C0EF
00:C02D  20 78 9d     mx JSR  $9D78
00:C030  c2 30        mx REP  #$30
00:C032  a9 58 02     MX LDA  #$0258
00:C035  20 eb c6     MX JSR  $C6EB
00:C038  20 7d 9d     MX JSR  $9D7D
00:C03B  c2 20        MX REP  #$20
00:C03D  ad 6c 12     MX LDA  $126C
00:C040  d0 03        MX BNE  $C045
00:C042  4c 8a c0     MX JMP  $C08A

L_00C045:   ; xref 00C040
00:C045  20 93 c1     MX JSR  $C193
00:C048  20 78 9d     MX JSR  $9D78
00:C04B  c2 30        MX REP  #$30
00:C04D  a9 ff ff     MX LDA  #$FFFF
00:C050  20 eb c6     MX JSR  $C6EB
00:C053  20 7d 9d     MX JSR  $9D7D
00:C056  20 3a c2     MX JSR  $C23A
00:C059  20 78 9d     MX JSR  $9D78
00:C05C  c2 30        MX REP  #$30
00:C05E  a9 ff ff     MX LDA  #$FFFF
00:C061  20 eb c6     MX JSR  $C6EB
00:C064  20 7d 9d     MX JSR  $9D7D
00:C067  20 49 c3     MX JSR  $C349
00:C06A  20 78 9d     MX JSR  $9D78
00:C06D  c2 30        MX REP  #$30
00:C06F  a9 ff ff     MX LDA  #$FFFF
00:C072  20 eb c6     MX JSR  $C6EB
00:C075  20 7d 9d     MX JSR  $9D7D
00:C078  20 3f c4     MX JSR  $C43F
00:C07B  20 78 9d     MX JSR  $9D78
00:C07E  c2 30        MX REP  #$30
00:C080  a9 ff ff     MX LDA  #$FFFF
00:C083  20 eb c6     MX JSR  $C6EB
00:C086  20 7d 9d     MX JSR  $9D7D
00:C089  60           MX RTS  

L_00C08A:   ; xref 00C042
00:C08A  20 93 c1     MX JSR  $C193
00:C08D  20 78 9d     MX JSR  $9D78
00:C090  c2 30        MX REP  #$30
00:C092  a9 f0 00     MX LDA  #$00F0
00:C095  20 eb c6     MX JSR  $C6EB
00:C098  20 7d 9d     MX JSR  $9D7D
00:C09B  c2 20        MX REP  #$20
00:C09D  ad 6c 12     MX LDA  $126C
00:C0A0  f0 03        MX BEQ  $C0A5
00:C0A2  4c 27 c0     MX JMP  $C027

L_00C0A5:   ; xref 00C0A0
00:C0A5  20 3a c2     MX JSR  $C23A
00:C0A8  20 78 9d     MX JSR  $9D78
00:C0AB  c2 30        MX REP  #$30
00:C0AD  a9 f0 00     MX LDA  #$00F0
00:C0B0  20 eb c6     MX JSR  $C6EB
00:C0B3  20 7d 9d     MX JSR  $9D7D
00:C0B6  c2 20        MX REP  #$20
00:C0B8  ad 6c 12     MX LDA  $126C
00:C0BB  f0 03        MX BEQ  $C0C0
00:C0BD  4c 27 c0     MX JMP  $C027

L_00C0C0:   ; xref 00C0BB
00:C0C0  20 49 c3     MX JSR  $C349
00:C0C3  20 78 9d     MX JSR  $9D78
00:C0C6  c2 30        MX REP  #$30
00:C0C8  a9 f0 00     MX LDA  #$00F0
00:C0CB  20 eb c6     MX JSR  $C6EB
00:C0CE  20 7d 9d     MX JSR  $9D7D
00:C0D1  c2 20        MX REP  #$20
00:C0D3  ad 6c 12     MX LDA  $126C
00:C0D6  f0 03        MX BEQ  $C0DB
00:C0D8  4c 27 c0     MX JMP  $C027

L_00C0DB:   ; xref 00C0D6
00:C0DB  20 3f c4     MX JSR  $C43F
00:C0DE  20 78 9d     MX JSR  $9D78
00:C0E1  c2 30        MX REP  #$30
00:C0E3  a9 f0 00     MX LDA  #$00F0
00:C0E6  20 eb c6     MX JSR  $C6EB
00:C0E9  20 7d 9d     MX JSR  $9D7D
00:C0EC  4c 27 c0     MX JMP  $C027

L_00C0EF:   ; xref 00C02A
00:C0EF  c2 20        mx REP  #$20
00:C0F1  a9 00 00     Mx LDA  #$0000
00:C0F4  8f 00 80 7f  Mx STA  $7F8000
00:C0F8  c2 20        Mx REP  #$20
00:C0FA  a9 00 80     Mx LDA  #$8000
00:C0FD  85 2d        Mx STA  $2D
00:C0FF  a9 00 00     Mx LDA  #$0000
00:C102  85 2f        Mx STA  $2F
00:C104  a9 00 40     Mx LDA  #$4000
00:C107  85 31        Mx STA  $31
00:C109  e2 20        Mx SEP  #$20
00:C10B  a9 7f        mx LDA  #$7F
00:C10D  85 2c        mx STA  $2C
00:C10F  a9 09        mx LDA  #$09
00:C111  85 29        mx STA  $29
00:C113  a9 80        mx LDA  #$80
00:C115  85 2a        mx STA  $2A
00:C117  a9 18        mx LDA  #$18
00:C119  85 2b        mx STA  $2B
00:C11B  20 ed 82     mx JSR  $82ED
00:C11E  20 c3 83     mx JSR  $83C3
00:C121  e2 30        mx SEP  #$30
00:C123  a9 84        mx LDA  #$84
00:C125  85 0e        mx STA  $0E
00:C127  a9 7f        mx LDA  #$7F
00:C129  85 11        mx STA  $11
00:C12B  c2 20        mx REP  #$20
00:C12D  a9 29 a8     Mx LDA  #$A829
00:C130  85 0c        Mx STA  $0C
00:C132  a9 00 90     Mx LDA  #$9000
00:C135  85 0f        Mx STA  $0F
00:C137  20 a6 9d     Mx JSR  $9DA6
00:C13A  c2 20        Mx REP  #$20
00:C13C  a9 00 90     Mx LDA  #$9000
00:C13F  85 2d        Mx STA  $2D
00:C141  a9 00 20     Mx LDA  #$2000
00:C144  85 2f        Mx STA  $2F
00:C146  a9 00 70     Mx LDA  #$7000
00:C149  85 31        Mx STA  $31
00:C14B  e2 20        Mx SEP  #$20
00:C14D  a9 7f        mx LDA  #$7F
00:C14F  85 2c        mx STA  $2C
00:C151  a9 01        mx LDA  #$01
00:C153  85 29        mx STA  $29
00:C155  a9 80        mx LDA  #$80
00:C157  85 2a        mx STA  $2A
00:C159  a9 18        mx LDA  #$18
00:C15B  85 2b        mx STA  $2B
00:C15D  20 ed 82     mx JSR  $82ED
00:C160  20 b3 83     mx JSR  $83B3
00:C163  e2 30        mx SEP  #$30
00:C165  a9 84        mx LDA  #$84
00:C167  85 0e        mx STA  $0E
00:C169  a9 80        mx LDA  #$80
00:C16B  85 11        mx STA  $11
00:C16D  c2 20        mx REP  #$20
00:C16F  a9 83 d4     Mx LDA  #$D483
00:C172  85 0c        Mx STA  $0C
00:C174  a9 e0 0b     Mx LDA  #$0BE0
00:C177  85 0f        Mx STA  $0F
00:C179  20 a6 9d     Mx JSR  $9DA6
00:C17C  20 b3 83     Mx JSR  $83B3
00:C17F  20 cf b1     Mx JSR  $B1CF
00:C182  e2 20        Mx SEP  #$20
00:C184  a9 80        mx LDA  #$80
00:C186  85 0e        mx STA  $0E
00:C188  c2 20        mx REP  #$20
00:C18A  a9 e6 c4     Mx LDA  #$C4E6
00:C18D  85 0c        Mx STA  $0C
00:C18F  20 22 b7     Mx JSR  $B722
00:C192  60           Mx RTS  

L_00C193:   ; xref 00C08A 00C045
00:C193  c2 20        MX REP  #$20
00:C195  a9 00 00     MX LDA  #$0000
00:C198  8f 00 80 7f  MX STA  $7F8000
00:C19C  c2 20        MX REP  #$20
00:C19E  a9 00 80     MX LDA  #$8000
00:C1A1  85 2d        MX STA  $2D
00:C1A3  a9 00 00     MX LDA  #$0000
00:C1A6  85 2f        MX STA  $2F
00:C1A8  a9 00 40     MX LDA  #$4000
00:C1AB  85 31        MX STA  $31
00:C1AD  e2 20        MX SEP  #$20
00:C1AF  a9 7f        mX LDA  #$7F
00:C1B1  85 2c        mX STA  $2C
00:C1B3  a9 09        mX LDA  #$09
00:C1B5  85 29        mX STA  $29
00:C1B7  a9 80        mX LDA  #$80
00:C1B9  85 2a        mX STA  $2A
00:C1BB  a9 18        mX LDA  #$18
00:C1BD  85 2b        mX STA  $2B
00:C1BF  20 ed 82     mX JSR  $82ED
00:C1C2  20 c3 83     mX JSR  $83C3
00:C1C5  e2 30        mX SEP  #$30
00:C1C7  a9 84        mx LDA  #$84
00:C1C9  85 0e        mx STA  $0E
00:C1CB  a9 7f        mx LDA  #$7F
00:C1CD  85 11        mx STA  $11
00:C1CF  c2 20        mx REP  #$20
00:C1D1  a9 16 d5     Mx LDA  #$D516
00:C1D4  85 0c        Mx STA  $0C
00:C1D6  a9 00 90     Mx LDA  #$9000
00:C1D9  85 0f        Mx STA  $0F
00:C1DB  20 a6 9d     Mx JSR  $9DA6
00:C1DE  c2 20        Mx REP  #$20
00:C1E0  a9 00 90     Mx LDA  #$9000
00:C1E3  85 2d        Mx STA  $2D
00:C1E5  a9 00 20     Mx LDA  #$2000
00:C1E8  85 2f        Mx STA  $2F
00:C1EA  a9 00 70     Mx LDA  #$7000
00:C1ED  85 31        Mx STA  $31
00:C1EF  e2 20        Mx SEP  #$20
00:C1F1  a9 7f        mx LDA  #$7F
00:C1F3  85 2c        mx STA  $2C
00:C1F5  a9 01        mx LDA  #$01
00:C1F7  85 29        mx STA  $29
00:C1F9  a9 80        mx LDA  #$80
00:C1FB  85 2a        mx STA  $2A
00:C1FD  a9 18        mx LDA  #$18
00:C1FF  85 2b        mx STA  $2B
00:C201  20 ed 82     mx JSR  $82ED
00:C204  20 b3 83     mx JSR  $83B3
00:C207  e2 30        mx SEP  #$30
00:C209  a9 84        mx LDA  #$84
00:C20B  85 0e        mx STA  $0E
00:C20D  a9 80        mx LDA  #$80
00:C20F  85 11        mx STA  $11
00:C211  c2 20        mx REP  #$20
00:C213  a9 f3 d4     Mx LDA  #$D4F3
00:C216  85 0c        Mx STA  $0C
00:C218  a9 e0 0b     Mx LDA  #$0BE0
00:C21B  85 0f        Mx STA  $0F
00:C21D  20 a6 9d     Mx JSR  $9DA6
00:C220  20 b3 83     Mx JSR  $83B3
00:C223  20 cf b1     Mx JSR  $B1CF
00:C226  20 2c c5     Mx JSR  $C52C
00:C229  e2 20        Mx SEP  #$20
00:C22B  a9 80        mx LDA  #$80
00:C22D  85 0e        mx STA  $0E
00:C22F  c2 20        mx REP  #$20
00:C231  a9 fc c4     Mx LDA  #$C4FC
00:C234  85 0c        Mx STA  $0C
00:C236  20 22 b7     Mx JSR  $B722
00:C239  60           Mx RTS  

L_00C23A:   ; xref 00C0A5 00C056
00:C23A  e2 30        MX SEP  #$30
00:C23C  a9 86        mx LDA  #$86
00:C23E  85 0e        mx STA  $0E
00:C240  a9 7f        mx LDA  #$7F
00:C242  85 11        mx STA  $11
00:C244  c2 20        mx REP  #$20
00:C246  a9 b5 84     Mx LDA  #$84B5
00:C249  85 0c        Mx STA  $0C
00:C24B  a9 00 90     Mx LDA  #$9000
00:C24E  85 0f        Mx STA  $0F
00:C250  20 a6 9d     Mx JSR  $9DA6
00:C253  e2 30        Mx SEP  #$30
00:C255  a9 85        mx LDA  #$85
00:C257  85 0e        mx STA  $0E
00:C259  a9 7f        mx LDA  #$7F
00:C25B  85 11        mx STA  $11
00:C25D  c2 20        mx REP  #$20
00:C25F  a9 0d ad     Mx LDA  #$AD0D
00:C262  85 0c        Mx STA  $0C
00:C264  a9 00 90     Mx LDA  #$9000
00:C267  85 0f        Mx STA  $0F
00:C269  20 a6 9d     Mx JSR  $9DA6
00:C26C  c2 20        Mx REP  #$20
00:C26E  a9 00 90     Mx LDA  #$9000
00:C271  85 2d        Mx STA  $2D
00:C273  a9 00 20     Mx LDA  #$2000
00:C276  85 2f        Mx STA  $2F
00:C278  a9 00 70     Mx LDA  #$7000
00:C27B  85 31        Mx STA  $31
00:C27D  e2 20        Mx SEP  #$20
00:C27F  a9 7f        mx LDA  #$7F
00:C281  85 2c        mx STA  $2C
00:C283  a9 01        mx LDA  #$01
00:C285  85 29        mx STA  $29
00:C287  a9 80        mx LDA  #$80
00:C289  85 2a        mx STA  $2A
00:C28B  a9 18        mx LDA  #$18
00:C28D  85 2b        mx STA  $2B
00:C28F  20 ed 82     mx JSR  $82ED
00:C292  20 b3 83     mx JSR  $83B3
00:C295  e2 30        mx SEP  #$30
00:C297  a9 85        mx LDA  #$85
00:C299  85 0e        mx STA  $0E
00:C29B  a9 7f        mx LDA  #$7F
00:C29D  85 11        mx STA  $11
00:C29F  c2 20        mx REP  #$20
00:C2A1  a9 51 9a     Mx LDA  #$9A51
00:C2A4  85 0c        Mx STA  $0C
00:C2A6  a9 00 90     Mx LDA  #$9000
00:C2A9  85 0f        Mx STA  $0F
00:C2AB  20 a6 9d     Mx JSR  $9DA6
00:C2AE  c2 20        Mx REP  #$20
00:C2B0  a9 00 90     Mx LDA  #$9000
00:C2B3  85 2d        Mx STA  $2D
00:C2B5  a9 00 00     Mx LDA  #$0000
00:C2B8  85 2f        Mx STA  $2F
00:C2BA  a9 00 40     Mx LDA  #$4000
00:C2BD  85 31        Mx STA  $31
00:C2BF  e2 20        Mx SEP  #$20
00:C2C1  a9 7f        mx LDA  #$7F
00:C2C3  85 2c        mx STA  $2C
00:C2C5  a9 01        mx LDA  #$01
00:C2C7  85 29        mx STA  $29
00:C2C9  a9 80        mx LDA  #$80
00:C2CB  85 2a        mx STA  $2A
00:C2CD  a9 18        mx LDA  #$18
00:C2CF  85 2b        mx STA  $2B
00:C2D1  20 ed 82     mx JSR  $82ED
00:C2D4  20 b3 83     mx JSR  $83B3
00:C2D7  e2 30        mx SEP  #$30
00:C2D9  a9 85        mx LDA  #$85
00:C2DB  85 0e        mx STA  $0E
00:C2DD  a9 7f        mx LDA  #$7F
00:C2DF  85 11        mx STA  $11
00:C2E1  c2 20        mx REP  #$20
00:C2E3  a9 58 aa     Mx LDA  #$AA58
00:C2E6  85 0c        Mx STA  $0C
00:C2E8  a9 00 90     Mx LDA  #$9000
00:C2EB  85 0f        Mx STA  $0F
00:C2ED  20 a6 9d     Mx JSR  $9DA6
00:C2F0  c2 20        Mx REP  #$20
00:C2F2  a9 00 90     Mx LDA  #$9000
00:C2F5  85 2d        Mx STA  $2D
00:C2F7  a9 00 5c     Mx LDA  #$5C00
00:C2FA  85 2f        Mx STA  $2F
00:C2FC  a9 00 08     Mx LDA  #$0800
00:C2FF  85 31        Mx STA  $31
00:C301  e2 20        Mx SEP  #$20
00:C303  a9 7f        mx LDA  #$7F
00:C305  85 2c        mx STA  $2C
00:C307  a9 01        mx LDA  #$01
00:C309  85 29        mx STA  $29
00:C30B  a9 80        mx LDA  #$80
00:C30D  85 2a        mx STA  $2A
00:C30F  a9 18        mx LDA  #$18
00:C311  85 2b        mx STA  $2B
00:C313  20 ed 82     mx JSR  $82ED
00:C316  e2 30        mx SEP  #$30
00:C318  a9 85        mx LDA  #$85
00:C31A  85 0e        mx STA  $0E
00:C31C  a9 80        mx LDA  #$80
00:C31E  85 11        mx STA  $11
00:C320  c2 20        mx REP  #$20
00:C322  a9 ed 99     Mx LDA  #$99ED
00:C325  85 0c        Mx STA  $0C
00:C327  a9 e0 0b     Mx LDA  #$0BE0
00:C32A  85 0f        Mx STA  $0F
00:C32C  20 a6 9d     Mx JSR  $9DA6
00:C32F  20 b3 83     Mx JSR  $83B3
00:C332  20 cf b1     Mx JSR  $B1CF
00:C335  20 5d c5     Mx JSR  $C55D
00:C338  e2 20        Mx SEP  #$20
00:C33A  a9 80        mx LDA  #$80
00:C33C  85 0e        mx STA  $0E
00:C33E  c2 20        mx REP  #$20
00:C340  a9 08 c5     Mx LDA  #$C508
00:C343  85 0c        Mx STA  $0C
00:C345  20 22 b7     Mx JSR  $B722
00:C348  60           Mx RTS  

L_00C349:   ; xref 00C0C0 00C067
00:C349  e2 30        MX SEP  #$30
00:C34B  a9 86        mx LDA  #$86
00:C34D  85 0e        mx STA  $0E
00:C34F  a9 7f        mx LDA  #$7F
00:C351  85 11        mx STA  $11
00:C353  c2 20        mx REP  #$20
00:C355  a9 b5 84     Mx LDA  #$84B5
00:C358  85 0c        Mx STA  $0C
00:C35A  a9 00 90     Mx LDA  #$9000
00:C35D  85 0f        Mx STA  $0F
00:C35F  20 a6 9d     Mx JSR  $9DA6
00:C362  c2 20        Mx REP  #$20
00:C364  a9 00 90     Mx LDA  #$9000
00:C367  85 2d        Mx STA  $2D
00:C369  a9 00 20     Mx LDA  #$2000
00:C36C  85 2f        Mx STA  $2F
00:C36E  a9 00 70     Mx LDA  #$7000
00:C371  85 31        Mx STA  $31
00:C373  e2 20        Mx SEP  #$20
00:C375  a9 7f        mx LDA  #$7F
00:C377  85 2c        mx STA  $2C
00:C379  a9 01        mx LDA  #$01
00:C37B  85 29        mx STA  $29
00:C37D  a9 80        mx LDA  #$80
00:C37F  85 2a        mx STA  $2A
00:C381  a9 18        mx LDA  #$18
00:C383  85 2b        mx STA  $2B
00:C385  20 ed 82     mx JSR  $82ED
00:C388  20 b3 83     mx JSR  $83B3
00:C38B  e2 30        mx SEP  #$30
00:C38D  a9 85        mx LDA  #$85
00:C38F  85 0e        mx STA  $0E
00:C391  a9 7f        mx LDA  #$7F
00:C393  85 11        mx STA  $11
00:C395  c2 20        mx REP  #$20
00:C397  a9 ed ec     Mx LDA  #$ECED
00:C39A  85 0c        Mx STA  $0C
00:C39C  a9 00 90     Mx LDA  #$9000
00:C39F  85 0f        Mx STA  $0F
00:C3A1  20 a6 9d     Mx JSR  $9DA6
00:C3A4  c2 20        Mx REP  #$20
00:C3A6  a9 00 90     Mx LDA  #$9000
00:C3A9  85 2d        Mx STA  $2D
00:C3AB  a9 00 00     Mx LDA  #$0000
00:C3AE  85 2f        Mx STA  $2F
00:C3B0  a9 00 40     Mx LDA  #$4000
00:C3B3  85 31        Mx STA  $31
00:C3B5  e2 20        Mx SEP  #$20
00:C3B7  a9 7f        mx LDA  #$7F
00:C3B9  85 2c        mx STA  $2C
00:C3BB  a9 01        mx LDA  #$01
00:C3BD  85 29        mx STA  $29
00:C3BF  a9 80        mx LDA  #$80
00:C3C1  85 2a        mx STA  $2A
00:C3C3  a9 18        mx LDA  #$18
00:C3C5  85 2b        mx STA  $2B
00:C3C7  20 ed 82     mx JSR  $82ED
00:C3CA  20 b3 83     mx JSR  $83B3
00:C3CD  e2 30        mx SEP  #$30
00:C3CF  a9 86        mx LDA  #$86
00:C3D1  85 0e        mx STA  $0E
00:C3D3  a9 7f        mx LDA  #$7F
00:C3D5  85 11        mx STA  $11
00:C3D7  c2 20        mx REP  #$20
00:C3D9  a9 89 82     Mx LDA  #$8289
00:C3DC  85 0c        Mx STA  $0C
00:C3DE  a9 00 90     Mx LDA  #$9000
00:C3E1  85 0f        Mx STA  $0F
00:C3E3  20 a6 9d     Mx JSR  $9DA6
00:C3E6  c2 20        Mx REP  #$20
00:C3E8  a9 00 90     Mx LDA  #$9000
00:C3EB  85 2d        Mx STA  $2D
00:C3ED  a9 00 5c     Mx LDA  #$5C00
00:C3F0  85 2f        Mx STA  $2F
00:C3F2  a9 00 08     Mx LDA  #$0800
00:C3F5  85 31        Mx STA  $31
00:C3F7  e2 20        Mx SEP  #$20
00:C3F9  a9 7f        mx LDA  #$7F
00:C3FB  85 2c        mx STA  $2C
00:C3FD  a9 01        mx LDA  #$01
00:C3FF  85 29        mx STA  $29
00:C401  a9 80        mx LDA  #$80
00:C403  85 2a        mx STA  $2A
00:C405  a9 18        mx LDA  #$18
00:C407  85 2b        mx STA  $2B
00:C409  20 ed 82     mx JSR  $82ED
00:C40C  e2 30        mx SEP  #$30
00:C40E  a9 85        mx LDA  #$85
00:C410  85 0e        mx STA  $0E
00:C412  a9 80        mx LDA  #$80
00:C414  85 11        mx STA  $11
00:C416  c2 20        mx REP  #$20
00:C418  a9 a9 ec     Mx LDA  #$ECA9
00:C41B  85 0c        Mx STA  $0C
00:C41D  a9 e0 0b     Mx LDA  #$0BE0
00:C420  85 0f        Mx STA  $0F
00:C422  20 a6 9d     Mx JSR  $9DA6
00:C425  20 b3 83     Mx JSR  $83B3
00:C428  20 cf b1     Mx JSR  $B1CF
00:C42B  20 8e c5     Mx JSR  $C58E
00:C42E  e2 20        Mx SEP  #$20
00:C430  a9 80        mx LDA  #$80
00:C432  85 0e        mx STA  $0E
00:C434  c2 20        mx REP  #$20
00:C436  a9 14 c5     Mx LDA  #$C514
00:C439  85 0c        Mx STA  $0C
00:C43B  20 22 b7     Mx JSR  $B722
00:C43E  60           Mx RTS  

L_00C43F:   ; xref 00C0DB 00C078
00:C43F  c2 20        MX REP  #$20
00:C441  a9 00 00     MX LDA  #$0000
00:C444  8f 00 80 7f  MX STA  $7F8000
00:C448  c2 20        MX REP  #$20
00:C44A  a9 00 80     MX LDA  #$8000
00:C44D  85 2d        MX STA  $2D
00:C44F  a9 00 00     MX LDA  #$0000
00:C452  85 2f        MX STA  $2F
00:C454  a9 00 40     MX LDA  #$4000
00:C457  85 31        MX STA  $31
00:C459  e2 20        MX SEP  #$20
00:C45B  a9 7f        mX LDA  #$7F
00:C45D  85 2c        mX STA  $2C
00:C45F  a9 09        mX LDA  #$09
00:C461  85 29        mX STA  $29
00:C463  a9 80        mX LDA  #$80
00:C465  85 2a        mX STA  $2A
00:C467  a9 18        mX LDA  #$18
00:C469  85 2b        mX STA  $2B
00:C46B  20 ed 82     mX JSR  $82ED
00:C46E  20 c3 83     mX JSR  $83C3
00:C471  e2 30        mX SEP  #$30
00:C473  a9 86        mx LDA  #$86
00:C475  85 0e        mx STA  $0E
00:C477  a9 7f        mx LDA  #$7F
00:C479  85 11        mx STA  $11
00:C47B  c2 20        mx REP  #$20
00:C47D  a9 82 cb     Mx LDA  #$CB82
00:C480  85 0c        Mx STA  $0C
00:C482  a9 00 90     Mx LDA  #$9000
00:C485  85 0f        Mx STA  $0F
00:C487  20 a6 9d     Mx JSR  $9DA6
00:C48A  c2 20        Mx REP  #$20
00:C48C  a9 00 90     Mx LDA  #$9000
00:C48F  85 2d        Mx STA  $2D
00:C491  a9 00 20     Mx LDA  #$2000
00:C494  85 2f        Mx STA  $2F
00:C496  a9 00 70     Mx LDA  #$7000
00:C499  85 31        Mx STA  $31
00:C49B  e2 20        Mx SEP  #$20
00:C49D  a9 7f        mx LDA  #$7F
00:C49F  85 2c        mx STA  $2C
00:C4A1  a9 01        mx LDA  #$01
00:C4A3  85 29        mx STA  $29
00:C4A5  a9 80        mx LDA  #$80
00:C4A7  85 2a        mx STA  $2A
00:C4A9  a9 18        mx LDA  #$18
00:C4AB  85 2b        mx STA  $2B
00:C4AD  20 ed 82     mx JSR  $82ED
00:C4B0  20 b3 83     mx JSR  $83B3
00:C4B3  e2 30        mx SEP  #$30
00:C4B5  a9 86        mx LDA  #$86
00:C4B7  85 0e        mx STA  $0E
00:C4B9  a9 80        mx LDA  #$80
00:C4BB  85 11        mx STA  $11
00:C4BD  c2 20        mx REP  #$20
00:C4BF  a9 5e cb     Mx LDA  #$CB5E
00:C4C2  85 0c        Mx STA  $0C
00:C4C4  a9 e0 0b     Mx LDA  #$0BE0
00:C4C7  85 0f        Mx STA  $0F
00:C4C9  20 a6 9d     Mx JSR  $9DA6
00:C4CC  20 b3 83     Mx JSR  $83B3
00:C4CF  20 cf b1     Mx JSR  $B1CF
00:C4D2  20 bf c5     Mx JSR  $C5BF
00:C4D5  e2 20        Mx SEP  #$20
00:C4D7  a9 80        mx LDA  #$80
00:C4D9  85 0e        mx STA  $0E
00:C4DB  c2 20        mx REP  #$20
00:C4DD  a9 20 c5     Mx LDA  #$C520
00:C4E0  85 0c        Mx STA  $0C
00:C4E2  20 22 b7     Mx JSR  $B722
00:C4E5  60           Mx RTS  

L_00C52C:   ; xref 00C226
00:C52C  e2 30        Mx SEP  #$30
00:C52E  ad 52 12     mx LDA  $1252
00:C531  0a           mx ASL  
00:C532  aa           mx TAX  
00:C533  7c 36 c5     mx JMP  ($C536,X)

L_00C53C:   ; xref 00C533
00:C53C  c2 30        mx REP  #$30
00:C53E  a9 a1 91     MX LDA  #$91A1
00:C541  85 0c        MX STA  $0C
00:C543  20 69 b8     MX JSR  $B869
00:C546  60           MX RTS  

L_00C547:   ; xref 00C533
00:C547  c2 30        mx REP  #$30
00:C549  a9 ab 8e     MX LDA  #$8EAB
00:C54C  85 0c        MX STA  $0C
00:C54E  20 69 b8     MX JSR  $B869
00:C551  60           MX RTS  

L_00C552:   ; xref 00C533
00:C552  c2 30        mx REP  #$30
00:C554  a9 1f 94     MX LDA  #$941F
00:C557  85 0c        MX STA  $0C
00:C559  20 a2 b7     MX JSR  $B7A2
00:C55C  60           MX RTS  

L_00C55D:   ; xref 00C335
00:C55D  e2 30        Mx SEP  #$30
00:C55F  ad 52 12     mx LDA  $1252
00:C562  0a           mx ASL  
00:C563  aa           mx TAX  
00:C564  7c 67 c5     mx JMP  ($C567,X)

L_00C56D:   ; xref 00C564
00:C56D  c2 30        mx REP  #$30
00:C56F  a9 db 91     MX LDA  #$91DB
00:C572  85 0c        MX STA  $0C
00:C574  20 69 b8     MX JSR  $B869
00:C577  60           MX RTS  

L_00C578:   ; xref 00C564
00:C578  c2 30        mx REP  #$30
00:C57A  a9 11 8f     MX LDA  #$8F11
00:C57D  85 0c        MX STA  $0C
00:C57F  20 69 b8     MX JSR  $B869
00:C582  60           MX RTS  

L_00C583:   ; xref 00C564
00:C583  c2 30        mx REP  #$30
00:C585  a9 df 94     MX LDA  #$94DF
00:C588  85 0c        MX STA  $0C
00:C58A  20 a2 b7     MX JSR  $B7A2
00:C58D  60           MX RTS  

L_00C58E:   ; xref 00C42B
00:C58E  e2 30        Mx SEP  #$30
00:C590  ad 52 12     mx LDA  $1252
00:C593  0a           mx ASL  
00:C594  aa           mx TAX  
00:C595  7c 98 c5     mx JMP  ($C598,X)

L_00C59E:   ; xref 00C595
00:C59E  c2 30        mx REP  #$30
00:C5A0  a9 3b 92     MX LDA  #$923B
00:C5A3  85 0c        MX STA  $0C
00:C5A5  20 69 b8     MX JSR  $B869
00:C5A8  60           MX RTS  

L_00C5A9:   ; xref 00C595
00:C5A9  c2 30        mx REP  #$30
00:C5AB  a9 77 8f     MX LDA  #$8F77
00:C5AE  85 0c        MX STA  $0C
00:C5B0  20 69 b8     MX JSR  $B869
00:C5B3  60           MX RTS  

L_00C5B4:   ; xref 00C595
00:C5B4  c2 30        mx REP  #$30
00:C5B6  a9 d9 95     MX LDA  #$95D9
00:C5B9  85 0c        MX STA  $0C
00:C5BB  20 a2 b7     MX JSR  $B7A2
00:C5BE  60           MX RTS  

L_00C5BF:   ; xref 00C4D2
00:C5BF  e2 30        Mx SEP  #$30
00:C5C1  ad 52 12     mx LDA  $1252
00:C5C4  0a           mx ASL  
00:C5C5  aa           mx TAX  
00:C5C6  7c c9 c5     mx JMP  ($C5C9,X)

L_00C5CF:   ; xref 00C5C6
00:C5CF  c2 30        mx REP  #$30
00:C5D1  a9 95 92     MX LDA  #$9295
00:C5D4  85 0c        MX STA  $0C
00:C5D6  20 69 b8     MX JSR  $B869
00:C5D9  60           MX RTS  

L_00C5DA:   ; xref 00C5C6
00:C5DA  c2 20        mx REP  #$20
00:C5DC  a9 d5 8f     Mx LDA  #$8FD5
00:C5DF  85 0c        Mx STA  $0C
00:C5E1  20 69 b8     Mx JSR  $B869
00:C5E4  60           Mx RTS  

L_00C5E5:   ; xref 00C5C6
00:C5E5  c2 20        mx REP  #$20
00:C5E7  a9 bb 96     Mx LDA  #$96BB
00:C5EA  85 0c        Mx STA  $0C
00:C5EC  20 a2 b7     Mx JSR  $B7A2
00:C5EF  60           Mx RTS  

L_00C5F0:   ; xref 0082C7
00:C5F0  20 35 b1     mx JSR  $B135
00:C5F3  c2 20        mx REP  #$20
00:C5F5  a9 00 00     Mx LDA  #$0000
00:C5F8  8f 00 80 7f  Mx STA  $7F8000
00:C5FC  c2 20        Mx REP  #$20
00:C5FE  a9 00 80     Mx LDA  #$8000
00:C601  85 2d        Mx STA  $2D
00:C603  a9 00 00     Mx LDA  #$0000
00:C606  85 2f        Mx STA  $2F
00:C608  a9 00 40     Mx LDA  #$4000
00:C60B  85 31        Mx STA  $31
00:C60D  e2 20        Mx SEP  #$20
00:C60F  a9 7f        mx LDA  #$7F
00:C611  85 2c        mx STA  $2C
00:C613  a9 09        mx LDA  #$09
00:C615  85 29        mx STA  $29
00:C617  a9 80        mx LDA  #$80
00:C619  85 2a        mx STA  $2A
00:C61B  a9 18        mx LDA  #$18
00:C61D  85 2b        mx STA  $2B
00:C61F  20 ed 82     mx JSR  $82ED
00:C622  20 c3 83     mx JSR  $83C3
00:C625  e2 30        mx SEP  #$30
00:C627  a9 87        mx LDA  #$87
00:C629  85 0e        mx STA  $0E
00:C62B  a9 7f        mx LDA  #$7F
00:C62D  85 11        mx STA  $11
00:C62F  c2 20        mx REP  #$20
00:C631  a9 9a ad     Mx LDA  #$AD9A
00:C634  85 0c        Mx STA  $0C
00:C636  a9 00 90     Mx LDA  #$9000
00:C639  85 0f        Mx STA  $0F
00:C63B  20 a6 9d     Mx JSR  $9DA6
00:C63E  c2 20        Mx REP  #$20
00:C640  a9 00 90     Mx LDA  #$9000
00:C643  85 2d        Mx STA  $2D
00:C645  a9 00 20     Mx LDA  #$2000
00:C648  85 2f        Mx STA  $2F
00:C64A  a9 00 70     Mx LDA  #$7000
00:C64D  85 31        Mx STA  $31
00:C64F  e2 20        Mx SEP  #$20
00:C651  a9 7f        mx LDA  #$7F
00:C653  85 2c        mx STA  $2C
00:C655  a9 01        mx LDA  #$01
00:C657  85 29        mx STA  $29
00:C659  a9 80        mx LDA  #$80
00:C65B  85 2a        mx STA  $2A
00:C65D  a9 18        mx LDA  #$18
00:C65F  85 2b        mx STA  $2B
00:C661  20 ed 82     mx JSR  $82ED
00:C664  20 b3 83     mx JSR  $83B3
00:C667  e2 30        mx SEP  #$30
00:C669  a9 87        mx LDA  #$87
00:C66B  85 0e        mx STA  $0E
00:C66D  a9 80        mx LDA  #$80
00:C66F  85 11        mx STA  $11
00:C671  c2 20        mx REP  #$20
00:C673  a9 76 ad     Mx LDA  #$AD76
00:C676  85 0c        Mx STA  $0C
00:C678  a9 e0 0b     Mx LDA  #$0BE0
00:C67B  85 0f        Mx STA  $0F
00:C67D  20 a6 9d     Mx JSR  $9DA6
00:C680  20 b3 83     Mx JSR  $83B3
00:C683  20 cf b1     Mx JSR  $B1CF
00:C686  e2 20        Mx SEP  #$20
00:C688  a9 80        mx LDA  #$80
00:C68A  85 0e        mx STA  $0E
00:C68C  c2 20        mx REP  #$20
00:C68E  a9 df c6     Mx LDA  #$C6DF
00:C691  85 0c        Mx STA  $0C
00:C693  20 22 b7     Mx JSR  $B722
00:C696  20 78 9d     Mx JSR  $9D78
00:C699  c2 30        Mx REP  #$30
00:C69B  a9 ff ff     MX LDA  #$FFFF
00:C69E  20 eb c6     MX JSR  $C6EB
00:C6A1  20 7d 9d     MX JSR  $9D7D
00:C6A4  20 a8 b2     MX JSR  $B2A8
00:C6A7  20 cf b1     MX JSR  $B1CF
00:C6AA  c2 30        MX REP  #$30
00:C6AC  a9 dd 92     MX LDA  #$92DD
00:C6AF  85 0c        MX STA  $0C
00:C6B1  20 69 b8     MX JSR  $B869
00:C6B4  20 78 9d     MX JSR  $9D78
00:C6B7  c2 30        MX REP  #$30
00:C6B9  a9 ff ff     MX LDA  #$FFFF
00:C6BC  20 eb c6     MX JSR  $C6EB
00:C6BF  20 7d 9d     MX JSR  $9D7D
00:C6C2  20 cf b1     MX JSR  $B1CF
00:C6C5  c2 30        MX REP  #$30
00:C6C7  a9 87 93     MX LDA  #$9387
00:C6CA  85 0c        MX STA  $0C
00:C6CC  20 69 b8     MX JSR  $B869
00:C6CF  20 78 9d     MX JSR  $9D78
00:C6D2  c2 30        MX REP  #$30
00:C6D4  a9 ff ff     MX LDA  #$FFFF
00:C6D7  20 eb c6     MX JSR  $C6EB
00:C6DA  20 7d 9d     MX JSR  $9D7D
00:C6DD  60           MX RTS  

L_00C6EB:   ; xref 00C69E 00C6BC 00C6D7 00C035 00C095 00C0B0
00:C6EB  c2 30        MX REP  #$30
00:C6ED  8d 6c 12     MX STA  $126C

L_00C6F0:   ; xref 00C704
00:C6F0  20 d1 82     MX JSR  $82D1
00:C6F3  c2 30        MX REP  #$30
00:C6F5  ad 6c 12     MX LDA  $126C
00:C6F8  c9 ff ff     MX CMP  #$FFFF
00:C6FB  f0 05        MX BEQ  $C702
00:C6FD  ce 6c 12     MX DEC  $126C
00:C700  f0 04        MX BEQ  $C706

L_00C702:   ; xref 00C6FB
00:C702  a5 b0        MX LDA  $B0
00:C704  f0 ea        MX BEQ  $C6F0

L_00C706:   ; xref 00C700
00:C706  60           MX RTS  

L_00C8C3:   ; xref 0080D7
00:C8C3  e2 30        mX SEP  #$30
00:C8C5  a9 00        mx LDA  #$00
00:C8C7  85 00        mx STA  $00
00:C8C9  a9 80        mx LDA  #$80
00:C8CB  85 01        mx STA  $01
00:C8CD  a9 8f        mx LDA  #$8F
00:C8CF  85 02        mx STA  $02
00:C8D1  20 e3 c8     mx JSR  $C8E3

L_00C8D4:   ; xref 00C8D9
00:C8D4  e2 30        mx SEP  #$30
00:C8D6  ad 40 21     mx LDA  $2140
00:C8D9  d0 f9        mx BNE  $C8D4
00:C8DB  e2 30        mx SEP  #$30
00:C8DD  a9 01        mx LDA  #$01
00:C8DF  8d 40 21     mx STA  $2140
00:C8E2  60           mx RTS  

L_00C8E3:   ; xref 00C8D1
00:C8E3  08           mx PHP  
00:C8E4  c2 30        mx REP  #$30
00:C8E6  a0 00 00     MX LDY  #$0000
00:C8E9  a9 aa bb     MX LDA  #$BBAA

L_00C8EC:   ; xref 00C8EF
00:C8EC  cd 40 21     MX CMP  $2140
00:C8EF  d0 fb        MX BNE  $C8EC
00:C8F1  e2 20        MX SEP  #$20
00:C8F3  a9 cc        mX LDA  #$CC
00:C8F5  80 26        mX BRA  $C91D

L_00C8F7:   ; xref 00C942
00:C8F7  b7 00        mX LDA  [$00],Y
00:C8F9  c8           mX INY  
00:C8FA  eb           mX XBA  
00:C8FB  a9 00        mX LDA  #$00
00:C8FD  80 0b        mX BRA  $C90A

L_00C8FF:   ; xref 00C912
00:C8FF  eb           mX XBA  
00:C900  b7 00        mX LDA  [$00],Y
00:C902  c8           mX INY  
00:C903  eb           mX XBA  

L_00C904:   ; xref 00C907
00:C904  cd 40 21     mX CMP  $2140
00:C907  d0 fb        mX BNE  $C904
00:C909  1a           mX INC  

L_00C90A:   ; xref 00C8FD
00:C90A  c2 20        mX REP  #$20
00:C90C  8d 40 21     MX STA  $2140
00:C90F  e2 20        MX SEP  #$20
00:C911  ca           mX DEX  
00:C912  d0 eb        mX BNE  $C8FF

L_00C914:   ; xref 00C917
00:C914  cd 40 21     mX CMP  $2140
00:C917  d0 fb        mX BNE  $C914

L_00C919:   ; xref 00C91B
00:C919  69 03        mX ADC  #$03
00:C91B  f0 fc        mX BEQ  $C919

L_00C91D:   ; xref 00C8F5
00:C91D  48           mX PHA  
00:C91E  c2 20        mX REP  #$20
00:C920  b7 00        MX LDA  [$00],Y
00:C922  c8           MX INY  
00:C923  c8           MX INY  
00:C924  aa           MX TAX  
00:C925  b7 00        MX LDA  [$00],Y
00:C927  c8           MX INY  
00:C928  c8           MX INY  
00:C929  8d 42 21     MX STA  $2142
00:C92C  e2 20        MX SEP  #$20
00:C92E  e0 01 00     mX CPX  #$0001
00:C931  a9 00        mX LDA  #$00
00:C933  2a           mX ROL  
00:C934  8d 41 21     mX STA  $2141
00:C937  69 7f        mX ADC  #$7F
00:C939  68           mX PLA  
00:C93A  8d 40 21     mX STA  $2140

L_00C93D:   ; xref 00C940
00:C93D  cd 40 21     mX CMP  $2140
00:C940  d0 fb        mX BNE  $C93D
00:C942  70 b3        mX BVS  $C8F7
00:C944  28           mX PLP  
00:C945  60           mX RTS  
01:8000  20 04 80     MX JSR  $8004
01:8003  6b           MX RTL  

L_018004:   ; xref 018000
01:8004  08           MX PHP  
01:8005  e2 30        MX SEP  #$30
01:8007  a5 9e        mx LDA  $9E
01:8009  29 0f        mx AND  #$0F
01:800B  f0 12        mx BEQ  $801F
01:800D  a5 9e        mx LDA  $9E
01:800F  09 0f        mx ORA  #$0F
01:8011  85 9e        mx STA  $9E

L_018013:   ; xref 01801D
01:8013  c6 9e        mx DEC  $9E
01:8015  22 bf 83 80  mx JSL  $8083BF
01:8019  a5 9e        mx LDA  $9E
01:801B  29 0f        mx AND  #$0F
01:801D  d0 f4        mx BNE  $8013

L_01801F:   ; xref 01800B
01:801F  28           mx PLP  
01:8020  60           mx RTS  
01:8021  20 25 80     MX JSR  $8025
01:8024  6b           MX RTL  

L_018025:   ; xref 018021
01:8025  08           MX PHP  
01:8026  e2 30        MX SEP  #$30
01:8028  a5 9e        mx LDA  $9E
01:802A  29 f0        mx AND  #$F0
01:802C  85 9e        mx STA  $9E

L_01802E:   ; xref 01803A
01:802E  e6 9e        mx INC  $9E
01:8030  22 bf 83 80  mx JSL  $8083BF
01:8034  a5 9e        mx LDA  $9E
01:8036  29 0f        mx AND  #$0F
01:8038  c9 0f        mx CMP  #$0F
01:803A  d0 f2        mx BNE  $802E
01:803C  28           mx PLP  
01:803D  60           mx RTS  
01:803F  20 43 80     MX JSR  $8043
01:8042  6b           MX RTL  

L_018043:   ; xref 01803F
01:8043  08           MX PHP  
01:8044  e2 30        MX SEP  #$30
01:8046  ad c4 0e     mx LDA  $0EC4
01:8049  d0 2f        mx BNE  $807A
01:804B  c2 20        mx REP  #$20
01:804D  ad 18 42     Mx LDA  $4218
01:8050  20 b5 80     Mx JSR  $80B5
01:8053  85 ae        Mx STA  $AE
01:8055  a5 b2        Mx LDA  $B2
01:8057  25 ae        Mx AND  $AE
01:8059  85 b0        Mx STA  $B0
01:805B  a5 ae        Mx LDA  $AE
01:805D  49 ff ff     Mx EOR  #$FFFF
01:8060  85 b2        Mx STA  $B2
01:8062  ad 1a 42     Mx LDA  $421A
01:8065  20 b5 80     Mx JSR  $80B5
01:8068  85 bc        Mx STA  $BC
01:806A  a5 c0        Mx LDA  $C0
01:806C  25 bc        Mx AND  $BC
01:806E  85 be        Mx STA  $BE
01:8070  a5 bc        Mx LDA  $BC
01:8072  49 ff ff     Mx EOR  #$FFFF
01:8075  85 c0        Mx STA  $C0
01:8077  20 7c 80     Mx JSR  $807C

L_01807A:   ; xref 018049
01:807A  28           Mx PLP  
01:807B  60           Mx RTS  

L_01807C:   ; xref 018077
01:807C  c2 30        Mx REP  #$30
01:807E  a5 ae        MX LDA  $AE
01:8080  c5 b6        MX CMP  $B6
01:8082  f0 09        MX BEQ  $808D
01:8084  85 b6        MX STA  $B6
01:8086  64 b8        MX STZ  $B8
01:8088  a5 b0        MX LDA  $B0
01:808A  85 b4        MX STA  $B4
01:808C  60           MX RTS  

L_01808D:   ; xref 018082
01:808D  a5 b8        MX LDA  $B8
01:808F  c9 0a 00     MX CMP  #$000A
01:8092  f0 07        MX BEQ  $809B
01:8094  e6 b8        MX INC  $B8
01:8096  a5 b0        MX LDA  $B0
01:8098  85 b4        MX STA  $B4
01:809A  60           MX RTS  

L_01809B:   ; xref 018092
01:809B  a5 b4        MX LDA  $B4
01:809D  d0 11        MX BNE  $80B0
01:809F  a5 ba        MX LDA  $BA
01:80A1  c9 02 00     MX CMP  #$0002
01:80A4  f0 03        MX BEQ  $80A9
01:80A6  e6 ba        MX INC  $BA
01:80A8  60           MX RTS  

L_0180A9:   ; xref 0180A4
01:80A9  64 ba        MX STZ  $BA
01:80AB  a5 ae        MX LDA  $AE
01:80AD  85 b4        MX STA  $B4
01:80AF  60           MX RTS  

L_0180B0:   ; xref 01809D
01:80B0  64 b4        MX STZ  $B4
01:80B2  64 ba        MX STZ  $BA
01:80B4  60           MX RTS  

L_0180B5:   ; xref 018050 018065
01:80B5  c2 20        Mx REP  #$20
01:80B7  48           Mx PHA  
01:80B8  29 00 0c     Mx AND  #$0C00
01:80BB  c9 00 0c     Mx CMP  #$0C00
01:80BE  d0 05        Mx BNE  $80C5
01:80C0  68           Mx PLA  
01:80C1  29 ff f3     Mx AND  #$F3FF
01:80C4  48           Mx PHA  

L_0180C5:   ; xref 0180BE
01:80C5  68           Mx PLA  
01:80C6  48           Mx PHA  
01:80C7  29 00 03     Mx AND  #$0300
01:80CA  c9 00 03     Mx CMP  #$0300
01:80CD  d0 05        Mx BNE  $80D4
01:80CF  68           Mx PLA  
01:80D0  29 ff fc     Mx AND  #$FCFF
01:80D3  48           Mx PHA  

L_0180D4:   ; xref 0180CD
01:80D4  68           Mx PLA  
01:80D5  60           Mx RTS  