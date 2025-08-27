using Test
using ProjectEulerSolutions.Problem053: count_combinations_exceeding, solve

# Test with smaller limits
@test count_combinations_exceeding(1000) > 0
@test count_combinations_exceeding(100000) < count_combinations_exceeding(1000)

@test solve() == 4075
