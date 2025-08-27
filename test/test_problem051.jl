using Test
using ProjectEulerSolutions.Problem051: generate_subsets, find_prime_family, solve

# Test subset generation helper
@test generate_subsets([1, 2]) == [[1], [2], [1, 2]]
@test generate_subsets([1, 2, 3]) == [[1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
@test length(generate_subsets([1, 2, 3, 4])) == 15  # 2^4 - 1

# Test the 7-prime family example from the problem
smallest, family = find_prime_family(7, 60000)
@test smallest == 56003
@test sort(family) == [56003, 56113, 56333, 56443, 56663, 56773, 56993]

# Test edge cases
@test find_prime_family(10, 1000) == (nothing, [])  # No solution in small range

@test solve() == 121313
