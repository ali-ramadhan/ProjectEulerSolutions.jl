using Test
using ProjectEulerSolutions.Problem029: count_distinct_powers, solve

# Test with the example from the problem statement
@test count_distinct_powers(2, 5, 2, 5) == 15

@test solve() == 9183
