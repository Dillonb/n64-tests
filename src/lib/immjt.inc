macro immjt(INSTR, rs, rt) {
ImmJt:
    define i(0)

    // rtemp contains the arg. load address of jump table base into rtemp2, add the offset to jump into the correct spot in the table
    la rtemp2, {#}JtBase
    sll rtemp, rtemp, 4 // multiply by 16
    add rtemp2, rtemp2, rtemp // and add to base of jump table

    jr rtemp2
      nop

{#}JtBase:
    while {i} <= $FFFF {
        define p(pc())
        {INSTR} {rt}, {rs}, {i}
        jr ra
          nop
          nop
        evaluate i({i} + 1)
    }
}

