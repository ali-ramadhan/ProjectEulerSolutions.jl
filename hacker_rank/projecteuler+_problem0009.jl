# HackerRank ProjectEuler+ Problem 9: Special Pythagorean Triplet
# https://www.hackerrank.com/contests/projecteuler/challenges/euler009/problem
#
# Project Euler: https://projecteuler.net/problem=9
# Solution: https://aliramadhan.me/blog/project-euler/problem-0009/

function find_max_pythagorean_product(N)
    max_product = -1

    for a in 1:div(N, 3)
        numerator = N * (N - 2a)
        denominator = 2 * (N - a)

        # Check if b is an integer
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
