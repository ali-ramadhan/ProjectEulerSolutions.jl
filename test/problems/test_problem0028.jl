using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0028: diagonal_sum, solve

# 1×1 spiral has only the center
@test diagonal_sum(1) == 1

# 3×3 spiral diagonal sum = 1 + 3 + 5 + 7 + 9 = 25
@test diagonal_sum(3) == 25

# 5×5 spiral example from the problem statement
@test diagonal_sum(5) == 101

# Correct answer
@test_answer solve() "0028"
