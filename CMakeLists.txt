cmake_minimum_required(VERSION 3.14)

# set the project name and version
project(CoolProject VERSION 1.0)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED True)

# add the executable
add_executable(main apps/main.c)
