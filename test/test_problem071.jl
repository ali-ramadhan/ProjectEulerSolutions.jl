using ProjectEulerSolutions.Problem071: find_numerator_left_of_target, solve

# Test with the example given in the problem (d ≤ 8)
@test find_numerator_left_of_target(3, 7, 8) == 2

# Verify the solution for d ≤ 1,000,000
@test solve() == 428570
