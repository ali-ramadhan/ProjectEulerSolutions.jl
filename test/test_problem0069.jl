using Test
using ProjectEulerSolutions.Problem0069: find_max_totient_ratio, solve

# Test finding maximum n/φ(n) for small limits
@test find_max_totient_ratio(10) == 6  # From the problem statement
@test find_max_totient_ratio(30) == 30
@test find_max_totient_ratio(100) == 30

@test solve() == 510510
