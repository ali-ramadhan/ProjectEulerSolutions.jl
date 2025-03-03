using ProjectEulerSolutions.Problem002: sum_even_fibonacci, solve

@test sum_even_fibonacci(10) == 10
@test sum_even_fibonacci(100) == 44
@test solve() == 4613732
