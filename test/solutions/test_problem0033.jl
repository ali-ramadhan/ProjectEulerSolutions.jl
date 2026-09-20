using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0033: find_curious_fractions, solve

# The four known curious fractions for N=2, K=1
fractions_2_1 = find_curious_fractions(2, 1)
@test length(fractions_2_1) == 4
@test (16, 64) in fractions_2_1
@test (26, 65) in fractions_2_1
@test (19, 95) in fractions_2_1
@test (49, 98) in fractions_2_1

# HackerRank sample: N=2, K=1 → sum of numerators = 110, sum of denominators = 322
@test sum(first, fractions_2_1) == 110
@test sum(last, fractions_2_1) == 322

# Correct answer
@test_answer solve() "0033"
