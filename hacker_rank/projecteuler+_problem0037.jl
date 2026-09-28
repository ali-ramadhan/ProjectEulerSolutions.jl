# HackerRank ProjectEuler+ Problem 37: Truncatable primes
# https://www.hackerrank.com/contests/projecteuler/challenges/euler037/problem
#
# Project Euler: https://projecteuler.net/problem=37
# Solution: https://aliramadhan.me/blog/project-euler/problem-0037/
#
# Problem Statement:
#   The number 3797 has an interesting property. Being prime itself, it is
#   possible to continuously remove digits from left to right, and remain prime
#   at each stage: 3797, 797, 97, and 7. Similarly we can work from right to
#   left: 3797, 379, 37, and 3.
#
#   Find the sum of primes that are both truncatable from left to right and
#   right to left below N.
#
#   NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
#
# Input Format:
#   Input contains an integer N.
#
# Constraints:
#   100 <= N <= 10^6
#
# Output Format:
#   Print the answer corresponding to the test case.
#
# Sample Input:
#   100
#
# Sample Output:
#   186

function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    # Check divisibility by numbers of form 6k±1 up to sqrt(n)
    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end

# Removing the last digit of a right-truncatable prime leaves a right-truncatable
# prime, so they form a tree growing from 2, 3, 5 and 7 by appending the digits
# 1, 3, 7 and 9 (any other last digit makes the number divisible by 2 or 5). The
# tree is finite, so we grow all of it, using the vector as the queue.
function right_truncatable_primes()
    primes = [2, 3, 5, 7]
    i = 1
    while i <= length(primes)
        for d in (1, 3, 7, 9)
            child = 10 * primes[i] + d
            is_prime(child) && push!(primes, child)
        end
        i += 1
    end
    return primes
end

# Check the suffixes of p, shortest first
function is_left_truncatable(p)
    m = 10
    while m < p
        is_prime(p % m) || return false
        m *= 10
    end
    return true
end

# Every truncatable prime is right-truncatable, so we add up the right-truncatable
# primes below N with two or more digits whose suffixes are all prime too.
function sum_truncatable_primes(N)
    total = 0
    for p in right_truncatable_primes()
        if 10 <= p < N && is_left_truncatable(p)
            total += p
        end
    end
    return total
end

N = parse(Int, readline())
println(sum_truncatable_primes(N))
