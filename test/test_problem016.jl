using ProjectEulerSolutions.Problem016: sum_of_digits, power_digit_sum, solve

@test sum_of_digits(123) == 6
@test sum_of_digits(32768) == 26

@test power_digit_sum(2, 15) == 26
@test power_digit_sum(2, 1) == 2
@test power_digit_sum(2, 2) == 4
@test power_digit_sum(2, 3) == 8

@test solve() == 1366
