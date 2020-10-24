cmake_minimum_required (VERSION 3.10)
project (N64Tests)

file(GLOB asmfiles ${CMAKE_SOURCE_DIR}/*.asm)
foreach(asmfile ${asmfiles})
    get_filename_component(name ${asmfile} NAME_WLE)
    add_custom_target(${name}.z64 ALL
            COMMAND bass ${CMAKE_SOURCE_DIR}/${name}.asm -o ${name}.z64
            DEPENDS ../${name}.asm)
    add_custom_command(TARGET ${name}.z64
            POST_BUILD
            COMMAND chksum64 ${name}.z64)
endforeach()