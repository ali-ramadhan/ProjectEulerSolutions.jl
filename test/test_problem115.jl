using Test
using ProjectEulerSolutions.Problem114: count_block_arrangements
using ProjectEulerSolutions.Problem115: find_min_length_exceeding_threshold, solve

# Test the count_block_arrangements function with examples from problem description
# F(3, 29) = 673135 and F(3, 30) = 1089155
@test count_block_arrangements(29, 3) == 673135
@test count_block_arrangements(30, 3) == 1089155

# F(10, 56) = 880711 and F(10, 57) = 1148904
@test count_block_arrangements(56, 10) == 880711
@test count_block_arrangements(57, 10) == 1148904

# Test find_min_length_exceeding_threshold function
# For m = 3, n = 30 is the smallest value where F(3, n) > 1,000,000
@test find_min_length_exceeding_threshold(3, 1_000_000) == 30

# For m = 10, n = 57 is the smallest value where F(10, n) > 1,000,000
@test find_min_length_exceeding_threshold(10, 1_000_000) == 57

# Test some basic cases
@test count_block_arrangements(0, 3) == 1  # Empty row
@test count_block_arrangements(1, 3) == 1  # Only black squares
@test count_block_arrangements(2, 3) == 1  # Only black squares (block too small)

# Correct answer
@test solve() == 168
