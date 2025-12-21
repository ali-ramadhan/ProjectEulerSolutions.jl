# HackerRank ProjectEuler+ Problem 8: Largest Product in a Series
# https://www.hackerrank.com/contests/projecteuler/challenges/euler008/problem
#
# Project Euler: https://projecteuler.net/problem=8
# Solution: https://aliramadhan.me/blog/project-euler/problem-0008/
#
# Problem Statement:
#   Find the greatest product of K consecutive digits in the N digit number.
#
# Input Format:
#   First line contains T that denotes the number of test cases.
#   First line of each test case will contain two integers N & K.
#   Second line of each test case will contain a N digit integer.
#
# Constraints:
#   1 ≤ T ≤ 100
#   1 ≤ K ≤ 7
#   K ≤ N ≤ 1000
#
# Output Format:
#   Print the required answer for each test case.

function product_of_digits(str)
    prod = 1
    for c in str
        digit = parse(Int, c)
        prod *= digit
    end
    return prod
end

function largest_product_in_series(number_str, k)
    max_product = 0

    for i in 1:(length(number_str) - k + 1)
        substring = number_str[i:(i + k - 1)]

        if '0' in substring
            continue
        end

        product = product_of_digits(substring)

        if product > max_product
            max_product = product
        end
    end

    return max_product
end

T = parse(Int, readline())
for _ in 1:T
    N, K = parse.(Int, split(readline()))
    number_str = readline()
    println(largest_product_in_series(number_str, K))
end
