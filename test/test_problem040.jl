using Test
using ProjectEulerSolutions.Problem040: champernowne_digit, solve

@test champernowne_digit(1) == 1
@test champernowne_digit(2) == 2
@test champernowne_digit(9) == 9
@test champernowne_digit(10) == 1
@test champernowne_digit(11) == 0
@test champernowne_digit(12) == 1
@test champernowne_digit(13) == 1

@test solve() == 210
