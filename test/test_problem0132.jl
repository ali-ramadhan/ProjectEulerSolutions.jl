using Test
using ProjectEulerSolutions.Problem0132: multiplicative_order, prime_divides_repunit, find_repunit_prime_factors, solve

# Test multiplicative order function with known values
@test multiplicative_order(10, 7) == 6  # 10^6 ≡ 1 (mod 7)
@test multiplicative_order(10, 11) == 2  # 10^2 ≡ 1 (mod 11)
@test multiplicative_order(10, 41) == 5  # 10^5 ≡ 1 (mod 41)

# Test prime_divides_repunit function
@test prime_divides_repunit(3, 10) == false  # 3 doesn't divide R(10)
@test prime_divides_repunit(11, 10) == true   # 11 divides R(10)
@test prime_divides_repunit(41, 10) == true   # 41 divides R(10)
@test prime_divides_repunit(271, 10) == true  # 271 divides R(10)
@test prime_divides_repunit(9091, 10) == true # 9091 divides R(10)

# Test with known example from problem description: R(10) = 11 × 41 × 271 × 9091
prime_factors_r10 = find_repunit_prime_factors(10, 4)  # R(10) has exactly 4 prime factors
@test 11 in prime_factors_r10
@test 41 in prime_factors_r10
@test 271 in prime_factors_r10
@test 9091 in prime_factors_r10

# Test that the sum of first 4 factors of R(10) gives the expected result
r10_factors = find_repunit_prime_factors(10, 4)
expected_factors = [11, 41, 271, 9091]
@test sort(r10_factors) == sort(expected_factors)
@test sum(expected_factors) == 9414

# Verify that each prime actually has the right multiplicative order properties
@test multiplicative_order(10, 11) == 2  # and 2 divides 10
@test multiplicative_order(10, 41) == 5  # and 5 divides 10
@test multiplicative_order(10, 271) == 5  # and 5 divides 10

# Correct answer
@test solve() == 843296
