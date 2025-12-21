using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0005

# Test example from problem description
@test smallest_multiple(10) == 2520

# Correct answer
@test_answer solve() "0005"
