using Test
using ProjectEulerSolutions.Problem0123: calculate_remainder, solve

# Test the example from the problem description
# When n = 3, p_3 = 5, and 4^3 + 6^3 = 280 ≡ 5 (mod 25)
@test calculate_remainder(3, 5) == 2 * 3 * 5

# Test that even n gives remainder 2
@test calculate_remainder(2, 5) == 2
@test calculate_remainder(4, 7) == 2

# Test that odd n gives 2*n*p_n
@test calculate_remainder(1, 2) == 2 * 1 * 2  # 4
@test calculate_remainder(3, 5) == 2 * 3 * 5  # 30
@test calculate_remainder(5, 11) == 2 * 5 * 11  # 110

# Correct answer
@test solve() == 21035
