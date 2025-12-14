using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0006: sum_square_difference, solve

# Test the difference calculation for the given example
@test sum_square_difference(10) == 2640

# Correct answer
@test_answer solve() "0006"
