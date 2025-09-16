using Test
using ProjectEulerSolutions.BonusHeegner: is_perfect_square, distance_to_nearest_integer, find_closest_cos_to_integer, solve

# Test perfect square detection
@test is_perfect_square(0) == true
@test is_perfect_square(1) == true
@test is_perfect_square(4) == true
@test is_perfect_square(9) == true
@test is_perfect_square(16) == true
@test is_perfect_square(2) == false
@test is_perfect_square(3) == false
@test is_perfect_square(-1) == false

# Test distance to nearest integer
@test distance_to_nearest_integer(1.0) == 0.0
@test distance_to_nearest_integer(1.1) ≈ 0.1
@test distance_to_nearest_integer(1.9) ≈ 0.1
@test distance_to_nearest_integer(2.5) == 0.5
@test distance_to_nearest_integer(-1.1) ≈ 0.1

# Test with small limit to verify algorithm works
result_small = find_closest_cos_to_integer(10)
@test result_small isa Int
@test abs(result_small) <= 10

# Correct answer
@test solve() == -163
