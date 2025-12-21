# HackerRank ProjectEuler+ Problem 4: Largest Palindrome Product
# https://www.hackerrank.com/contests/projecteuler/challenges/euler004/problem
#
# Project Euler: https://projecteuler.net/problem=4
# Solution: https://aliramadhan.me/blog/project-euler/problem-0004/
#
# Problem Statement:
#   A palindromic number reads the same both ways. The smallest 6 digit palindrome
#   made from the product of two 3-digit numbers is 101101 = 143 × 707.
#   Find the largest palindrome made from the product of two 3-digit numbers
#   which is less than N.
#
# Input Format:
#   First line contains T that denotes the number of test cases.
#   This is followed by T lines, each containing an integer, N.
#
# Constraints:
#   1 ≤ T ≤ 100
#   101101 < N < 1000000
#
# Output Format:
#   Print the required answer for each test case in a new line.
#
# Sample Input:
#   2
#   101110
#   800000
#
# Sample Output:
#   101101
#   793397

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
