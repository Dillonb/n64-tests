arch n64.cpu
endian msb
output "basic.z64", create
fill 1052672

origin $00000000
base   $80000000

include "lib/n64.inc"
include "lib/header.inc"
insert "lib/bootcode.bin"

Start:
    j Start