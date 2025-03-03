using ProjectEulerSolutions.Problem012: count_divisors, find_first_triangle_with_divisors, solve

@test count_divisors(1) == 1
@test count_divisors(3) == 2
@test count_divisors(6) == 4
@test count_divisors(10) == 4
@test count_divisors(15) == 4
@test count_divisors(21) == 4
@test count_divisors(28) == 6

@test find_first_triangle_with_divisors(5) == 28

@test solve() == 76576500
