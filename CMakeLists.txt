cmake_minimum_required(VERSION 3.14)

project(test_project
  LANGUAGES CXX
)

# Global CMake variables
# ----------------------
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED            ON)
set(CMAKE_CXX_EXTENSIONS                  OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS          ON)

# Options
# -------
# option(ENABLE_CLANG_TIDY "Enable to add clang tidy."              OFF)
option(ENABLE_TESTING "Unit testing build"                        ON)
# option(CODE_COVERAGE "Collect coverage from test library"         ON)


set(SRC_LIST
	"${PROJECT_SOURCE_DIR}/src/main.cpp"
)

# To make headers show up in IDEs
set(HEADER_LIST
	# "${PROJECT_SOURCE_DIR}/include/ufo/geometry/aabb.h"
)

add_executable(test_project ${SRC_LIST})
target_include_directories(test_project PUBLIC
  ${CMAKE_SOURCE_DIR}/src
  ${CMAKE_SOURCE_DIR}/include
 )

add_library(test_lib SHARED ${SRC_LIST} ${HEADER_LIST})
target_include_directories(test_lib PUBLIC
  ${CMAKE_SOURCE_DIR}/src
  ${CMAKE_SOURCE_DIR}/include
 )


# Testing
# -------
add_subdirectory(tests)