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

Start:
    N64_INIT()
    li rtest_failed, 0
    la rtemp, RunTests
    jr rtemp
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

macro immjt(rs, rt) {
ImmJt:
    define i(0)

    // rtemp contains the arg. load address of jump table base into rtemp2, add the
    la rtemp2, {#}JtBase
    sll rtemp, rtemp, 4 // multiply by 16
    add rtemp2, rtemp2, rtemp // and add to base of jump table

    jr rtemp2
      nop

{#}JtBase:
    while {i} <= $FFFF {
        define p(pc())
        addiu {rt}, {rs}, {i}
        jr ra
          nop
          nop
        evaluate i({i} + 1)
    }
}

constant PassedTextLength(16)
PassedText:
    db "Passed all tests!"

constant FailedTextLength(28)
FailedText:
    db "Failed tests! Check $s8 (r30)"

align(4)
insert FontBlack, "lib/FontBlack8x8.bin"

base $10000000 + pc()

immjt(ractual, ractual)

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
    la rtemp, PrintFailed
    jr rtemp
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

include "./cases/addiu.inc"

print ImmArgs