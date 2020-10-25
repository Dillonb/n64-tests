arch n64.cpu
endian msb
fill 1052672

origin $00000000
base $80000000

constant rtest_failed(30)
constant rtemp(2)
constant ractual(3)
constant rexpected(4)
constant fb_origin($A0100000)
constant SCREEN_X(320)
constant SCREEN_Y(240)
constant CHAR_X(8)
constant CHAR_Y(8)
constant BYTES_PER_PIXEL(4)

include "lib/n64.inc"
include "lib/header.inc"
insert "lib/bootcode.bin"

// warning: if editing this, keep the total size a multiple of 64 bits to avoid wasting space (even number of instructions)
macro scope test_addiu(regarg, immarg, expected, testnum) {
  la rtemp, {#}Values
  ld ractual, 0(rtemp)
  ld rexpected, 8(rtemp)

  addi ractual, ractual, {immarg}
  beq rexpected, ractual, {#}AfterValues
    nop
  li rtest_failed, {testnum}
  align(8)
{#}Values:
  dd {regarg}
  dd {expected}
{#}AfterValues:
}

Start:
    N64_INIT()
    li rtest_failed, 0

    test_addiu($0000000000000000, $0001, $0000000000000001, 1)
    test_addiu($00000000FFFFFFFE, $0001, $FFFFFFFFFFFFFFFF, 2)
    test_addiu($0000000000000000, $FFFF, $FFFFFFFFFFFFFFFF, 3)

    // all passed
    j Complete
      nop

Complete:
    addi rtest_failed, r0, -1
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

constant PassedTextLength(16)
PassedText:
    db "Passed all tests!"

constant FailedTextLength(28)
FailedText:
    db "Failed tests! Check $s8 (r30)"

align(4)
insert FontBlack, "lib/FontBlack8x8.bin"
