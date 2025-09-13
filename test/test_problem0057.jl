using Test
using ProjectEulerSolutions.Problem0057: count_numerator_exceeds_denominator, solve

# Test with smaller limits - the 8th expansion is first where numerator > denominator
@test count_numerator_exceeds_denominator(7) == 0  # First 7 don't qualify
@test count_numerator_exceeds_denominator(8) == 1  # Only the 8th expansion
@test count_numerator_exceeds_denominator(10) >= 1

@test solve() == 153
