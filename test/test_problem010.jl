using Test
using ProjectEulerSolutions.Problem010: sum_of_primes_below, solve

# Test helper function with the example from the problem description
@test sum_of_primes_below(10) == 17

# Correct answer
@test solve() == 142913828922
