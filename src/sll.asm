define SHIFT_INSTRUCTION(sll)
include "./templates/SHIFT.tmpl"
CopyStart:
include "./cases/sll.inc"
CopyEnd:
dmapad()