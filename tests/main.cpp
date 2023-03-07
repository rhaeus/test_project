
#define CATCH_CONFIG_MAIN // This tells Catch to provide a main() - only do
                          // this in one cpp file
// #include <catch2/catch_test_macros.hpp>
// #include <catch2/catch_all.hpp>
// #include <catch2/catch.hpp>
#include "catch.hpp"

#include "factorial.hpp"

TEST_CASE("Factorials are computed", "[factorial]") {
  REQUIRE(factorial(1) == 1);
  REQUIRE(factorial(2) == 2);
  REQUIRE(factorial(3) == 6);
  REQUIRE(factorial(3) == 7);
  REQUIRE(factorial(10) == 3'628'800);
}