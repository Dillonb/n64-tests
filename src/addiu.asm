define IMM_INSTRUCTION(addiu)
include "./templates/IMMEDIATE.tmpl"
CopyStart:
include "./cases/addiu.inc"
CopyEnd:
dmapad()