using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0027

# Example 1 from the problem: n² + n + 41 (a = 1, b = 41)
@test count_consecutive_primes(1, 41) == 40

# Example 2 from the problem: n² - 79n + 1601 (a = -79, b = 1601)
@test count_consecutive_primes(-79, 1601) == 80

@test find_quadratic_with_most_primes(a_max=2, b_max=1000) == (-1, 41, 41)

# Compare the optimized search with exhaustive enumeration on small domains.
for (a_max, b_max) in ((1, 2), (2, 2), (3, 7), (5, 13))
    a, b, count = find_quadratic_with_most_primes(; a_max, b_max)
    expected = maximum(count_consecutive_primes(a, b)
                       for a in (1-a_max):(a_max-1), b in 2:b_max)
    @test abs(a) < a_max && abs(b) <= b_max
    @test count == expected
    @test count_consecutive_primes(a, b) == count
end

# Correct answer
@test_answer solve() "0027"
