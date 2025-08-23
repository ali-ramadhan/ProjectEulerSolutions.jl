using ProjectEulerSolutions.Problem021: find_amicable_numbers, solve
using ProjectEulerSolutions.Utils.Divisors: get_divisors

sum_of_proper_divisors(n) = sum(get_divisors(n)) - n

@test sum_of_proper_divisors(220) == 284
@test sum_of_proper_divisors(284) == 220

@test sum_of_proper_divisors(1) == 0
@test sum_of_proper_divisors(6) == 1 + 2 + 3
@test sum_of_proper_divisors(28) == 1 + 2 + 4 + 7 + 14

@test solve() == 31626
