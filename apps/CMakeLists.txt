# add the executable
add_executable(main main.c)

# link the libraries
target_link_libraries(main PUBLIC modern_lib noerr_lib)

# add the binary tree to the search path for include files
target_include_directories(main PUBLIC ${PROJECT_SOURCE_DIR}/include)

#
# code snippets to try sanitizers, uncomment them
#
# add_executable(use-after-free use-after-free.c) # detected by ASan
# add_executable(signed-int-overflow signed-int-overflow.c) # detected by UBSan
# add_executable(data-race data-race.c) # detected by TSan
