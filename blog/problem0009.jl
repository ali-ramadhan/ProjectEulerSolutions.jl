using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0009: find_pythagorean_triplets

@show find_pythagorean_triplets(1000)
benchmark_1000 = @benchmark find_pythagorean_triplets(1000)
save_benchmark(benchmark_1000, "problem-0009", "n_1000")

@show find_pythagorean_triplets(1000000)
benchmark_1000000 = @benchmark find_pythagorean_triplets(1000000)
save_benchmark(benchmark_1000000, "problem-0009", "n_1000000")

@show find_pythagorean_triplets(1234567890)
benchmark_1234567890 = @benchmark find_pythagorean_triplets(1234567890) samples=100 evals=1 seconds=3600
save_benchmark(benchmark_1234567890, "problem-0009", "n_1234567890")
