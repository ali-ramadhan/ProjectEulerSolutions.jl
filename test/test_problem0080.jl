using Test
using ProjectEulerSolutions.Problem0080:
    digit_sum_of_sqrt, sum_square_root_digital_expansions, solve

# Test the example from the problem statement
@test digit_sum_of_sqrt(2, 100) == 475

# Just a basic check
@test sum_square_root_digital_expansions(10, 100) > 0

@test solve() == 40886
