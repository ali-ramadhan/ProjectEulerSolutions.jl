using Test
using ProjectEulerSolutions.BonusRoot13: compute_sqrt_digits, sum_sqrt_decimal_digits, solve
using ProjectEulerSolutions.Utils.AnswerHashing

# Test compute_sqrt_digits with known values
# √2 ≈ 1.4142135623730950488...
digits_sqrt2 = compute_sqrt_digits(2, 10)
expected_sqrt2 = [4, 1, 4, 2, 1, 3, 5, 6, 2, 3]
@test digits_sqrt2 == expected_sqrt2

# Test sum of decimal digits for √2
# S(2, 10) should be 4+1+4+2+1+3+5+6+2+3 = 31
@test sum_sqrt_decimal_digits(2, 10) == 31

# Verify the example from problem description
# S(2, 100) = 481
@test sum_sqrt_decimal_digits(2, 100) == 481

# Test with perfect square (should have all zeros after decimal point)
digits_sqrt4 = compute_sqrt_digits(4, 5)
@test all(d == 0 for d in digits_sqrt4)

# Test that we get reasonable results for √13
digits_sqrt13 = compute_sqrt_digits(13, 10)
@test length(digits_sqrt13) == 10
@test all(0 <= d <= 9 for d in digits_sqrt13)

# Correct answer
@test_answer solve() "root13" "bonus"
