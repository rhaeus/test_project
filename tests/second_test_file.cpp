#include <catch2/catch.hpp>

#include "max.hpp"

TEST_CASE("max is working") { REQUIRE(max(1, 2) == 2); }