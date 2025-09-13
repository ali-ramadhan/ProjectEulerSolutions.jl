using ProjectEulerSolutions.Problem0101:
    evaluate_polynomial, lagrange_interpolation, find_fit_sum, solve
using Test

# Test the polynomial evaluation
@test evaluate_polynomial(1) == 1   # 1 - 1 + 1 - 1 + ... = 1
@test evaluate_polynomial(2) == 683  # 1 - 2 + 4 - 8 + 16 - 32 + 64 - 128 + 256 - 512 + 1024

# Test Lagrange interpolation with simple cases
# Linear interpolation through (1,1) and (2,4) should give 3x - 2
points_linear = [(1, 1), (2, 4)]
@test lagrange_interpolation(points_linear, 3) == 7  # 3*3 - 2 = 7

# Test with cubic sequence from problem example: 1, 8, 27, 64, 125, 216, ...
# Using first two terms should predict P₁(3) = 15
points_cubic_2 = [(1, 1), (2, 8)]
@test lagrange_interpolation(points_cubic_2, 3) == 15

# Using first three terms should predict some value (let's verify what it actually gives)
points_cubic_3 = [(1, 1), (2, 8), (3, 27)]
predicted_4 = lagrange_interpolation(points_cubic_3, 4)
@test predicted_4 != 64  # Should be wrong prediction for 4³ = 64

# Test that our polynomial gives the expected sequence start
@test evaluate_polynomial(1) == 1
@test evaluate_polynomial(0) == 1  # All even powers sum to 1, odd powers to 0

# Correct answer
@test solve() == 37076114526
