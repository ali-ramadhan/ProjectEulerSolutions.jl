using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0010

# Test helper function with the example from the problem description
@test sum_of_primes_below(10) == 17

@test sum_of_primes_below(0) == 0
@test sum_of_primes_below(1) == 0
@test sum_of_primes_below(2) == 0
@test sum_of_primes_below(3) == 2
@test sum_of_primes_below(5) == 5
@test sum_of_primes_below(6) == 10

# Correct answer
@test_answer solve() "0010"
