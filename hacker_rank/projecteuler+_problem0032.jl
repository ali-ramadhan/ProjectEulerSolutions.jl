# HackerRank ProjectEuler+ Problem 32: Pandigital Products
# https://www.hackerrank.com/contests/projecteuler/challenges/euler032/problem
#
# Project Euler: https://projecteuler.net/problem=32
# Solution: https://aliramadhan.me/blog/project-euler/problem-0032/
#
# Problem Statement:
#   We shall say that an N-digit number is pandigital if it makes use of all
#   the digits 1 to N exactly once; for example, the 5-digit number, 15234, is
#   1 through 5 pandigital.
#
#   The product 7254 is unusual, as the identity, 39 x 186 = 7254, containing
#   multiplicand, multiplier, and product is 1 through 9 pandigital.
#
#   Find the sum of all products whose multiplicand/multiplier/product identity
#   can be written as a 1 through N pandigital.
#
#   HINT: Some products can be obtained in more than one way so be sure to only
#   include it once in your sum.
#
# Input Format:
#   Input contains an integer N.
#
# Constraints:
#   4 <= N <= 9
#
# Output Format:
#   Print the answer corresponding to the test case.
#
# Sample Input:
#   4
#
# Sample Output:
#   12

function get_valid_digit_cases(n)
    cases = Tuple{Int,Int,Int}[]
    for da in 1:(n - 2)
        for db in da:(n - da - 1)
            dc = n - da - db
            if da + db - 1 <= dc <= da + db
                push!(cases, (da, db, dc))
            end
        end
    end
    return cases
end

@inline function is_pandigital_product(a, b, c, target_mask)
    result = 0
    for n in (a, b, c)
        while n > 0
            digit = n % 10
            digit == 0 && return false
            bit = 1 << (digit - 1)
            (result & bit) != 0 && return false
            result |= bit
            n = div(n, 10)
        end
    end
    return result == target_mask
end

@inline function digit_bounds(d)
    return (10^(d - 1), 10^d - 1)
end

function find_pandigital_products(n)
    @assert 4 <= n <= 9 "n must be between 4 and 9"

    products = Set{Int}()
    target_mask = (1 << n) - 1

    for (da, db, dc) in get_valid_digit_cases(n)
        (a_min, a_max) = digit_bounds(da)
        (b_min, b_max) = digit_bounds(db)
        (c_min, c_max) = digit_bounds(dc)

        for a in a_min:a_max
            # Tighten b bounds to ensure c has exactly dc digits
            b_lo = max(b_min, cld(c_min, a))
            b_hi = min(b_max, fld(c_max, a))

            # When da == db, start b from a to avoid (a,b)/(b,a) duplicates
            da == db && (b_lo = max(b_lo, a))

            for b in b_lo:b_hi
                c = a * b
                if c_min <= c <= c_max && is_pandigital_product(a, b, c, target_mask)
                    push!(products, c)
                end
            end
        end
    end

    return sum(products)
end

N = parse(Int, readline())
println(find_pandigital_products(N))
