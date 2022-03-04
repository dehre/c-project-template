cmake_minimum_required(VERSION 3.14)

# set the project name and version
project(CoolProject VERSION 1.0)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)
set(CMAKE_C_CLANG_TIDY clang-tidy)

# libraries
add_subdirectory(src)

# add the executable
add_executable(main apps/main.c)

# link the libraries
target_link_libraries(main PUBLIC modern_lib)

# add the binary tree to the search path for include files
target_include_directories(main PUBLIC ${PROJECT_SOURCE_DIR}/include)
