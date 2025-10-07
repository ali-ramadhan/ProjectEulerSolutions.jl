using Test
using ProjectEulerSolutions.Problem0004: largest_palindrome_product, solve

# Test example from problem description
@test largest_palindrome_product(10, 99).palindrome == 9009
@test largest_palindrome_product(10, 99).factors == (91, 99)

# Test type genericity
@test largest_palindrome_product(Int32(10), Int32(99)).palindrome == Int32(9009)
@test largest_palindrome_product(Int64(100), Int64(999)).palindrome == Int64(906609)
@test largest_palindrome_product(Int128(100000), Int128(999999)).palindrome == Int128(999000000999)

# Test max_product constraint (HackerRank version)
@test largest_palindrome_product(100, 999, max_product=900000).palindrome == 888888
@test largest_palindrome_product(100, 999, max_product=900000).factors == (924, 962)

# Correct answer
@test solve() == 906609