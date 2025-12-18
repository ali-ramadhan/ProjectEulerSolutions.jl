using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0027: count_consecutive_primes, solve

# Example 1 from the problem: n² + n + 41 (a = 1, b = 41)
@test count_consecutive_primes(1, 41) == 40

# Example 2 from the problem: n² - 79n + 1601 (a = -79, b = 1601)
@test count_consecutive_primes(-79, 1601) == 80

# Correct answer
@test_answer solve() "0027"
