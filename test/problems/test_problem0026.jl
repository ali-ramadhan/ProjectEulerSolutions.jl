using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0026

@test cycle_length(2) == 0   # 1/2 = 0.5 (terminating)
@test cycle_length(3) == 1   # 1/3 = 0.(3)
@test cycle_length(4) == 0   # 1/4 = 0.25 (terminating)
@test cycle_length(5) == 0   # 1/5 = 0.2 (terminating)
@test cycle_length(6) == 1   # 1/6 = 0.1(6)
@test cycle_length(7) == 6   # 1/7 = 0.(142857)
@test cycle_length(8) == 0   # 1/8 = 0.125 (terminating)
@test cycle_length(9) == 1   # 1/9 = 0.(1)
@test cycle_length(10) == 0  # 1/10 = 0.1 (terminating)

# From the examples, 1/7 has the longest cycle
@test find_longest_cycle(10) == 7

# Correct answer
@test_answer solve() "0026"
