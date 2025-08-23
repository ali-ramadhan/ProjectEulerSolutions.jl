using ProjectEulerSolutions.Problem023: is_abundant, find_abundant_numbers, sum_non_abundant_sums, solve
using ProjectEulerSolutions.Utils.Divisors: get_divisors

sum_of_proper_divisors(n) = sum(get_divisors(n)) - n

@test sum_of_proper_divisors(12) == 16  # 1 + 2 + 3 + 4 + 6 = 16
@test sum_of_proper_divisors(28) == 28  # 1 + 2 + 4 + 7 + 14 = 28

@test is_abundant(12) == true
@test is_abundant(28) == false

@test solve() == 4179871
