############
### server-Windows
############

add_definitions(-DWIN32 -D_CONSOLE -D_CRT_SECURE_NO_WARNINGS)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../Common/)
aux_source_directory(. SERVER_SRCS)
add_executable(BeServed ${SERVER_SRCS} NTServApp.rc)
target_link_libraries(BeServed ws2_32)
