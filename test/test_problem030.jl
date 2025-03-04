using ProjectEulerSolutions.Problem030: is_sum_of_digit_powers, find_sum_of_digit_power_numbers, solve

@test is_sum_of_digit_powers(1634, 4) == true
@test is_sum_of_digit_powers(8208, 4) == true
@test is_sum_of_digit_powers(9474, 4) == true
@test is_sum_of_digit_powers(1000, 4) == false

@test find_sum_of_digit_power_numbers(4) == 19316

@test solve() == 443839
