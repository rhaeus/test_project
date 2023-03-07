#!/bin/bash
# https://swarminglogic.com/scribble/2014_05_lcov

# Step 1: Clean all build files
rm -rf ./build
rm -rf ./html
rm -rf ./.coverage

# Step 2: Re-compile whole project, including tests
mkdir build
cd build
cmake .. -DENABLE_TESTING=ON -DENABLE_COVERAGE=ON
make

cd ..
mkdir .coverage

# Step 3: Generate initial coverage information
lcov -b . -c -i -d ./build -o .coverage/.coverage.base

# Step 4: Run all tests
ctest --test-dir build/tests

# Step 5: Generate coverage based on executed tests
lcov -b . -c -d ./build -o .coverage/.coverage.run 
# Merge coverage tracefiles
lcov -a .coverage/.coverage.base -a .coverage/.coverage.run  -o .coverage/.coverage.total
# Filtering, extracting project files
lcov -e .coverage/.coverage.total "`pwd`/*" -o .coverage/.coverage.total.filtered
# Filtering, removing test-files
lcov -r .coverage/.coverage.total.filtered '*/tests/*' -o .coverage/.coverage.total.filtered
# show coverage
lcov --list .coverage/.coverage.total.filtered
# generate html
genhtml -o ./html/ .coverage/.coverage.total.filtered 

