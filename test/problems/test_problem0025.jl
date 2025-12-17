using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0025: first_fibonacci_with_n_digits, first_fibonacci_with_n_digits_formula, solve

@test first_fibonacci_with_n_digits(2) == 7  # F_7 = 13 has 2 digits
@test first_fibonacci_with_n_digits(3) == 12 # F_12 = 144 has 3 digits

@test first_fibonacci_with_n_digits_formula(2) == 7
@test first_fibonacci_with_n_digits_formula(3) == 12

# Both methods should give the same answer
@test first_fibonacci_with_n_digits(1000) == first_fibonacci_with_n_digits_formula(1000)

# Correct answer
@test_answer solve() "0025"
