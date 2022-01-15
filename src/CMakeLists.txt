add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/lib/simple_bootcode.bin
        COMMAND bass ${CMAKE_CURRENT_LIST_DIR}/lib/simple_bootcode.asm -o ${CMAKE_CURRENT_BINARY_DIR}/lib/simple_bootcode.bin
        DEPENDS ${CMAKE_CURRENT_LIST_DIR}/lib/simple_bootcode.asm)
add_custom_target(assemble_simple_bootcode ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/lib/simple_bootcode.bin)

file(GLOB asmfiles ${CMAKE_CURRENT_LIST_DIR}/*.asm)
file(GLOB libs ${CMAKE_CURRENT_LIST_DIR}/lib/*)
file(GLOB templates ${CMAKE_CURRENT_LIST_DIR}/templates/*)
foreach(asmfile ${asmfiles})
    get_filename_component(name ${asmfile} NAME_WLE)

    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/${name}.asm ${CMAKE_CURRENT_BINARY_DIR}/${name}.asm COPYONLY)

    add_custom_command(OUTPUT ${name}.z64
            COMMAND bass ${CMAKE_CURRENT_LIST_DIR}/${name}.asm -o ${name}.bin
            COMMAND mv ${name}.bin ${name}.z64
            COMMAND chksum64 ${name}.z64
            DEPENDS ${CMAKE_CURRENT_LIST_DIR}/${name}.asm ${libs} ${templates} ${CMAKE_CURRENT_BINARY_DIR}/lib/simple_bootcode.bin)

    add_custom_command(OUTPUT ${name}_simpleboot.z64
            COMMAND cp ${name}.z64 ${name}_simpleboot.z64
            COMMAND dd if=${CMAKE_CURRENT_BINARY_DIR}/lib/simple_bootcode.bin of=${name}_simpleboot.z64 bs=1 seek=64 count=4032 conv=notrunc
            DEPENDS ${name}.z64 ${CMAKE_CURRENT_BINARY_DIR}/lib/simple_bootcode.bin)

    add_custom_target(assemble_test_rom_${name} ALL DEPENDS ${name}.z64)
    add_custom_target(assemble_test_rom_${name}_simpleboot ALL DEPENDS ${name}_simpleboot.z64)
endforeach()
