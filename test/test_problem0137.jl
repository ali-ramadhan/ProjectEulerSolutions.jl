using Test
using ProjectEulerSolutions.Problem0137: nth_golden_nugget, verify_golden_nugget, fibonacci_generating_function, solve

# Test the pattern for the first few golden nuggets
# Golden nuggets should be F_{2n} × F_{2n+1}

# First few Fibonacci numbers: 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, ...
# F_2 = 1, F_3 = 2, so 1st golden nugget = 1 × 2 = 2
@test nth_golden_nugget(1) == 2

# F_4 = 3, F_5 = 5, so 2nd golden nugget = 3 × 5 = 15
@test nth_golden_nugget(2) == 15

# F_6 = 8, F_7 = 13, so 3rd golden nugget = 8 × 13 = 104
@test nth_golden_nugget(3) == 104

# F_8 = 21, F_9 = 34, so 4th golden nugget = 21 × 34 = 714
@test nth_golden_nugget(4) == 714

# Test the known 10th golden nugget from the problem statement
@test nth_golden_nugget(10) == 74049690

# Test verification function with known golden nuggets
@test verify_golden_nugget(2) == true
@test verify_golden_nugget(15) == true
@test verify_golden_nugget(104) == true

# Test that non-golden nuggets fail verification
@test verify_golden_nugget(1) == false  # 1 is not a golden nugget
@test verify_golden_nugget(3) == false  # 3 is not a golden nugget

# Test the Fibonacci generating function with the known example
# A_F(1/2) = 2 from the problem statement
result = fibonacci_generating_function(0.5)
@test result ≠ nothing
@test abs(result - 2.0) < 1e-10

# Test edge cases for the generating function
@test fibonacci_generating_function(1.0) == nothing  # Should not converge
@test fibonacci_generating_function(-0.1) == nothing  # Should be positive

# Correct answer
@test solve() == 1120149658760
