using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0010

# Test helper function with the example from the problem description
@test sum_of_primes_below(10) == 17

# Correct answer
@test_answer solve() "0010"
