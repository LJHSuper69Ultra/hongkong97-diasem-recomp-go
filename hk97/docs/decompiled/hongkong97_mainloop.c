/*
 * Hong Kong 97 (SNES, 512KB LoROM) — main loop decompilation
 * Hand-decompiled from 65816 disassembly of bank $80.
 * Addresses are SNES addresses; file offset for bank $80 = addr - $8000.
 *
 * ---- WRAM variables ----
 *  $0100[0x30]  obj_flags     bit7=alive, bit0=priority pass, bit5=anim done
 *  $0130[0x30]  obj_type      index into handler table $8AC9
 *  $0760[0x30]  obj_hitflags  bit2=hit by player shot, bit3=touched player
 *  $0ED6        game_state    0=play 1=GAME OVER 2=invincible 3=dying
 *  $0EDA        gameover_delay (frames before game-over screen)
 *  $0EDC        invincible_timer
 *  $124D        score_pending (points still to be added, 1 per frame)
 *  $1244..$124C score_digits[9] (ones digit first)
 *  $124E/$1250  score_x / score_y (tile position of HUD score)
 *  $1252        language (chosen at power-on: JP / CN / EN)
 *  $126C        wait_counter
 *  $AE / $B0    joy1_held / joy1_pressed (new presses this frame)
 *  $9F          nmi_frame_counter
 */

typedef unsigned char  u8;
typedef unsigned short u16;

extern u8  obj_flags[0x30], obj_type[0x30], obj_hitflags[0x30];
extern u8  game_state, score_pending, score_digits[9];
extern u16 gameover_delay, invincible_timer, score_x, score_y, wait_counter;
extern u16 joy1_held, joy1_pressed;

/* ======================================================================
 * RESET  $80:8000
 * ==================================================================== */
void reset(void)                                   /* $8000 */
{
    /* SEI; native mode; S=$1FFF; D=$0000; DB=$80 */
    init_ppu_registers_from_table();               /* $8015-$8033, table $8039 */
    MEMSEL = 1;                                    /* $806A: FastROM */
    dma_queue_reset();                             /* $82DB */
    wait_vblank();                                 /* $839C */
    sound_driver_init();                           /* $84C5 */
    objects_clear_all();                           /* $9BD1 */
    fade_level_reset();                            /* $9D82 */
    joypad_state_reset();                          /* $A064 */
    /* CLI, PPU setup, SPC700 upload ($C8C3), load common graphics */
    ...

    language_select_screen();                      /* $BC53 -> $1252 */
    for (int i = 0; i < 0x30; i++) object_free(i); /* $8199 */
    frame_end();                                   /* $81A7 */

    for (;;) {                                     /* $81AA  ---- outer loop ---- */
        title_and_story();                         /* $C027 */

        /* --- stage setup  $81D2-$8268 --- */
        decompress(0x84_8600 -> 0x7F_9000);        /* $9DA6 */
        dma_queue_add(VRAM $0000, 0x4000 bytes);   /* $82ED */
        wait_vblank();
        set_palette(0x0000, 0xD8);                 /* JSL $809BEF */
        setup_bg_mode_and_color_math();            /* $8229-$8249 */
        game_state  = 0;                           /* $824E STZ $0ED6 */
        drop_table_index = 0;                      /* $8251 STZ $0ED8 */
        load_stage_bg_and_hud();                   /* $BD76 */
        fade_in();                                 /* $9D78 -> $81:8021 */
        score_x = 12;  score_y = 1;                /* $825A */
        score_reset();                             /* $B44E */

        /* ================= MAIN GAME LOOP  $826B ================= */
        for (;;) {
            score_tick();                          /* $826B  JSR $B472 */
            frame_end();                           /* $826E  JSR $82D1 */
            collisions();                          /* $8271  JSR $ABD5 */

            if (game_state != 1)                   /* $8276 LDA $0ED6 / CMP #1 / BNE */
                continue;                          /* $8287 JMP $826B */
            if (gameover_delay == 0)               /* $827F LDA $0EDA / BEQ $828F */
                break;
            gameover_delay--;                      /* $8284 DEC $0EDA */
        }

        /* --- game over  $828F --- */
        fade_out();                                /* $9D7D -> $81:8000 */
        for (int i = 0; i < 0x30; i++) object_free(i);   /* $8294 */
        setup_bg_mode_and_color_math();            /* $82A2 */
        game_over_screen();                        /* $C5F0 */
    }                                              /* $82CA JMP $81AA */
}

/* ======================================================================
 * Frame end: input -> run objects -> wait NMI          $80:82D1
 * ==================================================================== */
void frame_end(void)
{
    read_joypads();                                /* $A076 -> $81:803F */
    run_objects();                                 /* $9CB0 */
    wait_nmi();                                    /* $83B3 */
}

void read_joypads(void)                            /* $81:8043 */
{
    if (input_locked) return;                      /* $0EC4 */
    u16 held = fix_dpad(JOY1);                     /* $4218, $81:80B5 removes L+R / U+D */
    joy1_pressed = held & prev_not_held;           /* $B0 = new presses */
    prev_not_held = ~held;
    joy1_held = held;                              /* $AE */
    /* same for JOY2 ($421A) -> $BC/$BE */
    autorepeat_update();                           /* $81:807C, 10-frame delay */
}

void run_objects(void)                             /* $9CB0 */
{
    oam_index_prev = oam_index; oam_index = 0;     /* $AB/$AC */
    for (int x = 0; x < 0x30; x++)                 /* pass 1: alive + priority */
        if ((obj_flags[x] & 0x81) == 0x81) object_update(x);   /* $9CF3 */
    for (int x = 0; x < 0x30; x++)                 /* pass 2: alive only */
        if ((obj_flags[x] & 0x81) == 0x80) object_update(x);
    oam_finalize();                                /* JSL $8084EF */
}
/* object_update dispatches through table $8AC9[obj_type]:
 *   entry-3 = init, entry = per-frame update (called via JML [$0000]).
 *   type 12 ($0C) = player death animation, update at $A17F.          */

void wait_nmi(void)                                /* $83B3 / $83C3 */
{
    nmi_wait_flag = 6;                             /* $A3 */
    while (HVBJOY & 0x80) ;                        /* $4210: leave current vblank */
    u8 f = nmi_frame_counter;                      /* $9F */
    NMITIMEN = 0x81;                               /* NMI + auto-joypad */
    while (nmi_frame_counter == f) ;               /* wait for next NMI */
}

/* ======================================================================
 * Score                                           $B44E / $B472
 * ==================================================================== */
void score_reset(void)                             /* $B44E */
{
    for (int i = 0; i < 9; i++) score_digits[i] = 0;
    score_pending = 0;
    score_draw();                                  /* $B4EE */
}

void score_tick(void)                              /* $B472 */
{
    if (score_pending == 0) return;
    score_pending--;                               /* +1 point per frame */

    /* ripple carry; each digit rolls over when it REACHES 9 (CMP #$09) */
    if (++score_digits[0] != 9) goto draw;  score_digits[0] = 0;
    if (++score_digits[1] != 9) goto draw;  score_digits[1] = 0;
    if (++score_digits[2] != 9) goto draw;  score_digits[2] = 0;
    if (++score_digits[3] != 9) goto draw;  score_digits[3] = 0;
    score_digits[3]++;          /* $B4B3: ORIGINAL BUG — INC $1247 instead of INC $1248 */
    if (score_digits[4] != 9) goto draw;    /* $1248 is never incremented here */
    score_digits[4] = 0;
    if (++score_digits[5] != 9) goto draw;  score_digits[5] = 0;
    if (++score_digits[6] != 9) goto draw;  score_digits[6] = 0;
    if (++score_digits[7] != 9) goto draw;  score_digits[7] = 0;
    score_digits[8]++;
draw:
    score_draw();                                  /* $B4EE: 9 digits -> DMA queue */
}
/* points are added by the shot-vs-enemy handlers:
 *   $AE83 +100, $AEBE +50, $AEF2 +5   (score_pending += n)               */

/* ======================================================================
 * Collisions                                      $ABD5
 * ==================================================================== */
void collisions(void)
{
    player_shots_vs_enemies();                     /* $AD5F */
    enemies_vs_player();                           /* $ABDC */
}

void enemies_vs_player(void)                       /* $ABDC */
{
    if (game_state != 0) return;                   /* $ABDE: no hits while dying/invincible */
    load_player_hitbox();                          /* slot 0: $01F0/$0220/$0490/... */
    for (int x = 1; x < 0x30; x++) {               /* $AC67 */
        if (!(obj_flags[x] & 0x80)) continue;
        u8 kind = hit_kind_table[obj_type[x]];     /* $AD50 */
        if (kind) hit_handlers[kind - 1](x);       /* JMP ($AC94,X) */
    }
}
/* hit_handlers (each first runs AABB test $AF67 -> obj_hitflags):
 *  kind 1  $AD1A  (types 2,3,4,9,10): touch -> game_state=1, delay=0    [instant game over]
 *  kind 2  $ACC0  (type 7)          : touch -> game_state=3, spawn obj $0C at player
 *                                     ($A17F later sets game_state=1, delay=120)
 *  kind 3  $ACF8  (type 8)          : touch -> game_state=2, invincible_timer=480 (item)
 *  kind 4  $AC9C  (type 5)          : only if boss flag $0ECE != 0 -> game_state=1  */

/* ======================================================================
 * Title / story                                   $C027
 * ==================================================================== */
void title_and_story(void)
{
    show_title();                                  /* $C0EF */
    fade_in();
    wait_frames_or_button(600);                    /* $C6EB(0x258) */
    fade_out();
    if (wait_counter != 0) {                       /* button pressed before timeout */
        for (page = 0; page < 4; page++) {         /* $C193,$C23A,$C349,$C43F */
            show_story_page(page);  fade_in();
            wait_frames_or_button(0xFFFF);         /* $FFFF = wait for button only */
            fade_out();
        }
        return;                                    /* -> start game */
    }
    /* attract mode: story pages auto-advance every 240 frames; any button -> title */
    ...
}

int wait_frames_or_button(u16 n)                   /* $C6EB */
{
    wait_counter = n;
    for (;;) {
        frame_end();
        if (wait_counter != 0xFFFF && --wait_counter == 0) return 0;
        if (joy1_pressed) return 1;
    }
}
