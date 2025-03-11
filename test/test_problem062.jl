using ProjectEulerSolutions.Problem062: find_cube_permutations, solve

# Test the example from the problem statement
@test find_cube_permutations(3) == 41063625

# Test the solution
@test solve() == 127035954683
