using Test
using ProjectEulerSolutions.Problem0117: count_mixed_tile_arrangements, solve

# Test the given example: 5-unit row should have 15 different ways
@test count_mixed_tile_arrangements(5) == 15

# Test smaller cases
@test count_mixed_tile_arrangements(0) == 1  # Empty row
@test count_mixed_tile_arrangements(1) == 1  # Only grey tile
@test count_mixed_tile_arrangements(2) == 2  # Grey+grey or red
@test count_mixed_tile_arrangements(3) == 4  # Grey+grey+grey, red+grey, grey+red, green
@test count_mixed_tile_arrangements(4) == 8  # Multiple combinations including blue

# Correct answer for the actual problem
@test solve() == 100808458960497
