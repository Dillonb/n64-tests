arch n64.cpu
endian msb
output "basic.z64", create
fill 1052672

origin $00000000
base   $80000000

constant rtest_failed(30)

include "lib/n64.inc"
include "lib/header.inc"
insert "lib/bootcode.bin"

Start:
    li rtest_failed, 0
    jal test1
      nop
    // all passed
    j Hang

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
    j Hang
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
    j Hang
      nop
