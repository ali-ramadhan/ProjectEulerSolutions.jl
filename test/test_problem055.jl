using ProjectEulerSolutions.Problem055:
    reverse_digits, is_lychrel, count_lychrel_numbers, solve

@test reverse_digits(47) == 74
@test reverse_digits(349) == 943
@test reverse_digits(1292) == 2921

@test !is_lychrel(47)  # Becomes a palindrome in 1 iteration
@test !is_lychrel(349)  # Becomes a palindrome in 3 iterations
@test is_lychrel(196)  # Assumed to be a Lychrel number
@test is_lychrel(4994)  # Example of a palindromic Lychrel number

# Test with a number known to require more than 50 iterations
@test is_lychrel(10677)

@test solve() == 249
