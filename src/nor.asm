define RSRTRD_INSTRUCTION(nor)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/nor.inc"
CopyEnd:
dmapad()