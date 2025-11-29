using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0009: find_pythagorean_triplet

@show find_pythagorean_triplet()
benchmark_1000 = @benchmark find_pythagorean_triplet()
save_benchmark(benchmark_1000, 9, "n_1000")
