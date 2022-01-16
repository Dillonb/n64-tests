define SHIFT_INSTRUCTION(srl)
include "./templates/SHIFT.tmpl"
CopyStart:
include "./cases/srl.inc"
CopyEnd:
dmapad()