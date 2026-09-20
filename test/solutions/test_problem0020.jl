using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0020

@test sum_of_factorial_digits(10) == 27

# Correct answer
@test_answer solve() "0020"
