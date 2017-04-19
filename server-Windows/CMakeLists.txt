############
### server-Windows
############

add_definitions(-DWIN32 -D_CONSOLE)
aux_source_directory(. SERVER_SRCS)
add_executable(BeServed ${SERVER_SRCS} NTServApp.rc)
target_link_libraries(BeServed ws2_32)
