using Test
using ProjectEulerSolutions.Problem0133: multiplicative_order, has_only_factors_2_and_5, can_divide_repunit_10n, solve

# Test multiplicative order computation
@test multiplicative_order(10, 7) == 6   # ord_7(10) = 6
@test multiplicative_order(10, 11) == 2  # ord_11(10) = 2
@test multiplicative_order(10, 17) == 16 # ord_17(10) = 16

# Test has_only_factors_2_and_5 function
@test has_only_factors_2_and_5(1) == true    # 1 has no prime factors
@test has_only_factors_2_and_5(2) == true    # 2 = 2^1
@test has_only_factors_2_and_5(4) == true    # 4 = 2^2
@test has_only_factors_2_and_5(5) == true    # 5 = 5^1
@test has_only_factors_2_and_5(10) == true   # 10 = 2^1 × 5^1
@test has_only_factors_2_and_5(16) == true   # 16 = 2^4
@test has_only_factors_2_and_5(20) == true   # 20 = 2^2 × 5^1
@test has_only_factors_2_and_5(3) == false   # 3 has prime factor 3
@test has_only_factors_2_and_5(6) == false   # 6 = 2 × 3
@test has_only_factors_2_and_5(15) == false  # 15 = 3 × 5

# Test the examples from the problem statement
# The problem states that 11, 17, 41, and 73 are the only primes below 100 that can divide R(10^n)
@test can_divide_repunit_10n(11) == true
@test can_divide_repunit_10n(17) == true
@test can_divide_repunit_10n(41) == true
@test can_divide_repunit_10n(73) == true

# The problem states that 19 cannot divide any R(10^n)
@test can_divide_repunit_10n(19) == false

# Test some other primes that should not be able to divide R(10^n)
@test can_divide_repunit_10n(3) == false   # ord_3(10) = 1, but 3 divides 10 so gcd(10,3) ≠ 1
@test can_divide_repunit_10n(7) == false   # ord_7(10) = 6 = 2 × 3, contains factor 3
@test can_divide_repunit_10n(13) == false  # ord_13(10) = 6 = 2 × 3, contains factor 3
@test can_divide_repunit_10n(23) == false  # ord_23(10) should contain factors other than 2,5

# Verify specific multiplicative orders mentioned in the problem
# For 11: ord_11(10) = 2 (since 10^2 = 100 ≡ 1 (mod 11))
@test multiplicative_order(10, 11) == 2
@test has_only_factors_2_and_5(2) == true  # 2 = 2^1, so 11 can divide R(10^n)

# For 17: we need to check that ord_17(10) has only factors 2 and 5
order_17 = multiplicative_order(10, 17)
@test has_only_factors_2_and_5(order_17) == true

# Test that 2 and 5 are excluded (they don't satisfy gcd(10, p) = 1)
@test can_divide_repunit_10n(2) == false
@test can_divide_repunit_10n(5) == false

# Correct answer
@test solve() == 453647705
