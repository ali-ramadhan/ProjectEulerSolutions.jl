"""
Project Euler Problem 82: Path Sum: Three Ways

NOTE: This problem is a more challenging version of Problem 81.

The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the left column and
finishing in any cell in the right column, and only moving up, down, and right, is indicated
in red and bold; the sum is equal to 994.

[Matrix representation shown in the problem statement]

Find the minimal path sum from the left column to the right column in matrix.txt,
a 31K text file containing an 80 by 80 matrix.
"""
module Problem082

"""
    parse_matrix(str)

Parse a matrix from a string where each row is a comma-separated list of numbers.
Returns a 2D array of integers.
"""
function parse_matrix(str)
    lines = split(strip(str), r"\r?\n")
    rows = length(lines)

    # Determine number of columns based on first row
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

"""
    read_matrix(filename)

Read a matrix from a file where each row is a comma-separated list of numbers.
"""
function read_matrix(filename)
    content = read(filename, String)
    return parse_matrix(content)
end

"""
    find_minimal_path_sum_three_ways(matrix)

Calculate the minimal path sum from any cell in the leftmost column to any cell
in the rightmost column, moving only right, up, and down.

Uses dynamic programming to efficiently calculate minimal path sum. For each column j:
1. First compute paths coming directly from the left (col j-1)
2. Then iteratively update by considering paths that move up or down within column j
   until no more improvements are found.

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
