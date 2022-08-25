add_library(modern modern/lib.c)
target_include_directories(modern PUBLIC ${PROJECT_SOURCE_DIR}/include)
# target_link_libraries(modern PRIVATE some_other_lib)
