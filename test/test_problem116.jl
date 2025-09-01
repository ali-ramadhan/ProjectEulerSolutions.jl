using Test
using ProjectEulerSolutions.Problem116: count_tile_arrangements, solve

# Test the example from the problem description for a 5-unit row
# Red tiles (2 units): should have 7 ways (excluding all-grey)
@test count_tile_arrangements(5, 2) - 1 == 7

# Green tiles (3 units): should have 3 ways (excluding all-grey)
@test count_tile_arrangements(5, 3) - 1 == 3

# Blue tiles (4 units): should have 2 ways (excluding all-grey)
@test count_tile_arrangements(5, 4) - 1 == 2

# Test base cases
# n=0: One arrangement (empty)
@test count_tile_arrangements(0, 2) == 1
@test count_tile_arrangements(0, 3) == 1
@test count_tile_arrangements(0, 4) == 1

# n=1: One arrangement (single grey)
@test count_tile_arrangements(1, 2) == 1
@test count_tile_arrangements(1, 3) == 1
@test count_tile_arrangements(1, 4) == 1

# Test small cases manually
# n=2, tile_size=2: 2 ways (GG or RR)
@test count_tile_arrangements(2, 2) == 2

# n=3, tile_size=2: 3 ways (GGG, RRG, GRR)
@test count_tile_arrangements(3, 2) == 3

# n=3, tile_size=3: 2 ways (GGG or RRR)
@test count_tile_arrangements(3, 3) == 2

# n=4, tile_size=2: 5 ways (GGGG, RRGG, GRRG, GGRR, RRRR)
@test count_tile_arrangements(4, 2) == 5

# n=4, tile_size=3: 3 ways (GGGG, RRRG, GRRR)
@test count_tile_arrangements(4, 3) == 3

# n=4, tile_size=4: 2 ways (GGGG, RRRR)
@test count_tile_arrangements(4, 4) == 2

# Test that larger tile sizes give fewer or equal arrangements
@test count_tile_arrangements(10, 2) >= count_tile_arrangements(10, 3)
@test count_tile_arrangements(10, 3) >= count_tile_arrangements(10, 4)

# Correct answer
@test solve() == 20492570929
