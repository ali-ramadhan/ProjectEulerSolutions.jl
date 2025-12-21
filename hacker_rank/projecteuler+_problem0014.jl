# HackerRank ProjectEuler+ Problem 14: Longest Collatz Sequence
# https://www.hackerrank.com/contests/projecteuler/challenges/euler014/problem
#
# Project Euler: https://projecteuler.net/problem=14
# Solution: https://aliramadhan.me/blog/project-euler/problem-0014/
#
# Problem Statement:
#   The following iterative sequence is defined for the set of positive integers:
#     n → n/2 (n is even)
#     n → 3n + 1 (n is odd)
#
#   Using the rule above and starting with 13, we generate the following sequence:
#     13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
#   It can be seen that this sequence (starting at 13 and finishing at 1) contains
#   10 terms. Although it has not been proved yet (Collatz Problem), it is thought
#   that all starting numbers finish at 1.
#
#   Which starting number, ≤ N, produces the longest chain? If many possible such
#   numbers are there print the maximum one.
#
#   Note: Once the chain starts the terms are allowed to go above N.
#
# Input Format:
#   The first line contains an integer T, i.e., number of test cases.
#   Next T lines will contain an integer N.
#
# Constraints:
#   1 ≤ T ≤ 10^4
#   1 ≤ N ≤ 5 × 10^6
#
# Output Format:
#   Print the values corresponding to each test case.

function collatz_length(n, cache)
    if n == 1
        return 1
    end

    if haskey(cache, n)
        return cache[n]
    end

    if iseven(n)
        len = 1 + collatz_length(div(n, 2), cache)
    else
        len = 1 + collatz_length(3n + 1, cache)
    end

    cache[n] = len
    return len
end

function precompute_longest_collatz(limit)
    cache = Dict{Int,Int}(1 => 1)

    # best[n] = starting number <= n with longest Collatz chain
    # (preferring larger numbers on ties)
    best = Vector{Int}(undef, limit)

    max_length = 0
    max_start = 0

    for start in 1:limit
        len = collatz_length(start, cache)
        # Use >= to prefer larger starting numbers on ties
        if len >= max_length
            max_length = len
            max_start = start
        end
        best[start] = max_start
    end

    return best
end

# Find max N across all test cases to precompute up to that limit
T = parse(Int, readline())
queries = Vector{Int}(undef, T)
for i in 1:T
    queries[i] = parse(Int, readline())
end

max_n = maximum(queries)
best = precompute_longest_collatz(max_n)

for n in queries
    println(best[n])
end
