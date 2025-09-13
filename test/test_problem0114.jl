using Test
using ProjectEulerSolutions.Problem0114: count_block_arrangements, solve

# Test small cases where we can manually verify
# n=3: Two ways (all grey: GGG, or red block: RRR)
@test count_block_arrangements(3) == 2

# n=4: Four ways 
# - GGGG (all grey)
# - RRRG (red block of 3 + grey)
# - GRRR (grey + red block of 3)  
# - RRRR (red block of 4)
@test count_block_arrangements(4) == 4

# Test the example from the problem description
# n=7: Should have exactly 17 ways
@test count_block_arrangements(7) == 17

# Test some edge cases
# n=0: One way (empty row)
@test count_block_arrangements(0) == 1

# n=1: One way (single grey)
@test count_block_arrangements(1) == 1

# n=2: One way (two greys)  
@test count_block_arrangements(2) == 1

# Test with different minimum block sizes
# n=5 with min_block_size=2: More arrangements possible
@test count_block_arrangements(5, 2) > count_block_arrangements(5, 3)

# Test the final answer for n=50
@test solve() == count_block_arrangements(50)