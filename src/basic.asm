arch n64.cpu
endian msb
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
include "lib/n64_gfx.inc"
include "lib/printstring.inc"

Start:
    N64_INIT()
    li rtest_failed, 0
    jal test1
      nop
    jal test2
      nop
    jal test3
      nop
    jal test4
      nop
    jal test5
      nop
    // all passed
    j Complete
      nop

ScreenSetup:
    ScreenNTSC(SCREEN_X, SCREEN_Y, BPP32, fb_origin)
    jr ra
      nop

Complete:
    bnez rtest_failed, TestsFailed
      nop
    addi rtest_failed, r0, -1
    la r1, ScreenSetup
    jalr r1
      nop
    j PrintPassed
      nop

TestsFailed:
    jal ScreenSetup
      nop
    j PrintFailed

PrintPassed:
    PrintString(fb_origin, 8, 0, FontBlack, PassedText, PassedTextLength)
    j Hang
      nop

FailedTest:
    dw $00000000

PrintFailed:
    la r1, FailedTest
    sw rtest_failed, 0(r1)
    PrintString(fb_origin, 8, 0, FontBlack, FailedText, FailedTextLength)
    PrintValue(fb_origin, 120, 0, FontBlack, FailedTest, 3)
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
    j test3_failed // Should never end up here
      nop
      
test3_stage2:
    andi r1, r1, 0
    addi r1, r1, 0xFF
    bne r1, r2, test3_failed
      nop
    jr ra
      nop

test3_failed:
    li rtest_failed, 3
    j Complete
      nop

test4:
    li r2, 0
    bnel r0, r0, test4_stage2
      addi r2, r2, 0xFF
    bne r2, r0, test4_failed
      nop
    jr ra
      nop

test4_stage2:
    j test4_failed // Should never end up here
      nop

test4_failed:
    li rtest_failed, 4
    j Complete
      nop

test5:
    li r1, 0x80000000
    lwu r2, Uint32Max(r1)
    daddi r2, r2, 1
    beqz r2, test5_failed
      nop
    jr ra
      nop

test5_failed:
    li rtest_failed, 5
    j Complete
      nop

Uint32Max:
  dw 0xFFFFFFFF

constant PassedTextLength(16)
PassedText:
    db "Passed all tests!"

constant FailedTextLength(13)
FailedText:
    db "Failed test 0x"

align(4)
insert FontBlack, "lib/FontBlack8x8.bin"