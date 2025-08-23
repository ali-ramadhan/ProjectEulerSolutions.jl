using Test
using ProjectEulerSolutions.Problem086: count_integer_routes, solve

# Test the counting function with known values from the problem
@test count_integer_routes(100) == 2060

# From Euler's hint in the problem
@test count_integer_routes(99) == 1975

# Test the main solve function
@test solve() == 1818
