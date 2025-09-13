using Test
using ProjectEulerSolutions.Problem0004: largest_palindrome_product, solve

# Test example from problem description
@test largest_palindrome_product(2) == 9009

# Correct answer
@test solve() == 906609
