arch n64.cpu
endian msb
output "basic.z64", create
fill 1052672

origin $00000000
base $80000000

constant rtest_failed(30)
constant fb_origin($A0100000)
constant SCREEN_X(320)
constant SCREEN_Y(240)
constant CHAR_X(8)
constant CHAR_Y(8)
constant BYTES_PER_PIXEL(4)

include "lib/n64.inc"
include "lib/header.inc"
insert "lib/bootcode.bin"

Start:
    N64_INIT()
    li rtest_failed, 0
    jal test1
      nop
    jal test2
      nop
    jal test3
      nop
    // all passed
    j Complete
      nop

Complete:
    include "lib/n64_gfx.inc"
    include "lib/printstring.inc"
    ScreenNTSC(SCREEN_X, SCREEN_Y, BPP32, fb_origin)
    bnez rtest_failed, PrintFailed
      nop
    j PrintPassed
      nop

PrintPassed:
    PrintString(fb_origin, 8, 0, FontBlack, PassedText, PassedTextLength)
    j Hang
      nop

PrintFailed:
    PrintString(fb_origin, 8, 0, FontBlack, FailedText, FailedTextLength)
    j Hang
      nop

Hang:
    j Hang
      nop

test1: // Is r0 pinned to 0?
    addi r0, r0, 0xFF
    lui r2, 0
    bne r0, r2, test1_failed
      nop
    jr ra
      nop


test1_failed:
    li rtest_failed, 1
    j Complete
      nop

test2:
    andi r2, r2, 0
    j test2_stage2
      addi r2, r2, 0xFF
      
test2_stage2:
    andi r1, r1, 0
    addi r1, r1, 0xFF
    bne r1, r2, test2_failed
      nop
    jr ra
      nop

test2_failed:
    li rtest_failed, 2
    j Complete
      nop

test3:
    andi r2, r2, 0
    beql r0, r0, test3_stage2
      addi r2, r2, 0xFF
      
test3_stage2:
    andi r1, r1, 0
    addi r1, r1, 0xFF
    bne r1, r2, test3_failed
      nop
    jr ra
      nop

test3_failed:
    li rtest_failed, 2
    j Complete
      nop

constant PassedTextLength(16)
PassedText:
    db "Passed all tests!"

constant FailedTextLength(28)
FailedText:
    db "Failed tests! Check $s8 (r30)"

align(4)
insert FontBlack, "lib/FontBlack8x8.bin"