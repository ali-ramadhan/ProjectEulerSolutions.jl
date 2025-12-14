using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0003: largest_prime_factor, solve

# Test example from problem description
@test largest_prime_factor(13195) == 29

# Correct answer
@test_answer solve() "0003"
