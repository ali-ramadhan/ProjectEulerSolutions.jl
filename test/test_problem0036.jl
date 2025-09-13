using Test
using ProjectEulerSolutions.Problem0036:
    is_palindromic_base10, is_palindromic_base2, sum_double_base_palindromes, solve

@test is_palindromic_base10(1) == true
@test is_palindromic_base10(22) == true
@test is_palindromic_base10(121) == true
@test is_palindromic_base10(123) == false
@test is_palindromic_base10(585) == true
@test is_palindromic_base10(12321) == true
@test is_palindromic_base10(12345) == false

@test is_palindromic_base2(1) == true   # 1
@test is_palindromic_base2(3) == true   # 11
@test is_palindromic_base2(5) == true   # 101
@test is_palindromic_base2(7) == true   # 111
@test is_palindromic_base2(9) == true   # 1001
@test is_palindromic_base2(2) == false  # 10
@test is_palindromic_base2(4) == false  # 100
@test is_palindromic_base2(6) == false  # 110
@test is_palindromic_base2(585) == true # 1001001001

@test sum_double_base_palindromes(10) == 1 + 3 + 5 + 7 + 9

@test solve() == 872187
