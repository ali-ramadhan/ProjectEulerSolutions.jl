using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0014

memo = Dict(1 => 1)
@test collatz_length(13, memo) == 10

@test collatz_length(1, memo) == 1
@test collatz_length(2, memo) == 2  # 2 → 1
@test collatz_length(4, memo) == 3  # 4 → 2 → 1

start_number, _ = longest_collatz_under(14)
@test start_number ≥ 9  # 9 has a longer sequence than 13

@test_answer solve() "0014"
