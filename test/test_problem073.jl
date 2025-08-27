using Test
using ProjectEulerSolutions.Problem073: count_fractions_in_range, solve

@test count_fractions_in_range(8, 1/3, 1/2) == 3

@test solve() == 7295372
