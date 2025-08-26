using Test
using ProjectEulerSolutions.Problem015: count_lattice_paths, solve

@test count_lattice_paths(2, 2) == 6

@test solve() == 137846528820
