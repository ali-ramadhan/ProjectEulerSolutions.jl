using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Utils.Digits: digit_factorial_sum
using ProjectEulerSolutions.Problem0034: search_numbers!, search_sums!, find_digit_factorial_divisors, solve

# HackerRank sample: 19 is the only number below 20 that divides its digit factorial sum, 1! + 9! = 362881 = 19 × 19099
@test find_digit_factorial_divisors(20) == [(19, 19099)]

# 145 = 1! + 4! + 5! from the problem statement, and the bound is exclusive
@test (145, 1) in find_digit_factorial_divisors(146)
@test (145, 1) ∉ find_digit_factorial_divisors(145)

# Both search strategies find the same 5-digit numbers, also when the range stops short of 10^5
five_digit = sort!(search_sums!(Tuple{Int,Int}[], 5, 10^4, 10^5))
@test five_digit == search_numbers!(Tuple{Int,Int}[], 10^4, 10^5)
@test five_digit == [(10081, 4), (21993, 33), (40585, 1)]
@test sort!(search_sums!(Tuple{Int,Int}[], 5, 10^4, 40585)) == [(10081, 4), (21993, 33)]

# Agrees with brute force below each limit, which covers both searches on full and partial digit ranges
expected = [(n, digit_factorial_sum(n) ÷ n) for n in 10:7*factorial(9) if digit_factorial_sum(n) % n == 0]
for N in (20, 146, 10^3, 22_000, 50_000, 10^5, 10^6, 10^7)
    @test find_digit_factorial_divisors(N) == filter(p -> first(p) < N, expected)
end

# No number with 8 or more digits qualifies, so the result saturates
@test find_digit_factorial_divisors(10^9) == find_digit_factorial_divisors(10^7)

# Correct answer
@test_answer solve() "0034"
