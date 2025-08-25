using Test
using ProjectEulerSolutions.Problem001: sum_multiples, solve

# Test example from problem description
@test sum_multiples([3, 5], 10) == 23

# Test edge cases and boundary conditions
@test sum_multiples([3, 5], 1) == 0  # No multiples below 1
@test sum_multiples([3, 5], 3) == 0  # No multiples below 3
@test sum_multiples([3, 5], 4) == 3  # Only 3 is below 4
@test sum_multiples([3, 5], 6) == 8  # 3 + 5 = 8

# Test with single factor
@test sum_multiples([3], 10) == 18  # 3 + 6 + 9 = 18
@test sum_multiples([5], 10) == 5   # Only 5 is below 10

# Correct answer
@test solve() == 233168
