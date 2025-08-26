using Test
using ProjectEulerSolutions.Problem012: find_first_triangle_with_divisors, solve

@test find_first_triangle_with_divisors(5) == 28

@test solve() == 76576500
