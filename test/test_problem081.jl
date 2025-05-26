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

# Test solve function with example matrix
@test solve() == 427337
