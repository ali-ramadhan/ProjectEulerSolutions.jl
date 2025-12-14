using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0018: max_path_sum, solve

# The example triangle from the problem
triangle = [
    [3],
    [7, 4],
    [2, 4, 6],
    [8, 5, 9, 3],
]

@test max_path_sum(triangle) == 23

# Correct answer
@test_answer solve() "0018"
