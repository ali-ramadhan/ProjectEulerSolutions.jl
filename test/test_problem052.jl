using ProjectEulerSolutions.Problem052: has_same_digits, find_permuted_multiples, solve

@test has_same_digits(125874, [2])
@test has_same_digits(142857, 2:6)

@test !has_same_digits(123, [2])  # 123 and 246 don't have the same digits
@test !has_same_digits(100, [2])  # 100 and 200 don't have the same digits

@test solve() == 142857
