; This file defines aliases for hardware registers, flags, etc.
;
; Aliases are written as <prefix><name>. Register example: rSomeRegister
;
; Alias Type    Prefix
; ----------    ------
; flag          f
; register      r
; value         v

IF !DEF(HARDWARE_ASM)
HARDWARE_ASM SET 1

; video
rTileDataTable8000       EQU $8000
rTileDataTable8800       EQU $8800

rTileMapData9800         EQU $9800     ; tile map data, $9800 - $9BFF
rTileMapData9C00         EQU $9C00     ; tile map data, $9C00 - $9FFF

rLCDC                    EQU $FF40     ; LCD control
fLCDDispEnable           EQU %10000000 ; enable  LCD display
fLCDDispDisable          EQU %00000000 ; disable LCD display
fLCDWinTileMapSel9C00    EQU %01000000 ; tile map data for window, $9C00 - $9FFF
fLCDWinTileMapSel9800    EQU %00000000 ; tile map data for window, $9800 - $9BFF
fLCDWinDispEnable        EQU %00100000 ; window display enabled
fLCDWinDispDisable       EQU %00000000 ; window display disabled
fLCDBgWinTileDataSel8000 EQU %00010000 ; bg + win tile addresses, $8000 - 8FFF
fLCDBgWinTileDataSel8800 EQU %00000000 ; bg + win tile addresses, $8800 - 97FF
fLCDBgTileMapDispSel9C00 EQU %00001000 ; tile map data for bg, $9C00 - $9FFF
fLCDBgTileMapDispSel9800 EQU %00000000 ; tile map data for bg, $9800 - $9BFF
fLCDSpriteSize8x16       EQU %00000100 ; object (sprite) size; 2 tiles (vert.)
fLCDSpriteSize8x8        EQU %00000000 ; object (sprite) size; 1 tile
fLCDSpriteDispEnable     EQU %00000010 ; render sprites
fLCDSpriteDispDisable    EQU %00000000 ; don't render sprites
fLCDBgWinDispPriorityOn  EQU %00000001 ; dmg: background on
fLCDBgWinDispPriorityOff EQU %00000000 ; dmg: background off (white)

rSCY                     EQU $FF42     ; LCD (background) scroll Y
rSCX                     EQU $FF43     ; LCD (background) scroll X
rLY                      EQU $FF44     ; LCD y coordinate

rBGP                     EQU $FF47     ; LCD background palette data
vBGPWhite                EQU %00
vBGPLightGray            EQU %01
vBGPDarkGray             EQU %10
vBGPBlack                EQU %11

vBGTileMapBytesPerRow    EQU 32
vBGTileMapBytesPerCol    EQU 32
vBGVisibleBytesPerRow    EQU 18
vBGVisibleBytesPerCol    EQU 20

vVBlankBegin             EQU 144       ; V-Blank begins when  LY is 144
vVBlankEnd               EQU 153       ; B-Blank ends   after LY is 153

ENDC ; HARDWARE_ASM
