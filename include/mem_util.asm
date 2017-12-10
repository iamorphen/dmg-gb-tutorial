; This file defines routines for working with memory such as memory copying,
; setting, and writing tile data. A macro to insert the required ROM header is
; also defined.

IF !DEF(MEM_UTIL_ASM)
MEM_UTIL_ASM SET 1

PUSHS
SECTION "mem_util_asm",ROMX

; Sets the ROM header. This macro does not declare the address at which it
; starts defining bytes. Thus, the caller must invoke this macro starting at
; ROM location $104 to use it properly.
set_rom_header: MACRO
  ; $104 - $133, Nintendo(c) logo
  DB $CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D
  DB $00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
  DB $BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E

  ; $134 - $142, game title, all uppercase
  DB "CHAR WRITER",0,0,0,0

  ; $143, hardware type ($80 = CGB, other = not CGB)
  DB 0

  ; $144, $145, high and low nibble of licensee code
  DB 0,0

  ; $146, DMG ($00) or SGB ($03) indicator
  DB 0

  ; $147, cartridge type
  DB 8

  ; $148, ROM size
  DB 0 ; 32 kb

  ; $149, RAM size
  DB 4 ; 128 kb

  ; $14A, region code (JP = $00, other = $01)
  DB 1

  ; $14B, licensee code
  DB $33 ; check $144, $145

  ; $14C, mask ROM version
  DB 0 ; handled by rgbfix

  ; $14D, complement check
  DB 0 ; handled by rgbfix

  ; $14E, $14F, checksum (high)(low)
  DB 0,0 ; handled by rgbfix
ENDM ; set_rom_header

; Writes byte `a` `bc` times into destination `de`.
;
; Parameters:
; l  - the value to write into the destination address
; de - destination address to write to
; bc - byte count to write
mem_set:
  inc bc
  jp mem_set.check
mem_set.loop:
  ld a, l
  ld [de], a
  inc de
mem_set.check:
  dec bc
  ld a, b
  or c
  jp nz, mem_set.loop
  ret

; Copies data from one location to another.
;
; Parameters:
; hl - source address from which data is copied
; de - destination address to which data is written
; bc - byte count to copy
mem_copy:
  inc bc
  jp mem_copy.check
mem_copy.loop:
  ld a, [hl+]
  ld [de], a
  inc de
mem_copy.check:
  dec bc
  ld a, b
  or c
  jp nz, mem_copy.loop
  ret

; Copies tile data; uses the byte representing the least significant bits as the
; byte representing the most significant bits for a tile's color numbers, giving
; all tiles the same color (hence "monochrome").
;
; Parameters:
; hl - source address from which data is copied
; de - destination address to which data is written
; bc - number of bytes to copy; note that while `bc` bytes will be read from
;      `hl`, `bc` * 2 writes will be performed starting at `de` since each tile
;      is composed of 2 bytes to represent its color information
tile_copy_monochrome:
  inc bc
  jp tile_copy_monochrome.check
tile_copy_monochrome.loop:
  ld a, [hl+]
  ld [de], a
  inc de
  ld [de], a
  inc de
tile_copy_monochrome.check:
  dec bc
  ld a, b
  or c
  jp nz, tile_copy_monochrome.loop
  ret

POPS

ENDC ; MEM_UTIL_ASM
