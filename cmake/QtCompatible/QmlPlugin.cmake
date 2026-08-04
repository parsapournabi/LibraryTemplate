include(CMakeParseArguments)

function(wea_add_qml_module)

    set(options
        GENERATE_QMLTYPES
    )

    set(oneValueArgs
        TARGET
        URI
        VERSION
    )

    set(multiValueArgs
        PLUGIN_SOURCES
    )

    cmake_parse_arguments(QML
        "${options}"
        "${oneValueArgs}"
        "${multiValueArgs}"
        ${ARGN}
    )

    if(NOT QML_TARGET)
        message(FATAL_ERROR "TARGET is required")
    endif()

    if(NOT QML_URI)
        message(FATAL_ERROR "URI is required")
    endif()

    if(NOT QML_VERSION)
        set(QML_VERSION 1.0)
    endif()

    #
    # Plugin Target
    #

    set(plugin_target "${QML_TARGET}Plugin")

    add_library(${plugin_target} SHARED
        ${QML_PLUGIN_SOURCES}
    )

    target_link_libraries(${plugin_target}
        PRIVATE
            ${QML_TARGET}
    )

    string(TOLOWER "${plugin_target}" plugin_name)

    set_target_properties(${plugin_target}
        PROPERTIES
            PREFIX ""
            OUTPUT_NAME "${plugin_name}"
    )

    #
    # Build Tree
    #

    set(qml_build_dir
        "${CMAKE_CURRENT_BINARY_DIR}/qml"
    )

    string(REPLACE "." "/" module_path "${QML_URI}")

    set(module_build_dir
        "${qml_build_dir}/${module_path}"
    )

    file(MAKE_DIRECTORY
        "${module_build_dir}"
    )

    #
    # qmldir
    #

    file(GENERATE
        OUTPUT
            "${module_build_dir}/qmldir"

        CONTENT
"module ${QML_URI}

plugin ${plugin_name}

typeinfo plugins.qmltypes
"
    )

    #
    # copy plugin
    #

    add_custom_command(

        TARGET ${plugin_target}
        POST_BUILD

        COMMAND
            ${CMAKE_COMMAND} -E copy_if_different

            $<TARGET_FILE:${plugin_target}>

            "${module_build_dir}/"

    )

    #
    # plugins.qmltypes
    #

    if(QML_GENERATE_QMLTYPES)

        find_program(QMLPLUGINDUMP_EXECUTABLE
            qmlplugindump
        )

        if(QMLPLUGINDUMP_EXECUTABLE)

            add_custom_command(

                TARGET ${plugin_target}
                POST_BUILD

                COMMAND
                    ${QMLPLUGINDUMP_EXECUTABLE}

                    ${QML_URI}
                    ${QML_VERSION}

                    "${qml_build_dir}"

                    -output
                    "${module_build_dir}/plugins.qmltypes"

                WORKING_DIRECTORY
                    "${qml_build_dir}"

                VERBATIM

            )

        endif()

    endif()

    #
    # Install
    #

    install(
        FILES
            "${module_build_dir}/qmldir"

        DESTINATION
            qml/${module_path}
    )

    if(QML_GENERATE_QMLTYPES)

        install(
            FILES
                "${module_build_dir}/plugins.qmltypes"

            DESTINATION
                qml/${module_path}

            OPTIONAL
        )

    endif()

    install(
        TARGETS
            ${plugin_target}

        LIBRARY DESTINATION
            qml/${module_path}

        RUNTIME DESTINATION
            qml/${module_path}
    )

endfunction()