# HackerRank ProjectEuler+ Problem 9: Special Pythagorean Triplet
# https://www.hackerrank.com/contests/projecteuler/challenges/euler009/problem
#
# Project Euler: https://projecteuler.net/problem=9
# Solution: https://aliramadhan.me/blog/project-euler/problem-0009/
#
# Problem Statement:
#   A Pythagorean triplet is a set of three natural numbers, a < b < c, for
#   which, a^2 + b^2 = c^2. For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
#
#   Given N, check if there exists any Pythagorean triplet for which
#   a + b + c = N. Find maximum possible value of abc among all such
#   Pythagorean triplets. If there is no such Pythagorean triplet print -1.
#
# Input Format:
#   The first line contains an integer T i.e. number of test cases.
#   The next T lines will contain an integer N.
#
# Constraints:
#   1 ≤ T ≤ 3000
#   1 ≤ N ≤ 3000
#
# Output Format:
#   Print the value corresponding to each test case in separate lines.

function find_max_pythagorean_product(N)
    max_product = -1

    for a in 1:div(N, 3)
        numerator = N * (N - 2a)
        denominator = 2 * (N - a)

        if numerator % denominator == 0
            b = div(numerator, denominator)

            if b > 0 && b > a
                c = N - a - b

                if a < b < c && a^2 + b^2 == c^2
                    product = a * b * c
                    if product > max_product
                        max_product = product
                    end
                end
            end
        end
    end

    return max_product
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(find_max_pythagorean_product(N))
end
