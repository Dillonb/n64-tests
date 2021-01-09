file(GLOB asmfiles ${CMAKE_CURRENT_LIST_DIR}/*.asm)
file(GLOB libs ${CMAKE_CURRENT_LIST_DIR}/lib/*)
file(GLOB templates ${CMAKE_CURRENT_LIST_DIR}/templates/*)
foreach(asmfile ${asmfiles})
    get_filename_component(name ${asmfile} NAME_WLE)

    add_custom_command(OUTPUT ${name}.z64
            COMMAND bass ${CMAKE_CURRENT_LIST_DIR}/${name}.asm -o ${name}.bin
            COMMAND mv ${name}.bin ${name}.z64
            COMMAND chksum64 ${name}.z64
            DEPENDS ${CMAKE_CURRENT_LIST_DIR}/${name}.asm ${libs} ${templates})

    add_custom_target(assemble_test_rom_${name} ALL DEPENDS ${name}.z64)
endforeach()
