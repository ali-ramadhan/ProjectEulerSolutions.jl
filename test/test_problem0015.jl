using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0015: count_lattice_paths, solve

@test count_lattice_paths(2, 2) == 6

@test_answer solve() "0015"
