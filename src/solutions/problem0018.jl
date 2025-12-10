"""
Project Euler Problem 18: Maximum Path Sum I

By starting at the top of the triangle below and moving to adjacent numbers on the row
below, the maximum total from top to bottom is 23.

3
7 4
2 4 6
8 5 9 3

That is, 3 + 7 + 4 + 9 = 23.

Find the maximum total from top to bottom of the triangle below:

75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every
route. However, Problem 67, is the same challenge with a triangle containing one-hundred
rows; it cannot be solved by brute force, and requires a clever method!

## Solution approach

We use dynamic programming with a bottom-up approach:
1. Start from the second-to-last row of the triangle
2. For each position, add the maximum of the two adjacent values below it
3. Work our way up to the top, where the final answer will be stored

This works because the problem has optimal substructure: the best path from any
position is its value plus the best path from whichever child leads to a higher sum.
By solving bottom-up, each subproblem is already solved when we need it. Note that
a greedy top-down approach (always picking the larger child) would fail.

## Complexity analysis

Time complexity: O(n²)
- We visit each element in the triangle exactly once
- Triangle with n rows has n(n+1)/2 elements total
- Each element requires constant-time operations

Space complexity: O(n²)
- We create a deep copy of the triangle to avoid modifying the original
- Could be optimized to O(n) by processing in-place or using a single row
"""
module Problem0018

const TRIANGLE = [
    [75],
    [95, 64],
    [17, 47, 82],
    [18, 35, 87, 10],
    [20, 4, 82, 47, 65],
    [19, 1, 23, 75, 3, 34],
    [88, 2, 77, 73, 7, 63, 67],
    [99, 65, 4, 28, 6, 16, 70, 92],
    [41, 41, 26, 56, 83, 40, 80, 70, 33],
    [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
    [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
    [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
    [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
    [63, 66, 4, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
    [4, 62, 98, 27, 23, 9, 70, 98, 73, 93, 38, 53, 60, 4, 23],
]

"""
    max_path_sum(triangle)

Find the maximum path sum from top to bottom of the given triangle.
Uses dynamic programming by starting from the bottom row and working upwards.
For each position, we choose the maximum of the two possible paths below.
"""
function max_path_sum(triangle)
    max_sums = deepcopy(triangle)

    # Start from the second-to-last row and work upwards
    for i in (length(max_sums) - 1):-1:1
        for j in 1:length(max_sums[i])
            # Add the maximum of the two adjacent values in the row below
            max_sums[i][j] += max(max_sums[i + 1][j], max_sums[i + 1][j + 1])
        end
    end

    # The top of the triangle now contains the maximum path sum
    return max_sums[1][1]
end

function solve()
    return max_path_sum(TRIANGLE)
end

end # module
