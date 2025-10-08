using Test
using ProjectEulerSolutions.Problem0006: sum_square_difference, solve

# Test the difference calculation for the given example
@test sum_square_difference(10) == 2640

# Correct answer
@test solve() == 25164150
