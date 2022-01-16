define RSRTRD_INSTRUCTION(subu)
define RSFIRST(0)
include "./templates/RSRTRD.tmpl"
CopyStart:
include "./cases/subu.inc"
CopyEnd:
dmapad()