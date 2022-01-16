macro shiftjt(INSTR, rt, rd) {
ShiftJt:
    define i(0)

    // rtemp contains the arg. load address of jump table base into rtemp2, add the offset to jump into the correct spot in the table
    la rtemp2, {#}JtBase
    sll rtemp, rtemp, 3 // multiply by 8
    add rtemp2, rtemp2, rtemp // and add to base of jump table

    jr rtemp2
      nop

{#}JtBase:
    while {i} <= 32 {
        define p(pc())
        jr ra
          {INSTR} {rd}, {rt}, {i}
        evaluate i({i} + 1)
    }
}

