define SHIFT_INSTRUCTION(sra)
include "./templates/SHIFT.tmpl"
CopyStart:
include "./cases/sra.inc"
CopyEnd:
dmapad()