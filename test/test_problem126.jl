using Test
using ProjectEulerSolutions.Problem126: layer_cubes, find_layer_with_count, solve

# Test the layer calculation formula with examples from the problem
@test layer_cubes(3, 2, 1, 1) == 22
@test layer_cubes(3, 2, 1, 2) == 46
@test layer_cubes(3, 2, 1, 3) == 78
@test layer_cubes(3, 2, 1, 4) == 118

# Test other cuboids mentioned in the problem
@test layer_cubes(5, 1, 1, 1) == 22
@test layer_cubes(5, 3, 1, 1) == 46
@test layer_cubes(7, 2, 1, 1) == 46
@test layer_cubes(11, 1, 1, 1) == 46

# Test some edge cases
@test layer_cubes(1, 1, 1, 1) == 6   # Single cube needs 6 cubes to cover
@test layer_cubes(1, 1, 1, 2) == 18  # Second layer around single cube

# Correct answer
@test solve() == 18522
