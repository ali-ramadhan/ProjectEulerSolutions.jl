using ProjectEulerSolutions.Problem023: sum_of_proper_divisors, is_abundant, find_abundant_numbers, sum_non_abundant_sums, solve

@test sum_of_proper_divisors(12) == 16  # 1 + 2 + 3 + 4 + 6 = 16
@test sum_of_proper_divisors(28) == 28  # 1 + 2 + 4 + 7 + 14 = 28

@test is_abundant(12) == true
@test is_abundant(28) == false

@test solve() == 4179871
