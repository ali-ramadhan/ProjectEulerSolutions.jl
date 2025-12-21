# HackerRank ProjectEuler+ Problem 17: Number to Words
# https://www.hackerrank.com/contests/projecteuler/challenges/euler017/problem
#
# Project Euler: https://projecteuler.net/problem=17
# Solution: https://aliramadhan.me/blog/project-euler/problem-0017/
#
# Problem Statement:
# The numbers 1 to 5 written out in words are: One, Two, Three, Four, Five
# First character of each word will be capital letter.
# Given a number, you have to write it in words.
#
# Example: 10438242112 is "One Hundred Four Billion Three Hundred Eighty Two
# Million Four Hundred Twenty Four Thousand One Hundred Twelve"
#
# Input Format:
# - First line contains T (number of test cases)
# - Next T lines contain an integer N
#
# Constraints:
# - 1 <= T <= 10
# - 0 <= N <= 10^12
#
# Output Format:
#   Print the number in words for each test case.
#
# Sample Input:
#   2
#   10
#   17
#
# Sample Output:
#   Ten
#   Seventeen

const ONES = Dict(
    1 => "One",
    2 => "Two",
    3 => "Three",
    4 => "Four",
    5 => "Five",
    6 => "Six",
    7 => "Seven",
    8 => "Eight",
    9 => "Nine",
)

const TEENS = Dict(
    10 => "Ten",
    11 => "Eleven",
    12 => "Twelve",
    13 => "Thirteen",
    14 => "Fourteen",
    15 => "Fifteen",
    16 => "Sixteen",
    17 => "Seventeen",
    18 => "Eighteen",
    19 => "Nineteen",
)

const TENS = Dict(
    2 => "Twenty",
    3 => "Thirty",
    4 => "Forty",
    5 => "Fifty",
    6 => "Sixty",
    7 => "Seventy",
    8 => "Eighty",
    9 => "Ninety",
)

function convert_chunk(n::Int)
    # Converts 1-999 to words
    parts = String[]

    if n >= 100
        hundreds = div(n, 100)
        push!(parts, ONES[hundreds] * " Hundred")
        n = mod(n, 100)
    end

    if n >= 20
        tens_digit = div(n, 10)
        ones_digit = mod(n, 10)
        if ones_digit == 0
            push!(parts, TENS[tens_digit])
        else
            push!(parts, TENS[tens_digit] * " " * ONES[ones_digit])
        end
    elseif n >= 10
        push!(parts, TEENS[n])
    elseif n > 0
        push!(parts, ONES[n])
    end

    return join(parts, " ")
end

function number_to_words(n::Int)
    if n == 0
        return "Zero"
    end

    parts = String[]

    # Trillions
    if n >= 1_000_000_000_000
        trillions = div(n, 1_000_000_000_000)
        push!(parts, convert_chunk(trillions) * " Trillion")
        n = mod(n, 1_000_000_000_000)
    end

    # Billions
    if n >= 1_000_000_000
        billions = div(n, 1_000_000_000)
        push!(parts, convert_chunk(billions) * " Billion")
        n = mod(n, 1_000_000_000)
    end

    # Millions
    if n >= 1_000_000
        millions = div(n, 1_000_000)
        push!(parts, convert_chunk(millions) * " Million")
        n = mod(n, 1_000_000)
    end

    # Thousands
    if n >= 1_000
        thousands = div(n, 1_000)
        push!(parts, convert_chunk(thousands) * " Thousand")
        n = mod(n, 1_000)
    end

    # Remainder (0-999)
    if n > 0
        push!(parts, convert_chunk(n))
    end

    return join(parts, " ")
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(number_to_words(N))
end
