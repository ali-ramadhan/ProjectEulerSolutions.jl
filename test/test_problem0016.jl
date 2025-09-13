using Test
using ProjectEulerSolutions.Problem0016: power_digit_sum, solve

@test power_digit_sum(2, 15) == 26
@test power_digit_sum(2, 1) == 2
@test power_digit_sum(2, 2) == 4
@test power_digit_sum(2, 3) == 8

@test solve() == 1366
