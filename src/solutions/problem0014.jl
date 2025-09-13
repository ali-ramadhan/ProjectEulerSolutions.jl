"""
Project Euler Problem 14: Longest Collatz Sequence

The following iterative sequence is defined for the set of positive integers:
n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:
13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
Although it has not been proved yet (Collatz Problem), it is thought that all starting
numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.

## Solution approach

We use memoization (dynamic programming) to avoid recalculating Collatz sequence
lengths for numbers we've already seen. For each starting number from 1 to 999,999:
1. Calculate its Collatz sequence length using the recursive formula
2. Cache results to speed up future calculations
3. Track the number that produces the longest sequence

The memoization is crucial because many sequences overlap (e.g., the sequence
starting from 4 appears within the sequence starting from 8).

## Complexity analysis

Time complexity: O(n × log(max_value))
- We examine n starting numbers (up to 1,000,000)
- Each sequence length calculation takes O(log(max_value)) time on average
- Memoization reduces redundant calculations significantly

Space complexity: O(n)
- We store memoization cache that can grow up to O(n) entries
- Cache size depends on the range of numbers encountered during sequence generation
"""
module Problem0014

"""
    collatz_length(n, cache)

Calculate the length of the Collatz sequence starting at n.
Uses memoization to avoid recalculating lengths for previously seen numbers.
"""
function collatz_length(n, cache)
    if n == 1
        return 1
    end

    if haskey(cache, n)
        return cache[n]
    end

    if n % 2 == 0
        length = 1 + collatz_length(n ÷ 2, cache)
    else
        length = 1 + collatz_length(3n + 1, cache)
    end

    cache[n] = length
    return length
end

"""
    longest_collatz_under(limit)

Find the starting number under limit that produces the longest Collatz sequence.
Uses memoization for efficiency when calculating sequence lengths.
"""
function longest_collatz_under(limit)
    cache = Dict(1 => 1)

    max_length = 0
    max_start = 0

    for start in 1:(limit - 1)
        length = collatz_length(start, cache)
        if length > max_length
            max_length = length
            max_start = start
        end
    end

    return max_start, max_length
end

function solve()
    result, max_length = longest_collatz_under(1_000_000)
    @info "Number $result has longest Collatz sequence with $max_length terms"
    return result
end

end # module
