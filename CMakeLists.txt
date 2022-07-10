cmake_minimum_required(VERSION 3.14)

# set the project name and version
project(CoolProject VERSION 1.0)

set(CMAKE_C_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_C_CLANG_TIDY clang-tidy)

# compiler options
add_compile_options(
  -Wall
  -Wextra
  -Wcast-qual
  -Wconversion
  -Wno-sign-conversion
  -g3
  -O0
  $<$<CONFIG:RELEASE>:-g0> # overwrites -g3
  $<$<CONFIG:RELEASE>:-O3> # overwrites -O0
  $<$<CONFIG:ASAN>:-fsanitize=address>
  $<$<CONFIG:ASAN>:-fno-omit-frame-pointer>
  $<$<CONFIG:UBSAN>:-fsanitize=undefined>
  $<$<CONFIG:UBSAN>:-fno-omit-frame-pointer>
  $<$<CONFIG:TSAN>:-fsanitize=thread>)
add_link_options(
  -pthread $<$<CONFIG:ASAN>:-fsanitize=address>
  $<$<CONFIG:UBSAN>:-fsanitize=undefined> $<$<CONFIG:TSAN>:-fsanitize=thread>)

# `#define DEBUG` when not in release mode
add_compile_definitions($<$<NOT:$<CONFIG:RELEASE>>:DEBUG>)

# libraries
add_subdirectory(src)

# executable code
add_subdirectory(apps)

# tests
add_subdirectory(tests)
