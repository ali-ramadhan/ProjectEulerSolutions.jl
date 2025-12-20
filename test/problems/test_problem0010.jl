using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0010

# Test helper function with the example from the problem description
_, sum_primes = sum_of_primes_below(10)
@test sum_primes == 17

# Correct answer
@test_answer solve() "0010"
