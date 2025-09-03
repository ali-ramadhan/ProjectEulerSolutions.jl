using Test
using ProjectEulerSolutions.Problem128: find_tiles_with_pd3, solve

# Test that we find the correct 10th tile as mentioned in the problem
@test find_tiles_with_pd3(10) == 271

# Test small cases  
@test find_tiles_with_pd3(1) == 1
@test find_tiles_with_pd3(2) == 2

# Correct answer
@test solve() == 14516824220
