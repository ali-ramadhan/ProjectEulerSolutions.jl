using Test
using ProjectEulerSolutions.Problem0031: count_coin_combinations, solve

# 5p can be made in 4 ways
@test count_coin_combinations(5, [1, 2, 5]) == 4

@test solve() == 73682
