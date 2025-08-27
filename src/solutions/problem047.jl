"""
Project Euler Problem 47: Distinct Primes Factors

The first two consecutive numbers to have two distinct prime factors are:
14 = 2 × 7
15 = 3 × 5.

The first three consecutive numbers to have three distinct prime factors are:
644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Find the first four consecutive integers to have four distinct prime factors each.
What is the first of these numbers?

## Solution approach

Iterate through integers, counting distinct prime factors for each.
Keep track of consecutive integers with the target number of distinct prime factors.
Reset the counter whenever an integer doesn't have exactly four distinct prime factors.

## Complexity analysis

Time complexity: O(N × √M)
- Check N numbers until finding the sequence
- Factoring each number M takes O(√M) time in worst case

Space complexity: O(F)
- Store prime factors for counting (F factors per number)
"""
module Problem047

using ProjectEulerSolutions.Utils.Primes: prime_factors

"""
    count_distinct_prime_factors(n)

Count the number of distinct prime factors of n.
"""
function count_distinct_prime_factors(n)
    n <= 1 && return 0
    return length(Set(prime_factors(n)))
end

"""
    find_consecutive_with_distinct_prime_factors(consecutive_count, factor_count)

Find the first sequence of consecutive_count integers where each has exactly
factor_count distinct prime factors.

Returns the first number in the sequence.
"""
function find_consecutive_with_distinct_prime_factors(consecutive_count, factor_count)
    consecutive = 0
    n = 2

    while consecutive < consecutive_count
        if count_distinct_prime_factors(n) == factor_count
            consecutive += 1
        else
            consecutive = 0
        end

        n += 1

        if consecutive == consecutive_count
            return n - consecutive_count
        end
    end

    return -1
end

function solve()
    result = find_consecutive_with_distinct_prime_factors(4, 4)
    @info "Found first of 4 consecutive integers with 4 distinct prime factors: $result"
    return result
end

end # module
