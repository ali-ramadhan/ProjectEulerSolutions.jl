# Project Euler Problem 20: Factorial Digit Sum
# https://www.hackerrank.com/contests/projecteuler/challenges/euler020/problem
#
# Project Euler: https://projecteuler.net/problem=20
# Solution: https://aliramadhan.me/blog/project-euler/problem-0020/
#
# Problem:
#   n! means n x (n-1) x ... x 3 x 2 x 1
#
#   For example, 10! = 10 x 9 x ... x 3 x 2 x 1 = 3628800,
#   and the sum of the digits in the number 10! is 3+6+2+8+8+0+0 = 27.
#
#   Find the sum of the digits in the number N!
#
# Input Format:
#   First line: T (number of test cases)
#   Next T lines: an integer N
#
# Constraints:
#   1 <= T <= 100
#   0 <= N <= 1000
#
# Output Format:
#   Print the sum of digits of N! for each test case.

function sum_of_factorial_digits(n)
    fact = factorial(big(n))
    return sum(parse(Int, c) for c in string(fact))
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(sum_of_factorial_digits(N))
end
