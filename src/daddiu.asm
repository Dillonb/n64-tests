define IMM_INSTRUCTION(daddiu)
include "./templates/IMMEDIATE.tmpl"
CopyStart:
include "./cases/daddiu.inc"
CopyEnd:
dmapad()