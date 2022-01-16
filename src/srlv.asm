define RSRTRD_INSTRUCTION(srlv)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/srlv.inc"
CopyEnd:
dmapad()