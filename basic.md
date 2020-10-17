# Basic Test
A basic test of a few MIPS behaviors. Intended to be run early-on.

## Running
For now, the tests have no graphical output. Run the tests, and when they start looping infinitely, look at the value of r30. If it's 0, your emulator has passed all the tests, congratulations! Otherwise, r30 will contain the id of the failed test.

## Test Descriptions

### Test 1 - Is r0 pinned to 0?
This test attempts to load 0xFF into r0 and fails if the load succeeds.

### Test 2 - does J execute the delay slot before jumping?
This test sets r2 in a delay slot, and fails if the register is not set.

### Test 3 - does beql execute the delay slot if the branch is taken?
This test sets r2 in a delay slot, and fails if the register is not set.
