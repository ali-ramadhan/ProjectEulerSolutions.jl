using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0012: find_first_triangle_with_divisors, solve

@test find_first_triangle_with_divisors(5) == (7, 28)

@test_answer solve() "0012"
