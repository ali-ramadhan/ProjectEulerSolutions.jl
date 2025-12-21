# HackerRank ProjectEuler+ Problem 6: Sum Square Difference
# https://www.hackerrank.com/contests/projecteuler/challenges/euler006/problem
#
# Project Euler: https://projecteuler.net/problem=6
# Solution: https://aliramadhan.me/blog/project-euler/problem-0006/
#
# Problem Statement:
#   The sum of the squares of the first ten natural numbers is,
#   1² + 2² + ... + 10² = 385. The square of the sum of the first ten natural
#   numbers is, (1 + 2 + ... + 10)² = 55² = 3025. Hence the absolute difference
#   between the sum of the squares and the square of the sum is 3025 - 385 = 2640.
#   Find the absolute difference between the sum of the squares of the first N
#   natural numbers and the square of the sum.
#
# Input Format:
#   First line contains T that denotes the number of test cases.
#   This is followed by T lines, each containing an integer, N.
#
# Constraints:
#   1 ≤ T ≤ 10^4
#   1 ≤ N ≤ 10^4
#
# Output Format:
#   Print the required answer for each test case.

function sum_square_difference(n)
    return div(n * (n + 1) * (n - 1) * (3n + 2), 12)
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(sum_square_difference(N))
end
