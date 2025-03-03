using ProjectEulerSolutions.Problem021: sum_of_proper_divisors, find_amicable_numbers, solve

@test sum_of_proper_divisors(220) == 284
@test sum_of_proper_divisors(284) == 220

@test sum_of_proper_divisors(1) == 0
@test sum_of_proper_divisors(6) == 1 + 2 + 3
@test sum_of_proper_divisors(28) == 1 + 2 + 4 + 7 + 14

@test solve() == 31626
