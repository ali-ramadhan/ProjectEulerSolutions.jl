using Test
using ProjectEulerSolutions.Problem060:
    concat_numbers, is_pair_compatible, find_prime_pair_set, solve

# Test number concatenation
@test concat_numbers(3, 7) == 37
@test concat_numbers(7, 3) == 73
@test concat_numbers(109, 673) == 109673
@test concat_numbers(673, 109) == 673109
@test concat_numbers(12, 345) == 12345

# Test pair compatibility
prime_cache = Dict{Int, Bool}()
@test is_pair_compatible(3, 7, prime_cache)  # 37 and 73 are both prime
@test !is_pair_compatible(2, 3, prime_cache)  # 23 is prime but 32 is not
@test is_pair_compatible(7, 109, prime_cache)  # From problem example

# Test the 4-prime example from the problem statement
set4, sum4 = find_prime_pair_set(4, 1000)
@test sum4 == 792
@test sort(set4) == [3, 7, 109, 673]

# Test that smaller sets can be found
set2, sum2 = find_prime_pair_set(2, 100)
@test length(set2) == 2
@test sum2 > 0

@test solve() == 26033
