# HackerRank ProjectEuler+ Problem 30: Digit Nth Powers
# https://www.hackerrank.com/contests/projecteuler/challenges/euler030/problem
#
# Project Euler: https://projecteuler.net/problem=30
# Solution: https://aliramadhan.me/blog/project-euler/problem-0030/
#
# Problem Statement:
#   Surprisingly there are only three numbers that can be written as the sum of
#   fourth powers of their digits:
#
#     1634 = 1^4 + 6^4 + 3^4 + 4^4
#     8208 = 8^4 + 2^4 + 0^4 + 8^4
#     9474 = 9^4 + 4^4 + 7^4 + 4^4
#
#   As 1 = 1^4 is not a sum it is not included.
#   The sum of these numbers is 1634 + 8208 + 9474 = 19316.
#
#   Find the sum of all the numbers that can be written as the sum of N^th
#   powers of their digits.
#
# Input Format:
#   Input contains an integer N.
#
# Constraints:
#   3 <= N <= 6
#
# Output Format:
#   Print the answer corresponding to the test case.
#
# Sample Input:
#   4
#
# Sample Output:
#   19316

function digit_power_sum(n, power)
    s = 0
    while n > 0
        n, d = divrem(n, 10)
        s += d^power
    end
    return s
end

function find_digit_power_numbers(power)
    # Upper bound: n digits where n * 9^power >= 10^(n-1)
    n = 1
    while n * 9^power >= 10^(n - 1)
        n += 1
    end
    upper_bound = (n - 1) * 9^power

    results = Int[]
    for num in 2:upper_bound
        if digit_power_sum(num, power) == num
            push!(results, num)
        end
    end

    return results
end

N = parse(Int, readline())
numbers = find_digit_power_numbers(N)
println(sum(numbers))
