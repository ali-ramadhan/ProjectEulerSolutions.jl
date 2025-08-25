using ProjectEulerSolutions.Problem034:
    sum_of_digit_factorials, find_digit_factorial_numbers, solve

@test sum_of_digit_factorials(145) == 145
@test sum_of_digit_factorials(1) == 1
@test sum_of_digit_factorials(2) == 2
@test sum_of_digit_factorials(123) == 9  # 1! + 2! + 3! = 1 + 2 + 6 = 9

@test solve() == 40730
