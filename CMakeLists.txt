cmake_minimum_required(VERSION 3.14)

# set the project name and version
project(CoolProject VERSION 1.0)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_C_CLANG_TIDY clang-tidy)

# libraries
add_subdirectory(src)

# executable code
add_subdirectory(apps)

# tests
add_subdirectory(tests)
