using ProjectEulerSolutions.Problem018: max_path_sum, solve

# The example triangle from the problem
EXAMPLE_TRIANGLE = [[3], [7, 4], [2, 4, 6], [8, 5, 9, 3]]

@test max_path_sum(EXAMPLE_TRIANGLE) == 23

@test solve() == 1074
