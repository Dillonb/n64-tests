arch n64.cpu
endian msb
fill 4032

origin $00000000
base $A4000040

include "n64.inc"

// Write 0x00001000 to 0x04600000 (PI DMA RAM addr)
li v0, $00001000
li a0, $A4600000
sw v0, 0(a0)

// Write $10001000 to $04600004 (PI DMA cart addr)
li v0, $10001000
sw v0, 4(a0)

// Write $000FFFFF to $0460000C (PI DMA write length, starts DMA from cart to RAM)
li v0, $000FFFFF
sw v0, $C(a0)

// Wait for DMA to complete
wait_dma:
    lw v0, $10(a0)
    andi v0, v0, 3
    bnez v0, wait_dma
    nop

li at, $A4600000
li v0, $00000000
li v1, $00000000
li a0, $00000000
li a1, $F1170446
li a2, $CDD30892
li a3, $60896CF3
li t0, $A4002000
li t1, $80001000
li t2, $F8CA5469
li t3, $B0000000
li t4, $B7634E3E
li t5, $00000020
li t6, $09DD502F
li t7, $40C3CAD5
li s0, $00000000
li s1, $00000000
li s2, $00000000
li s3, $00000000
li s4, $00000001
li s5, $00000000
li s6, $0000003F
li s7, $00000000
li t8, $8D10C247
li t9, $0EE95460
li k0, $00000000
li k1, $00000000
li gp, $00000000
li sp, $A4001FF0
li s8, $00000000
li ra, $A4001550

jr t1
nop