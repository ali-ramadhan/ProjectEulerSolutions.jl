using ProjectEulerSolutions.Problem056: digit_sum, max_digital_sum, solve

@test digit_sum(123) == 6
@test digit_sum(999) == 27
@test digit_sum(BigInt(10)^100) == 1

@test solve() == 972
