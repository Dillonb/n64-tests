define SHIFT_INSTRUCTION(dsra32)
include "./templates/SHIFT.tmpl"
CopyStart:
include "./cases/dsra32.inc"
CopyEnd:
dmapad()