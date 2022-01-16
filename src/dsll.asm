define SHIFT_INSTRUCTION(dsll)
include "./templates/SHIFT.tmpl"
CopyStart:
include "./cases/dsll.inc"
CopyEnd:
dmapad()