using Test
using ProjectEulerSolutions.Problem071: find_numerator_left_of_target, solve

# Test with the example given in the problem (d ≤ 8)
numerator, denominator = find_numerator_left_of_target(3, 7, 8)
@test numerator == 2
@test denominator == 5  # 2/5 is immediately left of 3/7 for d ≤ 8

# Test the generalized function with a different target fraction
numerator2, denominator2 = find_numerator_left_of_target(2, 5, 10)
@test numerator2 == 3
@test denominator2 == 8  # 3/8 is immediately left of 2/5 for d ≤ 10

# Correct answer
@test solve() == 428570
