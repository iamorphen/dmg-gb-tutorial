; A simple test. Write some characters to the screen.

SECTION "DUMMY",ROM0[$00] ; dummy section to allow includes to PUSHS/POPS
INCLUDE "include/cp437.asm"
INCLUDE "include/hardware.asm"
INCLUDE "include/mem_util.asm"
INCLUDE "include/vid_util.asm"

; IRQ handlers
SECTION "RST_00",ROM0[$00]
  jp start
SECTION "RST_08",ROM0[$08]
  jp start
SECTION "RST_10",ROM0[$10]
  jp start
SECTION "RST_18",ROM0[$18]
  jp start
SECTION "RST_20",ROM0[$20]
  jp start
SECTION "RST_28",ROM0[$28]
  jp start
SECTION "RST_30",ROM0[$30]
  jp start
SECTION "RST_38",ROM0[$38]
  jp start
SECTION "RST_40",ROM0[$40]
  jp $100
SECTION "RST_48",ROM0[$48]
  jp start
SECTION "RST_50",ROM0[$50]
  jp start
SECTION "RST_58",ROM0[$58]
  jp start
SECTION "RST_60",ROM0[$60]
  jp start

SECTION "START",ROM0[$100]
start:
  nop
  jp main

  set_rom_header

test_string: ; $150 - $15B
  DB "Hello world!"

cp437:
  CP437 1,8 ; import the code page 437 character set

main:
  di

  call wait_vblank_begin

  ; turn off the display
  ld a, [rLCDC]
  res 7, a
  ld [rLCDC], a

  ; load the cp437 tiles into the tile data table
  ld hl, cp437
  ld de, rTileDataTable8000
  ld bc, 256 * 8 ; 256 tiles, 8 bytes each
  call tile_copy_monochrome

  ; set the display position to be 0, 0
  ld a, 0
  ld [rSCY], a
  ld [rSCX], a

  ; clear the background
  ld a, [rTileDataTable8000] ; the NUL character
  ld l, a
  ld de, rTileMapData9800
  ld bc, vBGTileMapBytesPerRow * vBGTileMapBytesPerCol
  call mem_set

  ; set the tiles to be displayed
  ld hl, test_string
  ld de, rTileMapData9800 + vBGTileMapBytesPerRow * 8 + 5 ; 9th row, 5th column
  ld bc, 12
  call mem_copy

  ; set the palette shades
  ld a, vBGPBlack << 6 | vBGPDarkGray << 4 | vBGPLightGray << 2 | vBGPWhite
  ld [rBGP], a

  ; re-enable LCD; usually done in two commands; expanded here for shorter lines
  ld a, 0
  or a, fLCDDispEnable | fLCDWinTileMapSel9800 | fLCDWinDispDisable
  or a, fLCDBgWinTileDataSel8000 | fLCDBgTileMapDispSel9800 | fLCDSpriteSize8x8
  or a, fLCDSpriteDispDisable | fLCDBgWinDispPriorityOn
  ld [rLCDC], a

  call spin

; Loop forever.
spin:
  nop
  jr @-1
