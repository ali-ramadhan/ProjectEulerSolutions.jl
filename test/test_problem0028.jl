using Test
using ProjectEulerSolutions.Problem0028: diagonal_sum, solve

@test diagonal_sum(1) == 1  # 1×1 spiral has only the center
@test diagonal_sum(3) == 25  # 3×3 spiral diagonal sum = 1 + 3 + 5 + 7 + 9 = 25
@test diagonal_sum(5) == 101  # Given in the problem statement

@test solve() == 669171001
