using Test
using ProjectEulerSolutions.Problem0055:
    reverse_digits, is_lychrel, count_lychrel_numbers, solve

# Test digit reversal
@test reverse_digits(47) == 74
@test reverse_digits(349) == 943
@test reverse_digits(1292) == 2921
@test reverse_digits(1) == 1  # Single digit

# Test Lychrel detection
@test !is_lychrel(47)  # Becomes a palindrome in 1 iteration: 47 + 74 = 121
@test !is_lychrel(349)  # Becomes a palindrome in 3 iterations
@test is_lychrel(196)  # Assumed to be a Lychrel number
@test is_lychrel(4994)  # Example of a palindromic Lychrel number
@test is_lychrel(10677)  # Requires more than 50 iterations

# Test counting function with smaller range
@test count_lychrel_numbers(200) > 0
@test count_lychrel_numbers(100) < count_lychrel_numbers(200)

@test solve() == 249
