using Test
using ProjectEulerSolutions.Problem106: needs_testing, count_testable_pairs, solve

# Test the needs_testing function
@test needs_testing([1, 2], [3, 4]) == false  # No interleaving
@test needs_testing([1, 3], [2, 4]) == false  # No interleaving: 1 < 2 and 3 < 4
@test needs_testing([1, 4], [2, 3]) == true   # Interleaving: 1 < 2 but 4 > 3
@test needs_testing([2, 4], [1, 3]) == true   # Interleaving: 2 > 1
@test needs_testing([1], [2]) == false        # No interleaving
@test needs_testing([2], [1]) == true         # Interleaving

# Test with the examples given in the problem
@test count_testable_pairs(4) == 1   # For n=4, only 1 pair needs testing
@test count_testable_pairs(7) == 70  # For n=7, only 70 pairs need testing

# Correct answer
@test solve() == 21384
