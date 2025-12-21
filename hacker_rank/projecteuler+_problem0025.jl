# HackerRank ProjectEuler+ Problem 25: N-digit Fibonacci Number
# https://www.hackerrank.com/contests/projecteuler/challenges/euler025/problem
#
# Project Euler: https://projecteuler.net/problem=25
# Solution: https://aliramadhan.me/blog/project-euler/problem-0025/
#
# Problem Statement:
# The Fibonacci sequence is defined by the recurrence relation:
#   F_n = F_{n-1} + F_{n-2}, where F_1 = 1 and F_2 = 1
#
# Hence the first 12 terms will be:
#   F_1 = 1, F_2 = 1, F_3 = 2, F_4 = 3, F_5 = 5, F_6 = 8,
#   F_7 = 13, F_8 = 21, F_9 = 34, F_10 = 55, F_11 = 89, F_12 = 144
#
# The 12th term, F_12, is the first term to contain three digits.
# What is the first term in the Fibonacci sequence to contain N digits?
#
# Input Format:
#   First line contains T, the number of test cases.
#   Next T lines each contain an integer N.
#
# Constraints:
#   1 <= T <= 5000
#   2 <= N <= 5000
#
# Output Format:
#   For each test case, print the index of the first Fibonacci number
#   with at least N digits.

# Using the closed-form formula based on Binet's formula:
# F_n ~ phi^n / sqrt(5), so the number of digits is approximately
# n * log10(phi) - 0.5 * log10(5)
# Solving for n when digits >= N gives us:
# n >= ((N - 1) * log(10) + 0.5 * log(5)) / log(phi)
function first_fibonacci_with_n_digits(n)
    phi = (1 + sqrt(5)) / 2
    return ceil(Int, ((n - 1) * log(10) + 0.5 * log(5)) / log(phi))
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(first_fibonacci_with_n_digits(N))
end
