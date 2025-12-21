# HackerRank ProjectEuler+ Problem 13: Large Sum
# https://www.hackerrank.com/contests/projecteuler/challenges/euler013/problem
#
# Project Euler: https://projecteuler.net/problem=13
# Solution: https://aliramadhan.me/blog/project-euler/problem-0013/
#
# Problem Statement:
#   Work out the first ten digits of the sum of N 50-digit numbers.
#
# Input Format:
#   First line contains N, next N lines contain a 50 digit number each.
#
# Constraints:
#   1 ≤ N ≤ 10^3
#
# Output Format:
#   Print only first 10 digits of the final sum.

N = parse(Int, readline())
numbers = [parse(BigInt, readline()) for _ in 1:N]
total_sum = sum(numbers)
println(string(total_sum)[1:10])
