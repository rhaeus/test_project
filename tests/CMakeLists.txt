  set(TEST_MAIN
    "unit_test")
  set(TEST_SOURCES
    "test_main.cpp"
    "second_test_file.cpp"
    )

  SET(GCC_COVERAGE_COMPILE_FLAGS "-fprofile-arcs -ftest-coverage")
  SET(GCC_COVERAGE_LINK_FLAGS    "--coverage")
  SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
  SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}" )
  # set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE ON)

  find_package(Catch2 REQUIRED)

  add_executable(${TEST_MAIN} ${TEST_SOURCES})

  target_link_libraries(${TEST_MAIN} PUBLIC
  test_lib
  Catch2::Catch2
  # Catch2::Catch2WithMain
  )

  enable_testing()
  # add_test(NAME ${TEST_MAIN} COMMAND ${TEST_MAIN})

  include(CTest)
  include(Catch)
  catch_discover_tests(${TEST_MAIN})

  # if(CODE_COVERAGE)
  #     set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
  #     include(CodeCoverage)
  #     append_coverage_compiler_flags()
  #     # setup_target_for_coverage_lcov(NAME coverage EXECUTABLE ${TEST_MAIN} BASE_DIRECTORY ../coverage)
  #     # setup_target_for_coverage_lcov(NAME coverage)
  #     setup_target_for_coverage_lcov(NAME coverage EXECUTABLE ${TEST_MAIN} )
  # endif()