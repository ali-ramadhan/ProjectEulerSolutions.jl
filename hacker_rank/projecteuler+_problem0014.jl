# HackerRank ProjectEuler+ Problem 14: Longest Collatz Sequence
# https://www.hackerrank.com/contests/projecteuler/challenges/euler014/problem
#
# Project Euler: https://projecteuler.net/problem=14
# Solution: https://aliramadhan.me/blog/project-euler/problem-0014/

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
