# HackerRank ProjectEuler+ Problem 27: Quadratic Primes
# https://www.hackerrank.com/contests/projecteuler/challenges/euler027/problem
#
# Project Euler: https://projecteuler.net/problem=27
# Solution: https://aliramadhan.me/blog/project-euler/problem-0027/
#
# Problem Statement:
# Euler published the remarkable quadratic formula: n^2 + n + 41
# It produces 40 primes for consecutive values n = 0 to 39.
#
# Considering quadratics of the form: n^2 + an + b, where |a| <= N and |b| <= N
# Find coefficients a and b for the quadratic that produces the maximum number
# of primes for consecutive values of n, starting with n = 0.
#
# Input Format:
# The first line contains an integer N.
#
# Output Format:
# Print the value of a and b separated by space.
#
# Constraints:
# 42 <= N <= 2000
#
# Sample Input:
# 42
#
# Sample Output:
# -1 41
#
# Explanation:
# For a = -1 and b = 41, you get 42 primes.

function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    # Check divisibility by numbers of form 6k+-1 up to sqrt(n)
    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end

function count_consecutive_primes(a, b)
    n = 0

    while true
        value = n^2 + a*n + b

        if value < 0 || !is_prime(value)
            break
        end

        n += 1
    end

    return n
end

function find_quadratic_with_most_primes(N)
    max_prime_count = 0
    best_a = 0
    best_b = 0

    # b must be prime since f(0) = b must be prime
    for b in 2:N
        if !is_prime(b)
            continue
        end

        # f(1) = 1 + a + b must be prime, so a = p - b - 1 for some prime p
        # We need |a| <= N, so -N <= p - b - 1 <= N
        # Therefore: b + 1 - N <= p <= b + 1 + N
        p_min = max(2, b + 1 - N)
        p_max = b + 1 + N

        for p in p_min:p_max
            if !is_prime(p)
                continue
            end

            a = p - b - 1
            count = count_consecutive_primes(a, b)

            if count > max_prime_count
                max_prime_count = count
                best_a = a
                best_b = b
            end
        end
    end

    return best_a, best_b
end

N = parse(Int, readline())
a, b = find_quadratic_with_most_primes(N)
println("$a $b")
