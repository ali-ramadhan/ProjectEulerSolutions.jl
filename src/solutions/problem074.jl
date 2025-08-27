"""
Project Euler Problem 74: Digit Factorial Chains

The number 145 is well known for the property that the sum of the factorial of its digits is
equal to 145: 1! + 4! + 5! = 1 + 24 + 120 = 145.

Perhaps less well known is 169, in that it produces the longest chain of numbers that link
back to 169; it turns out that there are only three such loops that exist:
169 → 363601 → 1454 → 169
871 → 45361 → 871
872 → 45362 → 872

It is not difficult to prove that EVERY starting number will eventually get stuck in a loop.
For example,
69 → 363600 → 1454 → 169 → 363601 (→ 1454)
78 → 45360 → 871 → 45361 (→ 871)
540 → 145 (→ 145)

Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating
chain with a starting number below one million is sixty terms.

How many chains, with a starting number below one million, contain exactly sixty
non-repeating terms?

## Solution approach

We compute chains by following the digit factorial sum sequence until we encounter a repeat.
The chain length is the number of unique terms before the repeat.

Key optimizations:
1. Memoization of digit factorial sums to avoid recomputation
2. Memoization of chain lengths for already computed starting points
3. Early termination when encountering known chain lengths

## Complexity analysis

Time complexity: O(n * d * log d)
- For each number up to n, we may compute a chain of at most d digits
- Each digit factorial sum takes O(log d) where d is the number of digits

Space complexity: O(n)
- Stores memoization caches for next values and chain lengths
"""
module Problem074

"""
    digit_factorial_sum(n)

Compute the sum of the factorials of the digits of n.
"""
function digit_factorial_sum(n)
    sum = 0
    while n > 0
        sum += factorial(n % 10)
        n = n ÷ 10
    end
    return sum
end

"""
    chain_length(start, next_cache, length_cache)

Compute the length of the chain for the given starting number.
The chain length is the number of unique numbers in the chain until we encounter a repeat.
"""
function chain_length(start, next_cache, length_cache)
    if haskey(length_cache, start)
        return length_cache[start]
    end

    seen = Set{Int}()
    num = start

    while !(num in seen)
        push!(seen, num)

        if haskey(next_cache, num)
            num = next_cache[num]
        else
            next = digit_factorial_sum(num)
            next_cache[num] = next
            num = next
        end
    end

    length_cache[start] = length(seen)
    return length(seen)
end

"""
    count_chains_with_length(limit, target_length)

Count how many starting numbers below the given limit have a chain length matching the
target length.
"""
function count_chains_with_length(limit, target_length)
    # Caches for memoization
    next_cache = Dict{Int, Int}()
    length_cache = Dict{Int, Int}()

    count = 0
    for n in 1:(limit - 1)
        if chain_length(n, next_cache, length_cache) == target_length
            count += 1
        end
    end

    return count
end

function solve()
    result = count_chains_with_length(1_000_000, 60)
    @info "Found $result chains with exactly 60 non-repeating terms below 1,000,000"
    return result
end

end # module
