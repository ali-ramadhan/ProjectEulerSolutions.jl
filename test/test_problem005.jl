using Test
using ProjectEulerSolutions.Problem005: smallest_multiple, solve

# Test example from problem description
@test smallest_multiple(10) == 2520

# Correct answer
@test solve() == 232792560
