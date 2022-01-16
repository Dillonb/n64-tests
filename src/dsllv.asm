define RSRTRD_INSTRUCTION(dsllv)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/dsllv.inc"
CopyEnd:
dmapad()