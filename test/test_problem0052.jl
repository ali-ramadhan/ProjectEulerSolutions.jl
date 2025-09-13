using Test
using ProjectEulerSolutions.Problem0052: has_same_digits, solve

# Test the example from problem statement
@test has_same_digits(125874, [2])  # 125874 and 251748
@test has_same_digits(142857, 2:6)  # The solution

# Test negative cases
@test !has_same_digits(123, [2])  # 123 and 246 don't have the same digits
@test !has_same_digits(100, [2])  # 100 and 200 don't have the same digits
@test !has_same_digits(12, [10])  # Different number of digits

# Test edge cases
@test !has_same_digits(10, [2])  # 10 and 20 have different digits

@test solve() == 142857
