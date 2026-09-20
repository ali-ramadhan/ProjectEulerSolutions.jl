using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0029

# Test with the example from the problem statement
# 2 ≤ a ≤ 5, 2 ≤ b ≤ 5 gives 15 distinct terms
@test count_distinct_powers(5) == 15

# Correct answer
@test_answer solve() "0029"
