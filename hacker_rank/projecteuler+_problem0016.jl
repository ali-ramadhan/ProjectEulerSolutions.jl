# HackerRank ProjectEuler+ Problem 16: Power Digit Sum
# https://www.hackerrank.com/contests/projecteuler/challenges/euler016/problem
#
# Project Euler: https://projecteuler.net/problem=16
# Solution: https://aliramadhan.me/blog/project-euler/problem-0016/
#
# Problem Statement:
#   2^9 = 512 and the sum of its digits is 5 + 1 + 2 = 8.
#   What is the sum of the digits of the number 2^N?
#
# Input Format:
#   The first line contains an integer T, i.e., number of test cases.
#   Next T lines will contain an integer N.
#
# Constraints:
#   1 <= T <= 100
#   1 <= N <= 10^4
#
# Output Format:
#   Print the values corresponding to each test case.
#
# Sample Input:
#   3
#   3
#   4
#   7
#
# Sample Output:
#   8
#   7
#   11

function sum_digits(n::BigInt)
    return sum(c - '0' for c in string(n))
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    result = BigInt(2)^N
    println(sum_digits(result))
end
