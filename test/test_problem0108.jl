using Test
using ProjectEulerSolutions.Problem0108: count_solutions, solve

# Test with the example from the problem: n = 4 should have exactly 3 solutions
@test count_solutions(4) == 3

# Test a few more small values
@test count_solutions(2) == 2  # 1/3 + 1/6 = 1/2 and 1/4 + 1/4 = 1/2
@test count_solutions(3) == 2  # Verify with manual calculation

# Correct answer
@test solve() == 180180
