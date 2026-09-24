# HackerRank ProjectEuler+ Problem 34: Digit factorials
# https://www.hackerrank.com/contests/projecteuler/challenges/euler034/problem
#
# Project Euler: https://projecteuler.net/problem=34
# Solution: https://aliramadhan.me/blog/project-euler/problem-0034/
#
# Problem Statement:
#   19 is a curious number, as 1! + 9! = 1 + 362880 = 362881 which is divisible
#   by 19.
#
#   Find the sum of all numbers below N which divide the sum of the factorial of
#   their digits.
#
#   Note: as 1!, 2!, ..., 9! are not sums they are not included.
#
# Input Format:
#   Input contains an integer N
#
# Constraints:
#   10 <= N <= 10^5
#
# Output Format:
#   Print the answer corresponding to the test case.
#
# Sample Input:
#   20
#
# Sample Output:
#   19

function digit_factorial_sum(n)
    s = 0
    while n > 0
        n, d = divrem(n, 10)
        s += factorial(d)
    end
    return s
end

function sum_digit_factorial_divisors(N)
    total = 0
    for n in 10:min(N - 1, 7 * factorial(9))
        digit_factorial_sum(n) % n == 0 && (total += n)
    end
    return total
end

N = parse(Int, readline())
println(sum_digit_factorial_divisors(N))
