using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0016

@test power_digit_sum(2, 15) == 26
@test power_digit_sum(2, 1) == 2
@test power_digit_sum(2, 2) == 4
@test power_digit_sum(2, 3) == 8

@test_answer solve() "0016"
