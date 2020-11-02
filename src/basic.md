# Basic Test
A basic test of a few MIPS behaviors. Intended to be run early-on.

## Test Descriptions

### Test 1 - Is r0 pinned to 0?
This test attempts to load 0xFF into r0 and fails if the load succeeds.

### Test 2 - does J execute the delay slot before jumping?
This test sets r2 in a delay slot, and fails if the register is not set.

### Test 3 - does beql execute the delay slot if the branch is taken?
This test sets r2 in a delay slot, and fails if the register is not set.

### Test 4 - does beql skip the delay slot if the branch is not taken?
This test sets r2 in a delay slot, and fails if the register is set.

### Test 5 - Are the registers 64 bit?
This test sets a register to 0xFFFFFFFF, adds 1 to it, and fails if it equals zero.
