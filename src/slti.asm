define IMM_INSTRUCTION(slti)
include "./templates/IMMEDIATE.tmpl"
CopyStart:
include "./cases/slti.inc"
CopyEnd:
dmapad()