using Test
using ProjectEulerSolutions.Problem072: count_reduced_proper_fractions, solve

@test count_reduced_proper_fractions(8) == 21

@test solve() == 303963552391
