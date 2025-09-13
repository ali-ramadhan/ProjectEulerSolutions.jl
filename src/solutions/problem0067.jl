"""
Project Euler Problem 67: Maximum Path Sum II

By starting at the top of the triangle below and moving to adjacent numbers on the row
below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom in triangle.txt, a 15K text file containing a
triangle with one-hundred rows.

NOTE: This is a much more difficult version of Problem 18. It is not possible to try every
route to solve this problem, as there are 2^99 altogether! If you could check one trillion
(10^12) routes every second it would take over twenty billion years to check them all. There
is an efficient algorithm to solve it. ;o)

## Solution approach

This solution uses bottom-up dynamic programming to efficiently find the maximum path sum:
1. Read the triangle from the data file into a 2D array structure
2. Starting from the second-to-last row, work upward
3. For each position, add the maximum of the two possible children from the row below
4. Continue until reaching the top, which contains the maximum path sum
5. This approach avoids exploring 2^99 possible paths by using optimal substructure

## Complexity analysis

Time complexity: O(N²) where N = 100 is the number of rows
- Process each element in the triangle exactly once
- Total elements in triangle: 1 + 2 + ... + 100 = 5050

Space complexity: O(N²)
- Store the entire triangle in memory
- Could be optimized to O(N) by processing in-place or using only two rows

## Key insights

The key insight is that this problem has optimal substructure: the maximum path to any
position is the position's value plus the maximum of the paths to its two children. This
allows dynamic programming to reduce an exponential-time brute force approach to polynomial
time.
"""
module Problem0067

"""
    parse_triangle(filename)

Read a triangle from the given file, where each line contains space-separated integers
representing a row of the triangle.
"""
function parse_triangle(filename)
    lines = readlines(filename)
    triangle = Vector{Vector{Int}}()

    for line in lines
        row = parse.(Int, split(line))
        push!(triangle, row)
    end

    return triangle
end

"""
    find_maximum_path_sum(triangle)

Find the maximum path sum in the triangle using a bottom-up dynamic programming approach.
This algorithm has O(n^2) time complexity where n is the number of rows in the triangle.
"""
function find_maximum_path_sum(triangle)
    dp_triangle = deepcopy(triangle)

    # Start from the second-to-last row and work upward
    for row in (length(triangle) - 1):-1:1
        for col in 1:length(triangle[row])
            # For each position, add the maximum of the two possible children
            left_child = dp_triangle[row + 1][col]
            right_child = dp_triangle[row + 1][col + 1]
            dp_triangle[row][col] += max(left_child, right_child)
        end
    end

    # The top element now contains the maximum path sum
    return dp_triangle[1][1]
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0067_triangle.txt")
    triangle = parse_triangle(data_filepath)
    return find_maximum_path_sum(triangle)
end

end # module
