using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0015: count_lattice_paths

@show count_lattice_paths(20, 20)
b_20x20 = @benchmark count_lattice_paths(20, 20)
save_benchmark(b_20x20, "problem-0015", "count_lattice_paths_20x20")
