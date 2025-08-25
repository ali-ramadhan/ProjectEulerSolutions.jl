using ProjectEulerSolutions.Problem038:
    is_pandigital, find_largest_pandigital_multiple, solve

@test is_pandigital("123456789")
@test !is_pandigital("123456780")
@test !is_pandigital("12345678")
@test !is_pandigital("1234567899")

@test is_pandigital("192384576")
@test is_pandigital("918273645")

@test solve() == 932718654
