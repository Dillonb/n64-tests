define RSRTRD_INSTRUCTION(slt)
define RSFIRST(0)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/slt.inc"
CopyEnd:
dmapad()