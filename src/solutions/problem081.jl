"""
Project Euler Problem 81: Path Sum: Two Ways

In the 5×5 matrix below, the minimal path sum from the top left to the bottom right, by only
moving to the right and down, is indicated in bold red and is equal to 2427.

131 673 234 103  18
201  96 342 965 150
630 803 746 422 111
537 699 497 121 956
805 732 524  37 331

Find the minimal path sum from the top left to the bottom right by only moving right and
down in matrix.txt, a 31K text file containing an 80×80 matrix.

## Solution approach

This is a classic dynamic programming problem. We build a solution bottom-up by computing
the minimal path sum to each cell (i,j) based on the minimal sums to its neighboring cells.
Since we can only move right and down, each cell can only be reached from the cell above
or the cell to its left.

The recurrence relation is:
dp[i][j] = matrix[i][j] + min(dp[i-1][j], dp[i][j-1])

We initialize the first row and first column, then fill the DP table systematically.

## Complexity analysis

Time complexity: O(m × n)
- We visit each cell in the matrix exactly once
- Each cell requires constant time to process

Space complexity: O(m × n)
- We store the DP table of the same size as the input matrix
- Could be optimized to O(min(m, n)) by keeping only the current and previous row/column
"""
module Problem081

# Matrix parsing utilities (used by Problems 82 and 83)
function parse_matrix(str)
    lines = split(strip(str), r"\r?\n")
    rows = length(lines)
    cols = length(split(lines[1], ','))
    matrix = Array{Int}(undef, rows, cols)
    for (i, line) in enumerate(lines)
        nums = split(line, ',')
        for (j, num) in enumerate(nums)
            matrix[i, j] = parse(Int, num)
        end
    end
    return matrix
end

function read_matrix(filename)
    content = read(filename, String)
    return parse_matrix(content)
end

"""
    find_minimal_path_sum(matrix)

Calculate the minimal path sum from the top left to the bottom right of the matrix, only
moving right and down.

Uses dynamic programming to efficiently calculate minimal path sum. For each cell (i,j), the
minimal path sum is:
min_path_sum(i,j) = matrix[i,j] + min(min_path_sum(i-1,j), min_path_sum(i,j-1))

Returns the minimum path sum to the bottom-right corner.
"""
function find_minimal_path_sum(matrix)
    rows, cols = size(matrix)

    # Initialize DP table
    dp = Array{Int}(undef, rows, cols)

    # Base case: top-left corner
    dp[1, 1] = matrix[1, 1]

    # Fill the first row (can only come from the left)
    for j in 2:cols
        dp[1, j] = dp[1, j - 1] + matrix[1, j]
    end

    # Fill the first column (can only come from above)
    for i in 2:rows
        dp[i, 1] = dp[i - 1, 1] + matrix[i, 1]
    end

    # Fill the rest of the DP table
    for i in 2:rows
        for j in 2:cols
            dp[i, j] = matrix[i, j] + min(dp[i - 1, j], dp[i, j - 1])
        end
    end

    return dp[rows, cols]
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0081_matrix.txt")
    matrix = read_matrix(data_filepath)
    return find_minimal_path_sum(matrix)
end

end # module
