using Test
using ProjectEulerSolutions.Problem0120: calculate_max_remainder, solve

# Test the given example: a = 7 should give rmax = 42
@test calculate_max_remainder(7) == 42

# Test edge cases
@test calculate_max_remainder(3) == 6   # 3 * (3-1) = 6
@test calculate_max_remainder(4) == 8   # 4 * (4-2) = 8

# Test a few more cases to verify the pattern
@test calculate_max_remainder(5) == 20  # 5 * (5-1) = 20
@test calculate_max_remainder(6) == 24  # 6 * (6-2) = 24
@test calculate_max_remainder(8) == 48  # 8 * (8-2) = 48
@test calculate_max_remainder(9) == 72  # 9 * (9-1) = 72

# Correct answer
@test solve() == 333082500
