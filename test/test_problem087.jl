using ProjectEulerSolutions.Problem087: find_prime_power_triples, solve
using Test

# Test with the small example from the problem description
# Numbers below 50 that can be expressed as prime power triples: 28, 33, 47, 49
@test find_prime_power_triples(50) == 4

# Additional test cases from forum discussions
@test find_prime_power_triples(500) == 53
@test find_prime_power_triples(5_000) == 395
@test find_prime_power_triples(50_000) == 2579
@test find_prime_power_triples(500_000) == 18899
@test find_prime_power_triples(5_000_000) == 138932

# Test edge cases
@test find_prime_power_triples(28) == 1  # Just the minimum: 2^2 + 2^3 + 2^4 = 28
@test find_prime_power_triples(27) == 0  # Below minimum

# Test the main solve function
@test solve() == 1097343
