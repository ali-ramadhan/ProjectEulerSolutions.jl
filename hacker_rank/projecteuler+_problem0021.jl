# HackerRank ProjectEuler+ Problem 21: Amicable Numbers
# https://www.hackerrank.com/contests/projecteuler/challenges/euler021/problem
#
# Project Euler: https://projecteuler.net/problem=21
# Solution: https://aliramadhan.me/blog/project-euler/problem-0021/
#
# Problem Statement:
#   Let d(n) be defined as the sum of proper divisors of n (numbers less than n
#   which divide evenly into n).
#
#   If d(a) = b and d(b) = a, where a != b, then a and b are an amicable pair
#   and each of a and b are called amicable numbers.
#
#   For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44,
#   55, and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4,
#   71, and 142; so d(284) = 220.
#
#   Evaluate the sum of all the amicable numbers under N.
#
# Input Format:
#   First line contains T, number of test cases.
#   Next T lines each contain an integer N.
#
# Constraints:
#   1 <= T <= 1000
#   1 <= N <= 10^5
#
# Output Format:
#   Print the sum of amicable numbers under N for each test case.
#
# Sample Input:
#   1
#   300
#
# Sample Output:
#   504

const MAX_N = 100000

function sum_proper_divisors_sieve(limit)
    sums = ones(Int, limit)
    sums[1] = 0
    for i in 2:div(limit, 2)
        for j in (2 * i):i:limit
            sums[j] += i
        end
    end
    return sums
end

function precompute_amicable_sums(limit)
    divisor_sums = sum_proper_divisors_sieve(limit)
    is_amicable = falses(limit)

    for a in 2:(limit - 1)
        b = divisor_sums[a]
        if b != a && b >= 1 && b <= limit && divisor_sums[b] == a
            is_amicable[a] = true
        end
    end

    # Compute prefix sums of amicable numbers
    prefix_sums = zeros(Int, limit + 1)
    for i in 1:limit
        prefix_sums[i + 1] = prefix_sums[i] + (is_amicable[i] ? i : 0)
    end

    return prefix_sums
end

const AMICABLE_PREFIX_SUMS = precompute_amicable_sums(MAX_N)

function solve(n)
    return AMICABLE_PREFIX_SUMS[n]
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(solve(N))
end
