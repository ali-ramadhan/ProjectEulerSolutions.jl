using Test
using ProjectEulerSolutions.Problem0062: find_cube_permutations, solve

@test find_cube_permutations(3) == 41063625

@test solve() == 127035954683
