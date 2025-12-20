using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0008

# Test helper functions with examples from the problem description
@test product_of_digits("9989") == 5832

# Test the function with the 4-digit example from the problem statement
@test largest_product_in_series(4)[1] == 5832

# Correct answer
@test_answer solve() "0008"
