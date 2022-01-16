define RSRTRD_INSTRUCTION(addu)
define RSFIRST(1)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/addu.inc"
CopyEnd:
dmapad()