using Test
using ProjectEulerSolutions.Problem033: is_curious_fraction, find_curious_fractions, solve

@test is_curious_fraction(49, 98)
@test !is_curious_fraction(30, 50)

curious_fractions = find_curious_fractions()
@test length(curious_fractions) == 4

@test solve() == 100
