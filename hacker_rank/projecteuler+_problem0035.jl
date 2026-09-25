# HackerRank ProjectEuler+ Problem 35: Circular primes
# https://www.hackerrank.com/contests/projecteuler/challenges/euler035/problem
#
# Project Euler: https://projecteuler.net/problem=35
# Solution: https://aliramadhan.me/blog/project-euler/problem-0035/
#
# Problem Statement:
#   The number, 197, is called a circular prime because all rotations of the
#   digits: 197, 971, and 719, are themselves prime.
#
#   There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
#   71, 73, 79, and 97. Sum of which is 446.
#
#   Find the sum of circular primes that are below N?
#
#   Note: Rotations can exceed N.
#
# Input Format:
#   Input contains an integer N
#
# Constraints:
#   10 <= N <= 10^6
#
# Output Format:
#   Print the answer corresponding to the test case.
#
# Sample Input:
#   100
#
# Sample Output:
#   446

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

# Move the leading digit of the d-digit number n to the end
function rotate_digits(n, d)
    leading, rest = divrem(n, 10^(d - 1))
    return rest * 10 + leading
end

# Some rotation of a number ends in each of its digits, so a circular prime with
# two or more digits cannot contain an even digit or a 5. The k-th d-digit
# candidate is k written in base 4 with its digits relabelled 0, 1, 2, 3 ->
# 1, 3, 7, 9, which keeps the candidates in increasing order.
const CIRCULAR_DIGITS = (1, 3, 7, 9)

function candidate(k, d)
    n = 0
    place = 1
    for _ in 1:d
        k, i = divrem(k, 4)
        n += CIRCULAR_DIGITS[i + 1] * place
        place *= 10
    end
    return n
end

# A number and its rotations are either all circular primes or none are, so
# each rotation class is tested once, from its smallest member. Rotations at or
# above N must still be prime, but only members below N are summed.
function sum_circular_primes(N)
    total = sum(p for p in (2, 3, 5, 7) if p < N)

    for d in 2:ndigits(N - 1)
        for k in 0:4^d-1
            p = candidate(k, d)
            p >= N && break

            # Skip p unless it is the smallest of its rotations
            r = rotate_digits(p, d)
            minimal = true
            while r != p
                r < p && (minimal = false; break)
                r = rotate_digits(r, d)
            end
            minimal || continue

            # Rotating until we return to p visits each distinct rotation once
            r = p
            circular = true
            while true
                is_prime(r) || (circular = false; break)
                r = rotate_digits(r, d)
                r == p && break
            end
            circular || continue

            r = p
            while true
                r < N && (total += r)
                r = rotate_digits(r, d)
                r == p && break
            end
        end
    end

    return total
end

N = parse(Int, readline())
println(sum_circular_primes(N))
