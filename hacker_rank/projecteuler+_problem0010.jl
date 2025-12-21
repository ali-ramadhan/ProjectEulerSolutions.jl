# HackerRank ProjectEuler+ Problem 10: Summation of Primes
# https://www.hackerrank.com/contests/projecteuler/challenges/euler010/problem
#
# Project Euler: https://projecteuler.net/problem=10
# Solution: https://aliramadhan.me/blog/project-euler/problem-0010/
#
# Problem Statement:
#   The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#   Find the sum of all the primes not greater than given N.
#
# Input Format:
#   The first line contains an integer T i.e. number of the test cases.
#   The next T lines will contains an integer N.
#
# Constraints:
#   1 ≤ T ≤ 10^4
#   1 ≤ N ≤ 10^6
#
# Output Format:
#   Print the value corresponding to each test case in separate line.
#
# Sample Input:
#   2
#   5
#   10
#
# Sample Output:
#   10
#   17

function sieve_of_eratosthenes(limit)
    is_prime = fill(true, limit)
    is_prime[1] = false

    for i in 2:isqrt(limit)
        if is_prime[i]
            for j in (i^2):i:limit
                is_prime[j] = false
            end
        end
    end

    return is_prime
end

# Precompute prime sums up to 10^6 for O(1) queries
const MAX_N = 10^6
const IS_PRIME = sieve_of_eratosthenes(MAX_N)

# Build prefix sums: PRIME_SUM[i] = sum of all primes <= i
const PRIME_SUM = zeros(Int, MAX_N)
PRIME_SUM[1] = 0
for i in 2:MAX_N
    PRIME_SUM[i] = PRIME_SUM[i-1] + (IS_PRIME[i] ? i : 0)
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(PRIME_SUM[N])
end
