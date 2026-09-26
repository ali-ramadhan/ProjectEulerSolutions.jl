# HackerRank ProjectEuler+ Problem 36: Double-base palindromes
# https://www.hackerrank.com/contests/projecteuler/challenges/euler036/problem
#
# Project Euler: https://projecteuler.net/problem=36
# Solution: https://aliramadhan.me/blog/project-euler/problem-0036/
#
# Problem Statement:
#   The decimal number, 585 = 1001001001_2 (binary), is palindromic in both
#   bases.
#
#   Find the sum of all natural numbers, less than N, which are palindromic in
#   base 10 and base K.
#
#   (Please note that the palindromic number, in either base, may not include
#   leading zeros.)
#
# Input Format:
#   Input contains two integers N and K.
#
# Constraints:
#   10 <= N <= 10^6
#   2 <= K <= 9
#
# Output Format:
#   Print the answer corresponding to the test case.
#
# Sample Input:
#   10 2
#
# Sample Output:
#   25

function is_palindrome(n, base)
    original = n
    reversed = 0
    while n > 0
        n, digit = divrem(n, base)
        reversed = reversed * base + digit
    end
    return reversed == original
end

# Append the digits of h in reverse. For an odd number of digits the last digit
# of h is the middle digit, so it is not repeated.
function make_palindrome(h, odd)
    p = h
    odd && (h ÷= 10)
    while h > 0
        h, digit = divrem(h, 10)
        p = 10p + digit
    end
    return p
end

# An L-digit palindrome is determined by its first ceil(L/2) digits, so we build
# every decimal palindrome below N from its first half and add up the ones that
# are also palindromes in base K. They come out in increasing order for each L.
function sum_double_base_palindromes(N, K)
    total = 0
    for L in 1:ndigits(N - 1)
        k = cld(L, 2)
        for h in 10^(k-1):10^k-1
            p = make_palindrome(h, isodd(L))
            p >= N && break
            is_palindrome(p, K) && (total += p)
        end
    end
    return total
end

N, K = parse.(Int, split(readline()))
println(sum_double_base_palindromes(N, K))
