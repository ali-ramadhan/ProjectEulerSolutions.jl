using Test
using ProjectEulerSolutions.Problem0085: count_rectangles, solve

# Test the rectangle counting function with the example from the problem
@test count_rectangles(3, 2) == 18

# Test some other small cases
@test count_rectangles(1, 1) == 1
@test count_rectangles(2, 1) == 3  # (2*3/2) * (1*2/2) = 3 * 1 = 3
@test count_rectangles(2, 2) == 9  # (2*3/2) * (2*3/2) = 3 * 3 = 9

# Test the main solve function
@test solve() == 2772
