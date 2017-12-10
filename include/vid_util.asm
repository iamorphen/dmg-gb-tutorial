; This file defines routines to work with the video system, query state, etc.

IF !DEF(VID_UTIL_ASM)
VID_UTIL_ASM SET 1

PUSHS
SECTION "mem_util_asm",ROMX

; Waits for V-Blank period. V-Blank occurs when LY is in the range [144, 153].
;
; This routine only returns when LY is 144, though, to give the caller the
; largest window of time before leaving the V-Blank period.
wait_vblank_begin:
  ld a, [rLY]
  cp vVBlankBegin
  jp nz, wait_vblank_begin
  ret

POPS
ENDC ; VID_UTIL_ASM
