using ProjectEulerSolutions.Problem081: parse_matrix, find_minimal_path_sum, solve

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

@test find_minimal_path_sum(matrix) == 2427

# Test some special cases
# 1×1 matrix
single_element = [10]
@test find_minimal_path_sum(reshape(single_element, 1, 1)) == 10

# 2×2 matrix
small_matrix = [1 3; 2 1]
@test find_minimal_path_sum(small_matrix) == 4

# Test rectangular matrices (non-square)
rectangular_matrix = [1 2 3; 4 5 6]
@test find_minimal_path_sum(rectangular_matrix) == 12  # Path: 1→2→3→6

# Test single row
single_row = reshape([1, 2, 3, 4], 1, 4)
@test find_minimal_path_sum(single_row) == 10  # Path: 1→2→3→4

# Test single column  
single_col = reshape([1, 2, 3, 4], 4, 1)
@test find_minimal_path_sum(single_col) == 10  # Path: 1→2→3→4

# Test matrix with uniform values
uniform_matrix = fill(5, 3, 3)
@test find_minimal_path_sum(uniform_matrix) == 25  # Path: 5×5 (5 steps total)

# Test another small example to verify path logic
# Matrix: [1 9 9]
#         [9 1 9] 
#         [9 9 1]
# Optimal path: 1→9→1→9→1 = 21 (only right/down moves allowed)
zigzag_matrix = [1 9 9; 9 1 9; 9 9 1]
@test find_minimal_path_sum(zigzag_matrix) == 21

# Test solve function with actual data
@test solve() == 427337
