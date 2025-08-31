"""
Project Euler Problem 115: Counting Block Combinations II

NOTE: This is a more difficult version of Problem 114.

A row measuring n units in length has red blocks with a minimum length of m units placed on
it, such that any two red blocks (which are allowed to be different lengths) are separated
by at least one black square.

Let the fill-count function, F(m, n), represent the number of ways that a row can be filled.

For example, F(3, 29) = 673135 and F(3, 30) = 1089155.

That is, for m = 3, it can be seen that n = 30 is the smallest value for which the
fill-count function first exceeds one million.

In the same way, for m = 10, it can be verified that F(10, 56) = 880711 and F(10, 57) =
1148904, so n = 57 is the least value for which the fill-count function first exceeds one
million.

For m = 50, find the least value of n for which the fill-count function first exceeds one
million.

## Solution approach

This problem extends problem 114 by asking us to find the minimum row length n where F(m, n)
> 1,000,000 for a given minimum block size m.

We use the same dynamic programming approach as problem 114:
- dp[i] = number of ways to fill a row of length i
- For each position, we can either place a black square or a red block of any valid length

The key difference is that we need to iterate through increasing values of n until we find
the first one where F(m, n) exceeds one million.

## Complexity analysis

Time complexity: O(n² × k) where n is the final row length and k is the number of iterations
needed to find the answer
- For each row length from 1 to n, we compute dp values in O(n²) time
- We repeat this process until we find a result > 1,000,000

Space complexity: O(n)
- We store dp values for positions 0 to n for the current row length being tested

## Key insights

Since F(m, n) grows rapidly with n, we don't expect to need very large values of n to exceed
one million. The problem gives us verification points that help validate our implementation.
"""
module Problem115

using ProjectEulerSolutions.Problem114: count_block_arrangements

"""
    find_min_length_exceeding_threshold(min_block_size, threshold)

Find the minimum row length n such that F(min_block_size, n) > threshold.
"""
function find_min_length_exceeding_threshold(min_block_size, threshold)
    n = min_block_size  # Start from a reasonable lower bound

    while true
        count = count_block_arrangements(n, min_block_size)
        if count > threshold
            return n
        end
        n += 1
    end
end

"""
    find_minimum_length_for_threshold(min_block_size, target_threshold)

Find the minimum row length where block arrangements exceed the target threshold and
provide verification of the result.
"""
function find_minimum_length_for_threshold(min_block_size, target_threshold)
    result = find_min_length_exceeding_threshold(min_block_size, target_threshold)

    # Verify our result
    count_at_result = count_block_arrangements(result, min_block_size)
    count_before = count_block_arrangements(result - 1, min_block_size)

    @info "For m=$min_block_size: F($min_block_size, $(result-1)) = $count_before, F($min_block_size, $result) = $count_at_result"
    @info "Found minimum length $result where F($min_block_size, n) first exceeds $target_threshold"

    return result
end

function solve()
    target_threshold = 1_000_000
    min_block_size = 50

    return find_minimum_length_for_threshold(min_block_size, target_threshold)
end

end # module
