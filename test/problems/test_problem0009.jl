using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0009

# Test with the classic 3-4-5 triplet (sum = 12)
triplets_12 = find_pythagorean_triplets(12)
@test length(triplets_12) == 1
@test triplets_12[1] == (3, 4, 5)

# Test helper function with the problem's constraints (n = 1000)
triplets_1000 = find_pythagorean_triplets(1000)
@test length(triplets_1000) == 1
a, b, c = triplets_1000[1]
@test a + b + c == 1000
@test a^2 + b^2 == c^2
@test a < b < c

# Test a sum with no solutions
@test isempty(find_pythagorean_triplets(7))

@test_answer solve(find_pythagorean_triplets) "0009"
@test_answer solve(find_pythagorean_triplets_euclid) "0009"
