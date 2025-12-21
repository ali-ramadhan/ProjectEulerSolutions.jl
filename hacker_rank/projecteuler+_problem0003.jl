# HackerRank ProjectEuler+ Problem 3: Largest Prime Factor
# https://www.hackerrank.com/contests/projecteuler/challenges/euler003/problem
#
# Project Euler: https://projecteuler.net/problem=3
# Solution: https://aliramadhan.me/blog/project-euler/problem-0003/
#
# Problem Statement:
#   The prime factors of 13195 are 5, 7, 13 and 29.
#   What is the largest prime factor of a given number N?
#
# Input Format:
#   First line contains T, the number of test cases.
#   This is followed by T lines each containing an integer N.
#
# Constraints:
#   1 ≤ T ≤ 10
#   10 ≤ N ≤ 10^12
#
# Output Format:
#   For each test case, display the largest prime factor of N.

function largest_prime_factor(n)
    largest = 1

    while n % 2 == 0
        largest = 2
        n = div(n, 2)
    end

    factor = 3
    while factor * factor <= n
        while n % factor == 0
            largest = factor
            n = div(n, factor)
        end
        factor += 2
    end

    if n > 1
        largest = n
    end

    return largest
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(largest_prime_factor(N))
end
