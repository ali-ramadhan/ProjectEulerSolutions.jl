using Test
using ProjectEulerSolutions.Problem0006: sum_square_difference, solve

# Test the difference calculation for the given example
@test sum_square_difference(10) == 2640

# Test edge cases
@test sum_of_squares(1) == 1
@test square_of_sum(1) == 1

# Correct answer
@test solve() == 25164150
