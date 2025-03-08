using ProjectEulerSolutions.Problem051: find_prime_family, solve

# Limiting the search to 60000 to find the example
smallest, family = find_prime_family(7, 60000)
@test smallest == 56003
@test length(family) == 7

# Test the actual solution
@test solve() == 121313
