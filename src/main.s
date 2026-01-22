.gba
.open ROMFILENAME,0x8000000
.include ASMDEFINITIONS

.table "data/text.tbl"

; Assembly-time flags


;FreeIWRam equ 03005630h
FreeIWRamLen equ 23D0h
FreeIWRamEnd equ FreeIWRam + FreeIWRamLen ; ends 030079FFh

.include "inc/constants.inc"
.include "inc/enums.inc"
.include "inc/functions.inc"
.include "inc/macros.inc"
.include "inc/sprite-ids.inc"
.include "inc/structs.inc"

StartingItems equ 0828D2ACh
HintTargets equ 085766ECh
Credits equ 0874B0B0h
MessageTableLookupAddr equ 0879CDF4h ; This is not the location of the table itself. The pointers, offset by language, at this location will be the table location

; Reserved space addresses/pointers. Used by the patcher to know where it should write
; data to. The first address here should be used below when defining the free
; space region for the asm to use
PatcherFreeSpace equ 087D0000h
CreditsMusicSpace equ 087F0000h ; takes up 0x14E0h
FutureReservedSpace equ 087F14E0h
FutureReservedSpace_Len equ 0DB20h

; Reserved Pointers
ReservedPatcherAddrs equ 087FF000h
.org ReservedPatcherAddrs
reserve_pointer MinorLocationTablePointer
reserve_pointer MinorLocationsPointer
reserve_pointer MajorLocationsPointer
reserve_pointer TankIncrementsPointer
reserve_pointer MetroidCountPointer
reserve_pointer StartingLocationPointer
reserve_pointer CreditsParametersPointer
reserve_pointer HintSecurityLevelsPointer
reserve_pointer EnvironmentalHazardDpsPointer
reserve_pointer MissileLimitPointer
reserve_pointer RoomNamesPointer
reserve_pointer RevealHiddenTilesFlagPointer
reserve_pointer TitleScreenTextPointersPointer
reserve_pointer DefaultStereoFlagPointer
reserve_pointer InstantMorphFlagPointer
reserve_pointer ForceExcessHealthDisplayPointer


; Mark end-of-file padding as free space
EOF equ 0879ECC8h
.defineregion EOF, PatcherFreeSpace - EOF, 0FFh
; Free up large unused audio sample
DataFreeSpace equ 080F9A28h
DataFreeSpaceLen equ 20318h
DataFreeSpaceEnd equ DataFreeSpace + DataFreeSpaceLen
.defineregion DataFreeSpace, DataFreeSpaceLen, 0FFh

; Quality of life patches
; Patches providing non-essential but convenient features

.notice "Applying quality of life patches..."
.include "src\optimization\item-check.s "
.include "src/nonlinear/common.s"
.include "src/nonlinear/room-states.s"
.include "src/qol/cross-sector-maps.s"
.include "src/qol/fast-doors.s"
.include "src/qol/fast-elevators.s"
.include "src/qol/ice-beam-volume.s"
.include "src\randomizer\tank-majors.s"
.include "src/qol/map-info.s"





.include "src/qol/unhidden-breakable-tiles.s"

.include "src/qol/unhidden-map.s"


.include "src/qol/unhidden-map-doors.s"

.include "src/qol/unhidden-pillars.s"



; Accessibility patches
; Patches which make the game more acccessible to people.

.include "src/a11y/accessible-enemy-gfx.s"
.include "src/a11y/accessible-flashing.s"
.close
