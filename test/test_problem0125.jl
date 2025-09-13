using Test
using ProjectEulerSolutions.Problem0125: find_palindromic_consecutive_square_sums, solve

# Test the example from the problem statement
# There should be exactly 11 palindromes below 1000 with sum 4164
@test sum(find_palindromic_consecutive_square_sums(1000)) == 4164
@test length(find_palindromic_consecutive_square_sums(1000)) == 11

# Test that 595 is included (6² + 7² + 8² + 9² + 10² + 11² + 12² = 595)
palindromes_below_1000 = find_palindromic_consecutive_square_sums(1000)
@test 595 in palindromes_below_1000

# Test some other small palindromes that should be sums of consecutive squares
# 1² + 2² = 5 (palindrome)
@test 5 in palindromes_below_1000

# 2² + 3² = 13 (not palindrome, should not be included)
@test !(13 in palindromes_below_1000)

# 1² + 2² + 3² = 14 (not palindrome)
@test !(14 in palindromes_below_1000)

# Correct answer
@test solve() == 2906969179
