/*
 * Hong Kong 97 (SNES) — object system decompilation
 * Companion to hongkong97_mainloop.c. Addresses are SNES bank $80.
 *
 * ---- Object slots: 0x30 slots, struct-of-arrays, X = slot ----
 *  $0100 flags   b7 alive | b6 drawn | b5 anim finished | b4 anim loops
 *                b1 visible (EOR #2 = blink) | b0 high-priority update pass
 *  $0130 type    0..14 (table below)
 *  $0160 anim    animation id; JSL $808554 restarts it
 *  $01F0/$0790   X lo/hi      $0220/$07C0  Y lo/hi
 *  $05E0 $0610 $0640 $0670 $06A0 $06D0 $0940   per-type work vars
 *  $0700 hp
 *  $0760 hit flags from AABB test $AF67: b2 = hit by player shot, b3 = touched player
 *
 * While an update runs, $21/$22 = X and $23/$24 = Y of the current object
 * (copied in by $856D, written back after the handler returns).
 *
 * Handler table $8AC9[type] -> P.  init = P-3 (always "JMP init_body"), update = P.
 * Spawn: $9C1C(A=type, $00=x, $03=y)   $9C0A = spawn at current object's position
 *        $9BF8 / $9BF3 = same + set high-priority flag.
 *
 * ---- Globals used by gameplay ----
 *  $0EC5 shots_on_screen (max 4)      $0EC6 wave_index     $0EC7 spawnx_index
 *  $0EC8 spawn_delay                  $0ECA spawn_count    $0ECC boss_alive
 *  $0ECE boss_hurts_player            $0ED0 sidecar_y_idx  $0ED4 kills
 *  $0ED6 game_state  $0ED8 drop_idx   $0EDA gameover_delay $0EDC invincible_timer
 */

enum ObjType {
    OBJ_PLAYER        = 0,   /* $A7EB / $A7EE  Chin                                */
    OBJ_PLAYER_SHOT   = 1,   /* $A797 / $A79A                                       */
    OBJ_ENEMY_FALL    = 2,   /* $A599 / $A59C  straight faller                      */
    OBJ_ENEMY_SHOOTER = 3,   /* $A5D1 / $A5D4  homes in, fires 4 shots              */
    OBJ_ENEMY_WAVE    = 4,   /* $A6EB / $A6EE  sine wobble faller                   */
    OBJ_BOSS          = 5,   /* $A319 / $A31C  coroutine script at $A343            */
    OBJ_MENU_CURSOR   = 6,   /* $AAB1 / $AAB4  language-select cursor (not in game) */
    OBJ_DEADLY_DROP   = 7,   /* $A216 / $A219  dropped by kills, touch = death anim */
    OBJ_ITEM_INVINC   = 8,   /* $A242 / $A245  dropped by kills, 480f invincibility */
    OBJ_ENEMY_SIDE    = 9,   /* $A278 / $A27B  enters from right, HP 8, charges     */
    OBJ_ENEMY_BULLET  = 10,  /* $A2DB / $A2DE                                       */
    OBJ_KILL_FX       = 11,  /* $A1AB / $A1AE  small enemy death effect             */
    OBJ_PLAYER_DEATH  = 12,  /* $A17C / $A17F  triggers game over when anim ends   */
    OBJ_EXPLOSION     = 13,  /* $A091 / $A094  emits 24 particles                   */
    OBJ_EXPLO_PART    = 14,  /* $A15C / $A15F  one particle                         */
};

/* ===================================================================
 * 0  PLAYER                                  init $A7B4, update $A7F4
 * ================================================================= */
void player_init(int x)                                   /* $A7B4 */
{
    shots_on_screen = wave_index = spawnx_index = 0;
    spawn_delay = kills = spawn_count = 0;
    boss_alive = boss_hurts_player = sidecar_y_idx = 0;
    set_anim(x, 0x0A);  obj_flags[x] |= 0x10;
}

void player_update(int x)                                 /* $A7F4: switch(game_state) via $A7FF */
{
    switch (game_state) {
    case 0: /* $A855 normal */
        enemy_director();                                 /* $A96A */
        u8 a = player_input(x);                           /* $A873 */
        if (a == 0) a = 0x0A;
        if (a != obj_anim[x]) set_anim(x, a);
        break;
    case 1: /* $A80E game over pending */  break;
    case 2: /* $A812 invincible */
        if (invincible_timer == 0) { game_state = 0; break; }
        invincible_timer--;
        if (invincible_timer >= 60 || (invincible_timer & 0x0B) == 0)
            obj_flags[0] ^= 0x02;                         /* blink, slower near the end */
        enemy_director(); player_input(x); ...            /* falls into normal code at $A855 */
        break;
    case 3: /* $A807 dying */  cur_y = 300;  break;       /* hide player off-screen */
    }
}

u8 player_input(int x)                                    /* $A873 */
{
    if (!(joy1_held & 0xFFFF)) return 0;
    if (joy1_pressed_hi & 0x40) fire_shot();              /* Y button, $A94C */
    if (joy1_held_hi & 0x02) if (cur_x != 0x10) cur_x -= 2;   /* Left  */
    if (joy1_held_hi & 0x01) if (cur_x != 0xF0) cur_x += 2;   /* Right */
    if (joy1_held_hi & 0x08) if (cur_y != 0x28) cur_y -= 2;   /* Up    */
    if (joy1_held_hi & 0x04) if (cur_y != 0xE0) cur_y += 2;   /* Down  */
    /* anim: Left 0x02, Right 0x0C, Up 0x10, Down 0x0F, idle 0x0A   ($A883) */
}

void fire_shot(void)                                      /* $A94C */
{
    if (shots_on_screen == 4) return;
    shots_on_screen++;
    spawn(OBJ_PLAYER_SHOT, cur_x, cur_y);
}

/* ===================================================================
 * Enemy director — runs inside the player's update     $A96A
 * ================================================================= */
static const u8  spawn_x[]   = {0x0A,0x5A,0xB4,0x96,0x78,0x32,0x64,0xE6,0x3C,   /* $AA42 */
                                0xD2,0xC8,0x28,0xE6,0x5A,0x96,0xB4,0xD2,0x6E}; /* $FF end */
static const u8  wave[][2]   = {                                               /* $AA55 {delay, kind} */
    {70,0},{40,0},{20,2},{20,0},{25,1},{55,2},{ 5,0},{50,0},{20,1},{25,1},
    {60,0},{70,0},{70,0},{20,9},{60,1},{10,0},{10,0},{10,1},{40,0},{70,2},
    {25,0},{55,0},{25,1},{20,1},{70,0},{70,0},{10,0},{60,1},{20,0},{20,9} };   /* 1125 frames, loops */
static const u16 side_y[]    = {0xC8,0x40,0x80, 0xC8,0x40,0x80, 0xC8,0x40,0x80}; /* $AA2E */

void enemy_director(void)
{
    if (boss_alive) return;                               /* no spawns during boss */
    if (spawn_delay) { spawn_delay--; return; }

    if (kills >= 30) {                                    /* $A97F */
        kills = 0; spawn_count = 0;
        spawn_here(OBJ_BOSS);                             /* $9C0A */
        boss_alive = 1;
    }
    spawn_count++;

    u8 sx = spawn_x[spawnx_index];                        /* wraps on $FF */
    spawn_delay = wave[wave_index][0];
    u8 kind     = wave[wave_index][1];
    if (kind != 9)
        spawn(kind + 2, sx, 0);                           /* 0->type2, 1->type3, 2->type4 */
    else
        spawn(OBJ_ENEMY_SIDE, 0x100, side_y[sidecar_y_idx++]);   /* $AA04 */
    spawnx_index++; wave_index++;                         /* both wrap on $FF terminator */
}

/* ===================================================================
 * Enemies
 * ================================================================= */
void enemy_fall_update(void)        /* 2  $A59C */ { if (++cur_y == 0x100) free_self(); }

void enemy_shooter_update(int x)    /* 3  $A5D4 */
{
    /* $A5F7: once |player_x - x| < 8, fire OBJ_ENEMY_BULLET every 24 frames, 4 shots max */
    /* $A640: steer velocity $05E0 toward player, clamp +-$1B; $A682: speed table $A6B2 (0..2 px) */
    cur_x += steer_speed(x);
    cur_y += 2;  if (cur_y == 0x100) free_self();
}

void enemy_wave_update(int x)       /* 4  $A6EE */
{
    cur_x += sine_table_A72D[phase[x]++];                /* -1..-4 .. +1..+4, 0 = restart */
    cur_y += 2;  if (cur_y == 0x100) free_self();
}

void enemy_side_update(int x)       /* 9  $A27B   init: hp = 8 */
{
    if (abs(player_x - cur_x) < 0x18) charging[x] = 1;   /* latch */
    cur_x -= charging[x] ? 4 : 1;
    if (cur_x < 0) free_self();
}

void enemy_bullet_update(void)      /* 10 $A2DE */ { cur_y += 3; if (cur_y >= 0xE0) free_self(); }
void player_shot_update(void)       /* 1  $A79A */ { cur_y -= 4; if (cur_y < 0) { free_self(); shots_on_screen--; } }

/* ===================================================================
 * 5  BOSS — coroutine; resume address kept in $05E0/$0940,
 *    resumed every frame through JML [$000C]                  $A343..
 * ================================================================= */
void boss_script(int x)
{
    hp[x] = 32;  cur_x = 0x80;  cur_y = 0x80;              /* $A343 */
    /* intro: 30 frames blinking + COLDATA fade ($2132)                 */
    YIELD_UNTIL(--t == 0);
    t_sec = 20; t_frames = 60;  dir = 0;
    boss_hurts_player = 1;                                 /* $A3AE: touching boss now kills */
loop:                                                      /* $A3B1 */
    bob_y_from_table_A72D();                               /* $A558 */
    boss_timer_tick();     /* $A53F: every 60 frames t_sec--; at 0 -> boss_alive = 0 */
    patrol_x_between_0x30_and_0xD0();                      /* $A514 */
    if (abs(player_x - cur_x) >= 0x18) {
        if (!boss_alive) goto die;  YIELD; goto loop;
    }
    /* dive attack: wait 30f, fall with accel table $A4A5 to y=$DC,
       wait 60f, rise 1px/frame back to y=$80, then goto loop          */
    ...
die:                                                       /* $A4B9 */
    boss_hurts_player = 0;
    spawn(OBJ_EXPLOSION, cur_x, cur_y);
    /* 120 frames: sink 1px every 2 frames, blink, fade colour math, then free */
}
/* boss_alive is cleared either by 32 shot hits ($AE7E, +100 pts) or by the
 * 20-second timer ($A552, no points). Both lead to the same death sequence. */

/* ===================================================================
 * Drops and effects
 * ================================================================= */
static const u8 drop_table[40] = {                         /* $AF2F, $FF end, cycles */
    0,1,0,0,0,0,0,0,0,1, 1,0,0,0,0,2,1,0,1,0, 0,1,0,0,0,0,0,0,0,1, 1,0,2,0,0,0,1,0,1,0 };
void kill_drop(void)                                       /* $AEFC */
{
    u8 d = drop_table[drop_idx++];                         /* 0 none, 1 -> type 7, 2 -> type 8 */
    if (d) spawn(d + 6, enemy_x, enemy_y);
}

void deadly_drop_update(void)  /* 7  $A219 */ { if (++cur_y == 0xE0) free_self(); }
void item_invinc_update(void)  /* 8  $A245 */ { if (++cur_y == 0xE0) free_self(); }

void kill_fx_update(int x)     /* 11 $A1AE: when anim ends -> anim 7, blink 60f, free */ ;
void player_death_update(int x)/* 12 $A17F */
{
    if (obj_flags[x] & 0x20) {                             /* animation finished */
        free_self();
        game_state = 1;  gameover_delay = 120;             /* -> main loop exits after 2 s */
    }
}
void explosion_update(int x)   /* 13 $A094: every 2 frames spawn type 14 at offset $A0EA[n], 24 times */ ;
void explo_part_update(int x)  /* 14 $A15F: free when anim ends */ ;

/* ===================================================================
 * Collision tables
 * ================================================================= */
/* enemy vs player: kind = $AD50[type]  -> handler $AC94[kind-1]
 *   types 2,3,4,9,10 -> kind 1 $AD1A : game_state = 1, delay 0  (instant cut to game over)
 *   type 7           -> kind 2 $ACC0 : game_state = 3, spawn OBJ_PLAYER_DEATH
 *   type 8           -> kind 3 $ACF8 : game_state = 2, invincible_timer = 480, item freed
 *   type 5           -> kind 4 $AC9C : if boss_hurts_player -> game_state = 1
 *   (skipped entirely while game_state != 0)
 *
 * player shot vs enemy: kind = $AF58[type] -> handler $AE62[kind-1]
 *   types 2,3,4 -> $AEC8 : 1 hit, +5 pts, kills++, spawn OBJ_KILL_FX, drop
 *   type 9      -> $AE8D : hp 8,  +50 pts, kills++, spawn OBJ_EXPLOSION, drop
 *   type 5      -> $AE68 : hp 32, +100 pts, boss_alive = 0
 *   shot is removed by setting its Y to $FF ($AD80)                                  */
