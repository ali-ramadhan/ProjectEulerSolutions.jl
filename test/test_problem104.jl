using Test
using ProjectEulerSolutions.Problem104: get_first_9_digits, get_last_9_digits, is_pandigital_9_digits, solve

# Test pandigital detection for 9-digit numbers
@test is_pandigital_9_digits(123456789) == true
@test is_pandigital_9_digits(987654321) == true
@test is_pandigital_9_digits(192837465) == true
@test is_pandigital_9_digits(123456788) == false  # Missing 9, duplicate 8
@test is_pandigital_9_digits(12345678) == false   # Only 8 digits
@test is_pandigital_9_digits(1234567890) == false # 10 digits

# Test last 9 digits extraction
@test get_last_9_digits(123456789) == 123456789
@test get_last_9_digits(000000001) == 1

# Test first 9 digits computation using known examples
# F(541) should have pandigital last 9 digits (given in problem)
# F(2749) should have pandigital first 9 digits (given in problem)

# Note: We can't easily test exact values without computing very large Fibonacci numbers,
# but we can test that our function produces reasonable 9-digit results
first_9_test = get_first_9_digits(100)
@test first_9_test >= 100000000  # Should be at least 9 digits
@test first_9_test <= 999999999  # Should be at most 9 digits

# Test that the algorithm finds the correct answer
# This will be the actual verification
@test solve() == 329468