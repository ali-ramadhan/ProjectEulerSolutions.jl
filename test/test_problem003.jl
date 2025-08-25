using Test
using ProjectEulerSolutions.Problem003: largest_prime_factor, solve

# Test example from problem description
@test largest_prime_factor(13195) == 29

# Correct answer
@test solve() == 6857
