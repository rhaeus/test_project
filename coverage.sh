#!/bin/bash
# https://swarminglogic.com/scribble/2014_05_lcov

# Step 1: Clean all build files
rm -rf ./build
rm -rf ./html

# Step 2: Re-compile whole project, including tests
mkdir build
cd build
cmake .. -DENABLE_TESTING=ON -DENABLE_COVERAGE=ON
make

cd ..

# Step 3: Generate initial coverage information
lcov -b . -c -i -d ./build -o .coverage.base

# Step 4: Run all tests
ctest --test-dir build/tests

# Step 5: Generate coverage based on executed tests
lcov -b . -c -d ./build -o .coverage.run 
# Merge coverage tracefiles
lcov -a .coverage.base -a .coverage.run  -o .coverage.total
# Filtering, extracting project files
lcov -e .coverage.total "`pwd`/*" -o .coverage.total.filtered
# Filtering, removing test-files
lcov -r .coverage.total.filtered '*/tests/*' -o .coverage.total.filtered
# show coverage
lcov --list .coverage.total.filtered
# generate html
genhtml -o ./html/ .coverage.total.filtered 

