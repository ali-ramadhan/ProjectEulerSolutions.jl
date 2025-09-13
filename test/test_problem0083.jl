using ProjectEulerSolutions.Problem0083: parse_matrix, find_minimal_path_sum, solve

# Test the example from the problem statement
example_matrix = """
131,673,234,103,18
201,96,342,965,150
630,803,746,422,111
537,699,497,121,956
805,732,524,37,331
"""

matrix = parse_matrix(example_matrix)
@test size(matrix) == (5, 5)
@test matrix[1, 1] == 131
@test matrix[5, 5] == 331

# The example should give 2297 (from top-left to bottom-right with 4-way movement)
@test find_minimal_path_sum(matrix) == 2297

# Test some special cases
# 1×1 matrix
single_element = reshape([10], 1, 1)
@test find_minimal_path_sum(single_element) == 10

# 2×2 matrix - test basic four-way movement
small_matrix = [1 3; 2 1]
@test find_minimal_path_sum(small_matrix) == 4  # Path: (1,1)=1 → (2,1)=2 → (2,2)=1

# Test single row (only right movement possible)
single_row = reshape([1, 2, 3, 4], 1, 4)
@test find_minimal_path_sum(single_row) == 10  # Path: 1→2→3→4

# Test single column (only down movement possible)
single_col = reshape([1, 2, 3, 4], 4, 1)
@test find_minimal_path_sum(single_col) == 10  # Path: 1→2→3→4

# Test matrix where backtracking (left/up movement) is crucial
# Matrix: [10  1  10]
#         [10 100  1]
#         [10  1  10]
# Optimal path: (1,1)→(1,2)→(3,2)→(3,3) = 10+1+1+10 = 32
backtrack_test = [10 1 10; 10 100 1; 10 1 10]
@test find_minimal_path_sum(backtrack_test) == 32

# Test 3×3 matrix where all four directions are needed
# Matrix: [1  10  10]
#         [10  1   1]
#         [10 10   1]
# Optimal: (1,1)→(2,2)→(2,3)→(3,3) = 1+1+1+1 = 14
four_way_test = [1 10 10; 10 1 1; 10 10 1]
@test find_minimal_path_sum(four_way_test) == 14

# Test matrix with uniform values
uniform_matrix = fill(5, 3, 3)
@test find_minimal_path_sum(uniform_matrix) == 25  # 5 cells: start + 4 moves, each costs 5

# Test rectangular matrix (more rows than columns)
rectangular_matrix = [1 2; 3 4; 5 6]
# Optimal path: (1,1)→(1,2)→(2,2)→(3,2) = 1+2+4+6 = 13
@test find_minimal_path_sum(rectangular_matrix) == 13

# Test wide matrix (more columns than rows)
wide_matrix = [1 5 5 1; 5 1 1 5]
# Optimal: (1,1)→(2,2)→(2,3)→(1,4) = 1+1+1+1 = 13
@test find_minimal_path_sum(wide_matrix) == 13

# Test empty matrix (edge case)
empty_matrix = Array{Int}(undef, 0, 0)
@test find_minimal_path_sum(empty_matrix) == 0

# Test matrix where straight diagonal isn't optimal
# Matrix: [1   100  100  1]
#         [100  1    1  100]
#         [100  1    1  100]
#         [1   100  100   1]
# Complex path through the matrix
diagonal_avoid = [1 100 100 1; 100 1 1 100; 100 1 1 100; 1 100 100 1]
# The algorithm finds the optimal path with cost 205
@test find_minimal_path_sum(diagonal_avoid) == 205

# Test solve function with actual data
@test solve() == 425185

# Test maze-like structure (inspired by AgentAnderson's visual path)
maze_matrix = [
    1 100 1 1 1;
    1 100 1 100 1;
    1 1 1 100 1;
    100 100 100 100 1;
    1 1 1 1 1
]

# Should find path avoiding the 100s where possible
@test find_minimal_path_sum(maze_matrix) == 13
