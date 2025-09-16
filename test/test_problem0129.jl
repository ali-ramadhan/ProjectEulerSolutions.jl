using Test
using ProjectEulerSolutions.Problem0129: compute_A, find_first_exceeding, solve

# Test examples from problem description
@test compute_A(7) == 6
@test compute_A(41) == 5

# Test the assertion that A(n) first exceeds 10 at n = 17
@test find_first_exceeding(10) == 17

# Test additional small cases to verify compute_A works correctly
@test compute_A(3) == 3  # R(3) = 111 is divisible by 3
@test compute_A(9) == 9  # R(9) = 111111111 is divisible by 9
@test compute_A(11) == 2  # R(2) = 11 is divisible by 11
@test compute_A(13) == 6  # R(6) = 111111 is divisible by 13

# Correct answer
@test solve() == 1000023
