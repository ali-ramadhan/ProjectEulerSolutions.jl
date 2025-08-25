using ProjectEulerSolutions.Problem082:
    parse_matrix, find_minimal_path_sum_three_ways, solve

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

# The example should give 994 (starting from any left column cell to any right column cell)
@test find_minimal_path_sum_three_ways(matrix) == 994

# Test some special cases
# 1×1 matrix
single_element = reshape([10], 1, 1)
@test find_minimal_path_sum_three_ways(single_element) == 10

# 2×2 matrix - test basic three-way movement
small_matrix = [1 3; 2 1]
@test find_minimal_path_sum_three_ways(small_matrix) == 3  # Path: 2→1

# Test single row (only right movement possible)
single_row = reshape([1, 2, 3, 4], 1, 4)
@test find_minimal_path_sum_three_ways(single_row) == 10  # Path: 1→2→3→4

# Test single column (start anywhere, end at same position)
single_col = reshape([1, 2, 3, 4], 4, 1)
@test find_minimal_path_sum_three_ways(single_col) == 1  # Best start is position 1

# Test matrix where vertical movement is crucial
# Matrix: [10  1]
#         [ 1 10]
# Optimal: start at (2,1), move to (1,1), then to (1,2) = 1+10+1 = 12
# vs direct paths: (1,1)→(1,2) = 10+1 = 11, or (2,1)→(2,2) = 1+10 = 11
vertical_test = [10 1; 1 10]
@test find_minimal_path_sum_three_ways(vertical_test) == 11

# Test 3-column matrix where up/down movement within column is beneficial
# Matrix: [5 1 5]
#         [1 5 1]
#         [5 1 5]
# Best path: start (2,1)=1, move to (1,2)=1 or (3,2)=1, then to (2,3)=1 = 1+1+1 = 3
# But actually all paths cost the same: 1+1+5=7 or 5+1+1=7
zigzag_matrix = [5 1 5; 1 5 1; 5 1 5]
@test find_minimal_path_sum_three_ways(zigzag_matrix) == 7

# Test matrix with uniform values
uniform_matrix = fill(5, 3, 3)
@test find_minimal_path_sum_three_ways(uniform_matrix) == 15  # 3 steps, each costs 5

# Test a more complex case where vertical movement within column is essential
# Matrix: [100 100 1]
#         [  1   1 100]
#         [100   1 100]
# Best path: start at (2,1)=1, move right to (2,2)=1, then move up/down within col 2, then move right to (2,3)=100
# The algorithm finds: start (2,1)=1 → (2,2)=1 → (2,3)=100, total = 102
complex_vertical = [100 100 1; 1 1 100; 100 1 100]
@test find_minimal_path_sum_three_ways(complex_vertical) == 102

# Test rectangular matrix (more rows than columns)
rectangular_matrix = [1 2 3; 4 5 6; 7 8 9; 10 11 12]
# Best path likely: start at (1,1), move right: 1→2→3 = 6
@test find_minimal_path_sum_three_ways(rectangular_matrix) == 6

# Test another rectangular matrix (more columns than rows)
wide_matrix = [1 5 5 5 1; 5 1 1 1 5]
# Best path: start at (2,1), move right: 5→1→1→1→5 = 13
# or start at (1,1), move down to (2,1), then right: 1+5+1+1+1+5 = 14
# Actually: start at (1,1): 1+5+5+5+1 = 17, start at (2,1): 5+1+1+1+5 = 13
@test find_minimal_path_sum_three_ways(wide_matrix) == 13

# Test solve function with actual data
@test solve() == 260324
