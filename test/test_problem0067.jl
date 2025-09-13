using Test
using ProjectEulerSolutions.Problem0067: parse_triangle, find_maximum_path_sum, solve

# Create test file and verify parsing
test_triangle_str = """
3
7 4
2 4 6
8 5 9 3
"""

open("test_triangle.txt", "w") do io
    return write(io, test_triangle_str)
end

test_triangle = parse_triangle("test_triangle.txt")
@test length(test_triangle) == 4

rm("test_triangle.txt")

@test test_triangle[1] == [3]
@test test_triangle[2] == [7, 4]
@test test_triangle[3] == [2, 4, 6]
@test test_triangle[4] == [8, 5, 9, 3]

# Test maximum path sum on the small example triangle
@test find_maximum_path_sum(test_triangle) == 23

@test solve() == 7273
