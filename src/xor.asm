define RSRTRD_INSTRUCTION(xor)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/xor.inc"
CopyEnd:
dmapad()