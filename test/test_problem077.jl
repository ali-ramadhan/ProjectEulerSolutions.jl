using ProjectEulerSolutions.Problem077: find_first_with_over_n_ways, solve

# Test with the example from the problem
# When n=10, there are exactly 5 ways to express it as a sum of primes
@test find_first_with_over_n_ways(4, 20) == 10

# Test the final solution
@test solve() == 71
