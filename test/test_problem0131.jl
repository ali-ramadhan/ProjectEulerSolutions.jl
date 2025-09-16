using Test
using ProjectEulerSolutions.Problem0131: count_remarkable_primes, solve

# Test that there are exactly 4 such primes below 100
@test count_remarkable_primes(100) == 4

# Test edge cases
@test count_remarkable_primes(1) == 0
@test count_remarkable_primes(7) == 0
@test count_remarkable_primes(8) == 1  # includes 7

# Correct answer
@test solve() == 173
