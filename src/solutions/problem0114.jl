"""
Project Euler Problem 114: Counting Block Combinations I

A row measuring seven units in length has red blocks with a minimum length of three units
placed on it, such that any two red blocks (which are allowed to be different lengths) are
separated by at least one grey square. There are exactly seventeen ways of doing this.

How many ways can a row measuring fifty units in length be filled?

NOTE: Although the example above does not lend itself to the possibility, in general it is
permitted to mix block sizes. For example, on a row measuring eight units in length you
could use red (3), grey (1), and red (4).

## Solution approach

This is a dynamic programming problem. Let dp[i] represent the number of ways to fill a row
of length i following the block placement rules.

For each position in a row of length i, we have two choices:
1. Place a grey square (1 unit): This gives us dp[i-1] ways to fill the remaining i-1 units
2. Place a red block of length k ≥ 3 followed by a mandatory grey separator: This
   contributes dp[i-k-1] ways for each valid k

The recurrence relation is:
- dp[0] = 1 (empty row has one way: place nothing)
- dp[i] = dp[i-1] + sum(dp[i-k-1] for k in 3:i if i-k-1 ≥ 0)

The sum accounts for red blocks of length 3, 4, 5, ..., up to the maximum that fits.

## Complexity analysis

Time complexity: O(n²)
- We compute dp values for positions 0 to n
- For each position i, we consider O(i) possible red block lengths
- Total operations: sum(i for i in 1:n) = O(n²)

Space complexity: O(n)
- We store dp values for positions 0 to n

## Key insights

The mandatory grey separator after each red block ensures that red blocks are properly
separated. This simplifies the state transition since we don't need to track the color
of the last placed element - every red block placement automatically includes its separator.
"""
module Problem0114

"""
    count_block_arrangements(n, min_block_size=3)

Count the number of ways to arrange red blocks (minimum length min_block_size) and grey
squares in a row of length n, where red blocks must be separated by at least one grey
square.

Uses dynamic programming where dp[i] represents the number of arrangements for a row of
length i.
"""
function count_block_arrangements(n, min_block_size=3)
    # dp[i] = number of ways to fill row of length i
    dp = zeros(Int, n + 1)
    dp[1] = 1  # Base case: empty row has one arrangement

    for i in 1:n
        # Option 1: Place a grey square (1 unit)
        dp[i + 1] = dp[i]

        # Option 2: Place red block of length k (k ≥ min_block_size) followed by grey
        # separator
        for k in min_block_size:i
            # Need at least k units for the red block + 1 for mandatory grey separator
            # But if k fills the entire remaining space, no separator needed
            if k == i
                # Red block fills exactly the remaining space
                dp[i + 1] += dp[1]  # Just the empty case
            elseif k < i  # k + 1 ≤ i (room for red block + separator)
                # Red block of length k + 1 grey separator, leaving i - k - 1 units
                dp[i + 1] += dp[i - k]
            end
        end
    end

    return dp[n + 1]
end

function solve()
    result = count_block_arrangements(50)
    @info "Found $result ways to arrange blocks in a row of length 50"
    return result
end

end # module
