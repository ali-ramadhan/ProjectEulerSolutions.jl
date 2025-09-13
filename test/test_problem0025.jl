using Test
using ProjectEulerSolutions.Problem0025: first_fibonacci_with_n_digits, solve

@test first_fibonacci_with_n_digits(2) == 7  # F_7 = 13 has 2 digits
@test first_fibonacci_with_n_digits(3) == 12 # F_12 = 144 has 3 digits

@test solve() == 4782
