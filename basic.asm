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