# HackerRank ProjectEuler+ Problem 13: Large Sum
# https://www.hackerrank.com/contests/projecteuler/challenges/euler013/problem
#
# Project Euler: https://projecteuler.net/problem=13
# Solution: https://aliramadhan.me/blog/project-euler/problem-0013/

N = parse(Int, readline())
numbers = [parse(BigInt, readline()) for _ in 1:N]
total_sum = sum(numbers)
println(string(total_sum)[1:10])
