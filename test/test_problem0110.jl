using Test
using ProjectEulerSolutions.Problem0110: find_n_with_solutions_exceeding, solve

# Test with smaller targets to validate the algorithm works
# For n = 12 = 2² × 3, we have τ(144) = τ(2⁴ × 3²) = (4+1)(2+1) = 15
# So solutions = (15 + 1) ÷ 2 = 8

@test find_n_with_solutions_exceeding(7) <= 12

# Test with the example from problem description: n = 1260 has 113 solutions
@test find_n_with_solutions_exceeding(100) == 1260

# Correct answer
@test solve() == 9350130049860600
