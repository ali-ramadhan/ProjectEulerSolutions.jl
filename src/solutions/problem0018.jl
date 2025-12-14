"""
Project Euler Problem 18: Maximum Path Sum I

Problem description: https://projecteuler.net/problem=18
Solution description: https://aliramadhan.me/blog/project-euler/problem-0018/
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
