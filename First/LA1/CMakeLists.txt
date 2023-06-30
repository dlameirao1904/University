cmake_minimum_required(VERSION 3.19)
project(CCPL3G05_main C)

set(CMAKE_C_STANDARD 11)

include_directories(.)

add_executable(CCPL3G05_main
        arrays.c
        arrays.h
        converter.c
        converter.h
        functions.c
        functions.h
        logic.c
        logic.h
        main.c
        math_operations.c
        math_operations.h
        mystring.c
        mystring.h
        parse_Array.c
        parse_Array.h
        parser.c
        parser.h
        stack.c
        stack.h parse_String.c parse_String.h)

target_link_libraries(CCPL3G05_main m)
