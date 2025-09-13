using Test
using ProjectEulerSolutions.Problem0039: count_right_triangles, find_max_solutions, solve

@test count_right_triangles(120) == 3

@test solve() == 840
