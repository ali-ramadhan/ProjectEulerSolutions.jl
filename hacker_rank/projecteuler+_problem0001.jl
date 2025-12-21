# HackerRank ProjectEuler+ Problem 1: Multiples of 3 and 5
# https://www.hackerrank.com/contests/projecteuler/challenges/euler001/problem
#
# Project Euler: https://projecteuler.net/problem=1
# Solution: https://aliramadhan.me/blog/project-euler/problem-0001/
#
# Problem Statement:
#   If we list all the natural numbers below 10 that are multiples of 3 or 5,
#   we get 3, 5, 6 and 9. The sum of these multiples is 23.
#   Find the sum of all the multiples of 3 or 5 below N.
#
# Input Format:
#   First line contains T that denotes the number of test cases.
#   This is followed by T lines, each containing an integer, N.
#
# Constraints:
#   1 <= T <= 10^5
#   1 <= N <= 10^9
#
# Output Format:
#   For each test case, print an integer that denotes the sum of all the
#   multiples of 3 or 5 below N.
#
# Sample Input:
#   2
#   10
#   100
#
# Sample Output:
#   23
#   2318

function sum_multiples(n, limit)
    if n >= limit
        return 0
    end
    k = div(limit - 1, n)  # Number of multiples of n below limit
    return div(n * k * (k + 1), 2)
end

function sum_multiples_two_inclusion_exclusion(a, b, limit)
    return sum_multiples(a, limit) +
           sum_multiples(b, limit) -
           sum_multiples(lcm(a, b), limit)
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(sum_multiples_two_inclusion_exclusion(3, 5, N))
end
