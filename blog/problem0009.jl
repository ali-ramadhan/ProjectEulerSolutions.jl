using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0009: find_pythagorean_triplets

@show find_pythagorean_triplets(1000)
benchmark_1000 = @benchmark find_pythagorean_triplets(1000)
save_benchmark(benchmark_1000, 9, "n_1000")
