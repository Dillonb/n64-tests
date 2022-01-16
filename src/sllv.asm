define RSRTRD_INSTRUCTION(sllv)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/sllv.inc"
CopyEnd:
dmapad()