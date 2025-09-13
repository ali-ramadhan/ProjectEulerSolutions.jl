using Test
using ProjectEulerSolutions.Problem0006: solve
using ProjectEulerSolutions.Utils.Sequences: sum_of_squares, square_of_sum

# Test helper functions with examples from the problem description
@test sum_of_squares(10) == 385
@test square_of_sum(10) == 3025

# Test the difference calculation for the given example
@test square_of_sum(10) - sum_of_squares(10) == 2640

# Test edge cases
@test sum_of_squares(1) == 1
@test square_of_sum(1) == 1

# Correct answer
@test solve() == 25164150
