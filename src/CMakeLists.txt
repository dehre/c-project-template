add_library(modern_lib modern/lib.c)
target_include_directories(modern_lib PUBLIC ${PROJECT_SOURCE_DIR}/include)
# target_link_libraries(modern_lib PRIVATE some_other_lib)
