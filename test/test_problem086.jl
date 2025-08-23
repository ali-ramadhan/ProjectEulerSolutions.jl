using Test
using ProjectEulerSolutions.Problem086: count_integer_routes, solve

# Test the counting function with known values from the problem
@test count_integer_routes(100) == 2060

# Test the main solve function
@test solve() == 1818
