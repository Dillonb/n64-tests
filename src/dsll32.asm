define SHIFT_INSTRUCTION(dsll32)
include "./templates/SHIFT.tmpl"
CopyStart:
include "./cases/dsll32.inc"
CopyEnd:
dmapad()