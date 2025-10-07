using Test
using ProjectEulerSolutions.Problem0004: largest_palindrome_product, solve

# Test example from problem description
@test largest_palindrome_product(99) == 9009

# Test type genericity
@test largest_palindrome_product(Int32(99)) == Int32(9009)
@test largest_palindrome_product(Int64(999)) == Int64(906609)
@test largest_palindrome_product(Int128(999999)) == Int128(999000000999)

# Correct answer
@test solve() == 906609