define RSRTRD_INSTRUCTION(srav)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/srav.inc"
CopyEnd:
dmapad()