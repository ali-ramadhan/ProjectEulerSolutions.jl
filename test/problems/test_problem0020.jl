using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0020: sum_of_factorial_digits, solve

@test sum_of_factorial_digits(10) == 27

# Correct answer
@test_answer solve() "0020"
