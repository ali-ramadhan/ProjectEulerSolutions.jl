using Test
using ProjectEulerSolutions.BonusHeegner: distance_to_nearest_integer, find_closest_cos_to_integer, solve
using ProjectEulerSolutions.Utils.AnswerHashing

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
@test_answer solve() "heegner" "bonus"
