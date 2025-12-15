using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Utils.Divisors: sum_divisors
using ProjectEulerSolutions.Problem0021: solve

sum_of_proper_divisors(n) = sum_divisors(n) - n

@test sum_of_proper_divisors(220) == 284
@test sum_of_proper_divisors(284) == 220

@test sum_of_proper_divisors(1) == 0
@test sum_of_proper_divisors(6) == 1 + 2 + 3
@test sum_of_proper_divisors(28) == 1 + 2 + 4 + 7 + 14

@test_answer solve() "0021"
