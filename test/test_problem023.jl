using Test
using ProjectEulerSolutions.Problem023: solve
using ProjectEulerSolutions.Utils.Divisors: get_divisors

sum_of_proper_divisors(n) = sum(get_divisors(n)) - n

@test sum_of_proper_divisors(12) == 16  # 1 + 2 + 3 + 4 + 6 = 16
@test sum_of_proper_divisors(28) == 28  # 1 + 2 + 4 + 7 + 14 = 28

@test solve() == 4179871
