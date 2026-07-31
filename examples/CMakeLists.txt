cmake_minimum_required(VERSION 3.16)

option(DEVELOPMENT ON "Application & Libraries Development Mode. This will be forced qrc to be built when DEVELOPMENT is OFF")

add_executable(${MODULE_NAME}Example main.cpp)

target_link_libraries(${MODULE_NAME}Example
    PRIVATE
        ${MODULE_NAMESPACE}::${MODULE_NAME}
        Qt${QT_VERSION_MAJOR}::Core
)
