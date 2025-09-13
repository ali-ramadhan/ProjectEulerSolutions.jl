using Test
using ProjectEulerSolutions.Problem0060:
    concat_numbers, sum_of_digits, is_pair_compatible, passes_mod3_compatibility, find_prime_pair_set, solve

# Test integer-based number concatenation
@test concat_numbers(3, 7) == 37
@test concat_numbers(7, 3) == 73
@test concat_numbers(109, 673) == 109673
@test concat_numbers(673, 109) == 673109
@test concat_numbers(12, 345) == 12345
@test concat_numbers(1, 23) == 123

# Test sum of digits function
@test sum_of_digits(123) == 6
@test sum_of_digits(5) == 5
@test sum_of_digits(7) == 7
@test sum_of_digits(109) == 10

# Test pair compatibility including mod-3 rule
prime_cache = Dict{Int, Bool}()
@test is_pair_compatible(3, 7, prime_cache)  # 37 and 73 are both prime
@test !is_pair_compatible(2, 3, prime_cache)  # 23 is prime but 32 is not
@test is_pair_compatible(7, 109, prime_cache)  # From problem example

# Test mod-3 compatibility function
@test passes_mod3_compatibility(3, 7)   # 3 can pair with any prime
@test passes_mod3_compatibility(3, 13)  # 3 can pair with any prime
@test !passes_mod3_compatibility(5, 7)  # 5 (mod3=2) and 7 (mod3=1) should fail
@test passes_mod3_compatibility(7, 13)  # Both have sum_of_digits mod 3 = 1

# Test that actual incompatible pairs fail the full compatibility test
# Note: 5 and 7 fail both mod-3 and actual concatenation tests
@test !is_pair_compatible(5, 7, prime_cache)

# Test the 4-prime example from the problem statement
set4, sum4 = find_prime_pair_set(4, 1000)
@test sum4 == 792
@test sort(set4) == [3, 7, 109, 673]

# Test that smaller sets can be found
set2, sum2 = find_prime_pair_set(2, 100)
@test length(set2) == 2
@test sum2 > 0

@test solve() == 26033
