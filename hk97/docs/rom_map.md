# ROM 지도

`assets/manifest.json`을 사람이 읽기 좋게 정리한 표입니다. 주소는 원본 ROM 기준(SNES LoROM 주소)이고, `슬롯`은 그 자리에 확보된 바이트 수입니다.

한국어를 추가하면서 원작에 없던 자원이 생겼습니다(`manifest.json`에서 `"new": true`): 한글 글리프 `font/hangul.png`(`84:8600`부터 고정, 그 자리의 `game_tiles`·`game_palette`·`title`은 빌드 때 빈 곳으로 옮겨짐)와 `text/ko/*.txt`(은행 `$80`의 빈 곳). 아래 표는 원본 ROM 기준입니다.

코드가 차지하던 영역(약 12KB)은 이 표에 없습니다. 코드는 `recomp/gen.go`로 옮겨졌기 때문입니다.

| 주소 | 슬롯 | 종류 | 배치 | 파일 |
|---|---:|---|---|---|
| `80:8039` | 45 | 표(JSON) | bank80 | `engine/ppu_init.json` |
| `80:828C` | 3 | 미사용(bin) | fixed | `unused/dead_code_80828C.bin` |
| `80:82CD` | 4 | 미사용(bin) | fixed | `unused/dead_code_8082CD.bin` |
| `80:82E9` | 4 | 미사용(bin) | fixed | `unused/dead_code_8082E9.bin` |
| `80:839A` | 2 | 미사용(bin) | fixed | `unused/dead_code_80839A.bin` |
| `80:83AF` | 4 | 미사용(bin) | fixed | `unused/dead_code_8083AF.bin` |
| `80:87B6` | 4 | 표(JSON) | bank80 | `engine/oam_size_masks.json` |
| `80:8A15` | 165 | 표(JSON) | bank80 | `objects/object_types.json` |
| `80:8AE7` | 30 | 표(JSON) | bank80 | `objects/ram_animation_tables.json` |
| `80:8B05` | 162 | 텍스트 | bank80 | `text/language_select.txt` |
| `80:8BA7` | 100 | 텍스트 | bank80 | `text/jp/address.txt` |
| `80:8C0B` | 350 | 텍스트 | bank80 | `text/jp/games_wanted.txt` |
| `80:8D69` | 322 | 텍스트 | bank80 | `text/jp/dealers.txt` |
| `80:8EAB` | 102 | 텍스트 | bank80 | `text/jp/story1.txt` |
| `80:8F11` | 102 | 텍스트 | bank80 | `text/jp/story2.txt` |
| `80:8F77` | 94 | 텍스트 | bank80 | `text/jp/story3.txt` |
| `80:8FD5` | 94 | 텍스트 | bank80 | `text/jp/story4.txt` |
| `80:9033` | 86 | 텍스트 | bank80 | `text/cn/address.txt` |
| `80:9089` | 154 | 텍스트 | bank80 | `text/cn/games_wanted.txt` |
| `80:9123` | 126 | 텍스트 | bank80 | `text/cn/dealers.txt` |
| `80:91A1` | 58 | 텍스트 | bank80 | `text/cn/story1.txt` |
| `80:91DB` | 96 | 텍스트 | bank80 | `text/cn/story2.txt` |
| `80:923B` | 90 | 텍스트 | bank80 | `text/cn/story3.txt` |
| `80:9295` | 72 | 텍스트 | bank80 | `text/cn/story4.txt` |
| `80:92DD` | 170 | 텍스트 | bank80 | `text/credits1.txt` |
| `80:9387` | 152 | 텍스트 | bank80 | `text/credits2.txt` |
| `80:941F` | 192 | 텍스트 | bank80 | `text/en/story1.txt` |
| `80:94DF` | 250 | 텍스트 | bank80 | `text/en/story2.txt` |
| `80:95D9` | 226 | 텍스트 | bank80 | `text/en/story3.txt` |
| `80:96BB` | 312 | 텍스트 | bank80 | `text/en/story4.txt` |
| `80:97F3` | 162 | 텍스트 | bank80 | `text/en/address.txt` |
| `80:9895` | 456 | 텍스트 | bank80 | `text/en/games_wanted.txt` |
| `80:9A5D` | 372 | 텍스트 | bank80 | `text/en/dealers.txt` |
| `80:9BE3` | 12 | 미사용(bin) | fixed | `unused/dead_code_809BE3.bin` |
| `80:9C5B` | 20 | 미사용(bin) | fixed | `unused/dead_code_809C5B.bin` |
| `80:9C9D` | 4 | 미사용(bin) | fixed | `unused/dead_code_809C9D.bin` |
| `80:9D22` | 86 | 미사용(bin) | fixed | `unused/dead_code_809D22.bin` |
| `80:9D8D` | 25 | 미사용(bin) | fixed | `unused/dead_code_809D8D.bin` |
| `80:A03C` | 40 | 미사용(bin) | fixed | `unused/dead_code_80A03C.bin` |
| `80:A0EA` | 100 | 표(JSON) | bank80 | `objects/explosion_offsets.json` |
| `80:A4A5` | 17 | 표(JSON) | bank80 | `objects/boss_dive.json` |
| `80:A4B6` | 3 | 미사용(bin) | fixed | `unused/dead_code_80A4B6.bin` |
| `80:A6B2` | 28 | 표(JSON) | bank80 | `objects/shooter_speed.json` |
| `80:A72D` | 82 | 표(JSON) | bank80 | `objects/wobble.json` |
| `80:AA2E` | 20 | 표(JSON) | bank80 | `stage/side_enemy_y.json` |
| `80:AA42` | 19 | 표(JSON) | bank80 | `stage/spawn_x.json` |
| `80:AA55` | 61 | 표(JSON) | bank80 | `stage/waves.json` |
| `80:AD50` | 15 | 표(JSON) | bank80 | `objects/touch_kind.json` |
| `80:AF2F` | 41 | 표(JSON) | bank80 | `objects/drops.json` |
| `80:AF58` | 15 | 표(JSON) | bank80 | `objects/shot_kind.json` |
| `80:B131` | 4 | 미사용(bin) | fixed | `unused/dead_code_80B131.bin` |
| `80:B18B` | 8 | 미사용(bin) | fixed | `unused/dead_code_80B18B.bin` |
| `80:B537` | 24 | 미사용(bin) | fixed | `unused/dead_code_80B537.bin` |
| `80:B5DD` | 18 | 표(JSON) | bank80 | `hud/score_digit_positions.json` |
| `80:B5EF` | 72 | 표(JSON) | bank80 | `hud/score_digit_tiles.json` |
| `80:B637` | 235 | 미사용(bin) | fixed | `unused/data_80B637.bin` |
| `80:B79E` | 4 | 미사용(bin) | fixed | `unused/dead_code_80B79E.bin` |
| `80:B85F` | 10 | 미사용(bin) | fixed | `unused/dead_code_80B85F.bin` |
| `80:BA2B` | 552 | 미사용(bin) | fixed | `unused/dead_code_80BA2B.bin` |
| `80:BCDB` | 8 | 표(JSON) | bank80 | `menu/language_cursor.json` |
| `80:BDBF` | 12 | 표(JSON) | bank80 | `screens/layout_stage.json` |
| `80:C4E6` | 22 | 표(JSON) | bank80 | `screens/layout_title.json` |
| `80:C4FC` | 12 | 표(JSON) | bank80 | `screens/layout_story1.json` |
| `80:C508` | 12 | 표(JSON) | bank80 | `screens/layout_story2.json` |
| `80:C514` | 12 | 표(JSON) | bank80 | `screens/layout_story3.json` |
| `80:C520` | 12 | 표(JSON) | bank80 | `screens/layout_story4.json` |
| `80:C6DE` | 1 | 미사용(bin) | fixed | `unused/dead_code_80C6DE.bin` |
| `80:C6DF` | 12 | 표(JSON) | bank80 | `screens/layout_gameover.json` |
| `80:C707` | 444 | 미사용(bin) | fixed | `unused/dead_code_80C707.bin` |
| `80:FFB0` | 80 | 헤더 | fixed | `header.json` |
| `81:803E` | 1 | 미사용(bin) | fixed | `unused/dead_code_81803E.bin` |
| `82:8000` | 1949 | 스프라이트(JSON) | fixed | `sprites/animations.json` |
| `83:8000` | 34304 | 폰트(PNG) | fixed | `font/font.png` |
| `84:8600` | 8485 | 타일(PNG, 압축) | anywhere | `graphics/game_tiles.png` |
| `84:A725` | 260 | 팔레트(JSON, 압축) | anywhere | `graphics/game_palette.json` |
| `84:A829` | 11354 | 그림(PNG, 압축) | anywhere | `graphics/title.png` |
| `84:D483` | 100 | 팔레트(JSON, 압축) | anywhere | `graphics/title_palette.json` |
| `84:D4E7` | 12 | 팔레트(JSON, 압축) | anywhere | `graphics/base_palette.json` |
| `84:D4F3` | 35 | 팔레트(JSON, 압축) | anywhere | `graphics/story1_palette.json` |
| `84:D516` | 17623 | 그림(PNG, 압축) | anywhere | `graphics/story1.png` |
| `85:99ED` | 100 | 팔레트(JSON, 압축) | anywhere | `graphics/story2_palette.json` |
| `85:9A51` | 4103 | 타일(PNG, 압축) | anywhere | `graphics/story2_layer_tiles.png` |
| `85:AA58` | 693 | 타일맵(JSON, 압축) | anywhere | `graphics/story2_layer_map.json` |
| `85:AD0D` | 16284 | 그림(PNG, 압축) | anywhere | `graphics/story2.png` |
| `85:ECA9` | 68 | 팔레트(JSON, 압축) | anywhere | `graphics/story3_palette.json` |
| `85:ECED` | 5532 | 타일(PNG, 압축) | anywhere | `graphics/story3_layer_tiles.png` |
| `86:8289` | 556 | 타일맵(JSON, 압축) | anywhere | `graphics/story3_layer_map.json` |
| `86:84B5` | 18089 | 그림(PNG, 압축) | anywhere | `graphics/story3.png` |
| `86:CB5E` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/story4_palette.json` |
| `86:CB82` | 6089 | 그림(PNG, 압축) | anywhere | `graphics/story4.png` |
| `86:E34B` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/unused_palette.json` |
| `86:E36F` | 18951 | 그림(PNG, 압축) | anywhere | `graphics/unused_picture.png` |
| `87:AD76` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/gameover_palette.json` |
| `87:AD9A` | 21730 | 그림(PNG, 압축) | anywhere | `graphics/gameover.png` |
| `88:827C` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/stage2_palette.json` |
| `88:82A0` | 13792 | 그림(PNG, 압축) | anywhere | `graphics/stage2.png` |
| `88:B880` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/stage1_palette.json` |
| `88:B8A4` | 15012 | 그림(PNG, 압축) | anywhere | `graphics/stage1.png` |
| `88:F348` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/stage3_palette.json` |
| `88:F36C` | 24688 | 그림(PNG, 압축) | anywhere | `graphics/stage3.png` |
| `89:D3DC` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/stage4_palette.json` |
| `89:D400` | 20313 | 그림(PNG, 압축) | anywhere | `graphics/stage4.png` |
| `8A:A359` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/stage5_palette.json` |
| `8A:A37D` | 11943 | 그림(PNG, 압축) | anywhere | `graphics/stage5.png` |
| `8A:D224` | 36 | 팔레트(JSON, 압축) | anywhere | `graphics/stage6_palette.json` |
| `8A:D248` | 16785 | 그림(PNG, 압축) | anywhere | `graphics/stage6.png` |
| `8F:8000` | 28036 | 사운드 | fixed | `sound/spc.json` |
