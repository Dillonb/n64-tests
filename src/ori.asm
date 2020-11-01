// WARNING: This file was automatically generated from a template, do not edit by hand!
// Edit IMMEDIATE.tmpl and run generate.sh instead!
arch n64.cpu
endian msb
fill 1052672 // Ensure the file meets the minimum size for a valid N64 ROM

origin $00000000
base $80000000

constant rtest_failed(30)
constant rtemp(2)
constant ractual(3)
constant rexpected(4)
constant rtemp2(5)
constant regargpointer(6)
constant expectedpointer(7)
constant immpointer(8)
constant rtotalcases(9)
constant rtestedcases(10)
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
include "lib/immjt.inc"

Start:
    N64_INIT()
    li rtest_failed, 0
    la rtemp, RunTests
    jr rtemp
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
      nop

PrintPassed:
    PrintString(fb_origin, 8, 0, FontBlack, PassedText, PassedTextLength)
    j Hang
      nop

FailedTest:
    dw $00000000

PrintFailed:
    la rtemp, FailedTest
    sw rtest_failed, 0(rtemp)
    PrintString(fb_origin, 8, 0, FontBlack, FailedText, FailedTextLength)
    PrintValue(fb_origin, 120, 0, FontBlack, FailedTest, 3)
    j Hang
      nop

Hang:
    j Hang
      nop

constant PassedTextLength(16)
PassedText:
    db "Passed all tests!"

constant FailedTextLength(13)
FailedText:
    db "Failed test 0x"

align(4)
insert FontBlack, "lib/FontBlack8x8.bin"

base $10000000 + pc()

immjt(ori, ractual, ractual)

RunTests:
    la regargpointer, RegArgs
    la expectedpointer, Expected
    la immpointer, ImmArgs
    la rtemp, NumCases
    lw rtotalcases, 0(rtemp)
    li rtestedcases, 0
TestLoop:
    lhu rtemp, 0(immpointer)
    ld ractual, 0(regargpointer)
    ld rexpected, 0(expectedpointer)

    la rtemp2, ImmJt
    jalr rtemp2
      nop

    beq ractual, rexpected, TestSuccess
      nop

    // test index + 1
    addiu rtest_failed, rtestedcases, 1
    j Complete
      nop

TestSuccess:
    addiu immpointer, immpointer, 2
    addiu regargpointer, regargpointer, 8
    addiu expectedpointer, expectedpointer, 8
    addiu rtestedcases, rtestedcases, 1


    slt rtemp, rtestedcases, rtotalcases
    bnez rtemp, TestLoop
      nop

    // all passed
    j Complete
      nop

include "./cases/ori.inc"

print ImmArgs