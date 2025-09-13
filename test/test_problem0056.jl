using Test
using ProjectEulerSolutions.Problem0056: digit_sum, max_digital_sum, solve

# Test digit sum function
@test digit_sum(123) == 6
@test digit_sum(999) == 27
@test digit_sum(big(10)^100) == 1  # Googol has digit sum 1
@test digit_sum(big(100)^100) == 1  # 100^100 has digit sum 1

# Test with smaller limit
@test max_digital_sum(10) > 0
@test max_digital_sum(50) < max_digital_sum(100)

@test solve() == 972
