using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0009

# Test with the classic 3-4-5 triplet (sum = 12)
triplets_12 = find_pythagorean_triplets_search(12)
@test length(triplets_12) == 1
@test triplets_12[1] == (3, 4, 5)

# Test helper function with the problem's constraints (n = 1000)
triplets_1000 = find_pythagorean_triplets_search(1000)
@test length(triplets_1000) == 1
a, b, c = triplets_1000[1]
@test a + b + c == 1000
@test a^2 + b^2 == c^2
@test a < b < c

# Test a sum with no solutions
@test isempty(find_pythagorean_triplets_search(7))

# The divisor method finds the same triplets as the other two methods
@test all(find_pythagorean_triplets_divisors(P) == find_pythagorean_triplets_search(P) for P in 0:3000)
@test find_pythagorean_triplets_divisors(1_000_000) == [(200000, 375000, 425000), (218750, 360000, 421250)]
@test find_pythagorean_triplets_divisors(1_234_567_890) == find_pythagorean_triplets_euclid(1_234_567_890)

# Perimeters near typemax(Int) don't overflow
P = 9_000_000_000_000_000_000
triplets_P = find_pythagorean_triplets_divisors(P)
@test length(triplets_P) == 39
@test all(a < b < c && a + b + c == P && widemul(a, a) + widemul(b, b) == widemul(c, c) for (a, b, c) in triplets_P)

@test_answer solve(find_pythagorean_triplets_search) "0009"
@test_answer solve(find_pythagorean_triplets_euclid) "0009"
@test_answer solve(find_pythagorean_triplets_divisors) "0009"

# Correct answer
@test_answer solve() "0009"
