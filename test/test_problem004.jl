using ProjectEulerSolutions.Problem004: is_palindrome, largest_palindrome_product, solve

@test is_palindrome(9009)
@test !is_palindrome(12345)
@test is_palindrome(12321)

@test largest_palindrome_product(2) == 9009

@test solve() == 906609
