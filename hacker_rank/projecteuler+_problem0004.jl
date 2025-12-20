# HackerRank ProjectEuler+ Problem 4: Largest Palindrome Product
# https://www.hackerrank.com/contests/projecteuler/challenges/euler004/problem
#
# Project Euler: https://projecteuler.net/problem=4
# Solution: https://aliramadhan.me/blog/project-euler/problem-0004/

function is_palindrome(n)
    s = string(n)
    return s == reverse(s)
end

function find_all_palindrome_products()
    palindromes = Set{Int}()

    for i in 100:999
        for j in i:999
            product = i * j
            if is_palindrome(product)
                push!(palindromes, product)
            end
        end
    end

    return sort(collect(palindromes))
end

# Precompute all palindrome products from 3-digit numbers
const PALINDROMES = find_all_palindrome_products()

function largest_palindrome_less_than(n)
    # Binary search for largest palindrome < n
    lo, hi = 1, length(PALINDROMES)
    result = 0

    while lo <= hi
        mid = div(lo + hi, 2)
        if PALINDROMES[mid] < n
            result = PALINDROMES[mid]
            lo = mid + 1
        else
            hi = mid - 1
        end
    end

    return result
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(largest_palindrome_less_than(N))
end
