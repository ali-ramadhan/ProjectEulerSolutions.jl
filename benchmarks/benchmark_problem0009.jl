using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0009: find_pythagorean_triplets, find_pythagorean_triplets_euclid

@show find_pythagorean_triplets(1000)
benchmark_1000 = @benchmark find_pythagorean_triplets(1000)
save_benchmark(benchmark_1000, "problem-0009", "n_1000")

@show find_pythagorean_triplets(1000000)
benchmark_1000000 = @benchmark find_pythagorean_triplets(1000000)
save_benchmark(benchmark_1000000, "problem-0009", "n_1000000")

@show find_pythagorean_triplets(1234567890)
benchmark_1234567890 = @benchmark find_pythagorean_triplets(1234567890) samples=100 evals=1 seconds=3600
save_benchmark(benchmark_1234567890, "problem-0009", "n_1234567890")

@show find_pythagorean_triplets_euclid(1000)
benchmark_1000_euclid = @benchmark find_pythagorean_triplets_euclid(1000)
save_benchmark(benchmark_1000_euclid, "problem-0009", "n_1000_euclid")

@show find_pythagorean_triplets_euclid(1000000)
benchmark_1000000_euclid = @benchmark find_pythagorean_triplets_euclid(1000000)
save_benchmark(benchmark_1000000_euclid, "problem-0009", "n_1000000_euclid")

@show find_pythagorean_triplets_euclid(1234567890)
benchmark_1234567890_euclid = @benchmark find_pythagorean_triplets_euclid(1234567890)
save_benchmark(benchmark_1234567890_euclid, "problem-0009", "n_1234567890_euclid")
