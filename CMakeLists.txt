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
# option(ENABLE_TESTING "Unit testing build"                        ON)
# option(ENABLE_COVERAGE "Collect coverage from test library"         ON)

if(ENABLE_COVERAGE)
  SET(GCC_COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
  SET(GCC_COVERAGE_LINK_FLAGS    "--coverage")
  SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
  SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}" )
endif(ENABLE_COVERAGE)

set(SRC_LIST
	"${PROJECT_SOURCE_DIR}/src/main.cpp"
)

# To make headers show up in IDEs
set(HEADER_LIST
	# "${PROJECT_SOURCE_DIR}/include/ufo/geometry/aabb.h"
  # ${CMAKE_SOURCE_DIR}/include/factorial.hpp
  # ${CMAKE_SOURCE_DIR}/include/min.hpp
  # ${CMAKE_SOURCE_DIR}/include/max.hpp

)

add_executable(test_project ${SRC_LIST} ${HEADER_LIST})
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
if(ENABLE_TESTING)
  add_subdirectory(tests)
endif(ENABLE_TESTING)

# add_custom_target(run_tests
#   COMMAND ctest
#   COMMAND lcov --rc lcov_branch_coverage=1 --capture --directory ${CMAKE_SOURCE_DIR} --output-file ${CMAKE_BINARY_DIR}/gtest_demo.info --test-name gtest_demo --no-external
#   COMMAND genhtml --branch-coverage gtest_demo.info --output-directory ${CMAKE_BINARY_DIR}/coverage_report --title "Code coverage report" --show-details --legend
#   COMMAND echo "Coverage report in ${CMAKE_BINARY_DIR}/coverage_report/index.html"
#   DEPENDS unit_test
# )