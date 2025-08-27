using Test
using ProjectEulerSolutions.Problem080:
    is_perfect_square, digit_sum_of_sqrt, sum_square_root_digital_expansions, solve

# Test if perfect square detection works correctly
@test is_perfect_square(1) == true
@test is_perfect_square(2) == false
@test is_perfect_square(4) == true
@test is_perfect_square(9) == true
@test is_perfect_square(10) == false
@test is_perfect_square(16) == true
@test is_perfect_square(25) == true

# Test the example from the problem statement
@test digit_sum_of_sqrt(2, 100) == 475

# Just a basic check
@test sum_square_root_digital_expansions(10, 100) > 0

@test solve() == 40886
