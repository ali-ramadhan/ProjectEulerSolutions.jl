# HackerRank ProjectEuler+ Problem 7: 10001st Prime
# https://www.hackerrank.com/contests/projecteuler/challenges/euler007/problem
#
# Project Euler: https://projecteuler.net/problem=7
# Solution: https://aliramadhan.me/blog/project-euler/problem-0007/

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

    return [i for i in 2:limit if is_prime[i]]
end

# Precompute the first 10^4 primes
# The 10,000th prime is 104,729, so we sieve up to 105,000 to be safe
const PRIMES = sieve_of_eratosthenes(105_000)

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(PRIMES[N])
end
