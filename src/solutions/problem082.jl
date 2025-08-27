"""
Project Euler Problem 82: Path Sum: Three Ways

NOTE: This problem is a more challenging version of Problem 81.

The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the left column
and finishing in any cell in the right column, and only moving up, down, and right, is
indicated in red and bold; the sum is equal to 994.

131 673 234 103  18
201  96 342 965 150
630 803 746 422 111
537 699 497 121 956
805 732 524  37 331

Find the minimal path sum from the left column to the right column in matrix.txt, a 31K text
file containing an 80 by 80 matrix.

## Solution approach

This extends the basic DP approach from Problem 81 by allowing vertical movement within each
column. We process the matrix column by column from left to right. For each column, we:

1. Initialize minimal path sums from direct left movement
2. Iteratively improve these sums by considering up/down movement within the current column
3. Continue until no further improvements are possible

The key insight is that within each column, we need to consider paths that go up or down to
find better intermediate positions before continuing right.

## Complexity analysis

Time complexity: O(m × n × m)
- For each of the n columns, we potentially iterate O(m) times over the m rows
- In the worst case, each cell in a column might need updating multiple times

Space complexity: O(m × n)
- We store the DP table for the entire matrix
- Could be optimized to O(m) by processing one column at a time
"""
module Problem082

using ..Problem081: parse_matrix, read_matrix

"""
    find_minimal_path_sum_three_ways(matrix)

Calculate the minimal path sum from any cell in the leftmost column to any cell in the
rightmost column, moving only right, up, and down.

Uses dynamic programming to efficiently calculate minimal path sum. For each column j:

 1. First compute paths coming directly from the left (col j-1)
 2. Then iteratively update by considering paths that move up or down within column j until
    no more improvements are found.

Returns the minimum path sum to the rightmost column.
"""
function find_minimal_path_sum_three_ways(matrix)
    rows, cols = size(matrix)

    # Initialize DP table
    dp = Array{Int}(undef, rows, cols)

    # Base case: leftmost column
    for i in 1:rows
        dp[i, 1] = matrix[i, 1]
    end

    # Process each column from left to right
    for j in 2:cols
        # First, consider direct paths from the left
        for i in 1:rows
            dp[i, j] = dp[i, j - 1] + matrix[i, j]
        end

        # Iteratively update the minimum paths until no more improvements are found
        while true
            old_dp = copy(dp[:, j])

            # Top-down pass: consider paths from above
            for i in 2:rows
                dp[i, j] = min(dp[i, j], dp[i - 1, j] + matrix[i, j])
            end

            # Bottom-up pass: consider paths from below
            for i in (rows - 1):-1:1
                dp[i, j] = min(dp[i, j], dp[i + 1, j] + matrix[i, j])
            end

            # Check if there was any change
            if dp[:, j] == old_dp
                break
            end
        end
    end

    # The result is the minimum value in the rightmost column
    return minimum(dp[:, cols])
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0082_matrix.txt")
    matrix = read_matrix(data_filepath)
    return find_minimal_path_sum_three_ways(matrix)
end

end # module
