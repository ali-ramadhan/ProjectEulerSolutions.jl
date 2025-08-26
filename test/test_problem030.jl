using Test
using ProjectEulerSolutions.Problem030:
    is_sum_of_digit_powers, find_sum_of_digit_power_numbers, solve

@test is_sum_of_digit_powers(1634, 4) == true
@test is_sum_of_digit_powers(8208, 4) == true
@test is_sum_of_digit_powers(9474, 4) == true
@test is_sum_of_digit_powers(1000, 4) == false

sum_fourth_powers, _ = find_sum_of_digit_power_numbers(4)
@test sum_fourth_powers == 19316

@test solve() == 443839
