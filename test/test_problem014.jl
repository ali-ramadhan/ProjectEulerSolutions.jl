using Test
using ProjectEulerSolutions.Problem014: collatz_length, longest_collatz_under, solve

memo = Dict(1 => 1)
@test collatz_length(13, memo) == 10

@test collatz_length(1, memo) == 1
@test collatz_length(2, memo) == 2  # 2 → 1
@test collatz_length(4, memo) == 3  # 4 → 2 → 1

@test longest_collatz_under(14) ≥ 9  # 9 has a longer sequence than 13

@test solve() == 837799
