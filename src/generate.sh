#!/usr/bin/env bash


function gen_imm {
  cp IMMEDIATE.tmpl "${1}.asm"
  sed -i "s/IMM_INSTRUCTION/${1}/g" "${1}.asm"
  sed -i '1s;^;// WARNING: This file was automatically generated from a template, do not edit by hand!\n// Edit IMMEDIATE.tmpl and run generate.sh instead!\n;' "${1}.asm"
}

gen_imm addiu