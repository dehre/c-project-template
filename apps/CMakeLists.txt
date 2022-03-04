# add the executable
add_executable(main main.c)

# link the libraries
target_link_libraries(main PUBLIC modern_lib)

# add the binary tree to the search path for include files
target_include_directories(main PUBLIC ${PROJECT_SOURCE_DIR}/include)
