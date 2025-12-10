using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0007: find_nth_prime

@show find_nth_prime(10001)
benchmark_10001 = @benchmark find_nth_prime(10001)
save_benchmark(benchmark_10001, "problem-0007", "n_10001")

@show find_nth_prime(100000)
benchmark_100k = @benchmark find_nth_prime(100000)
save_benchmark(benchmark_100k, "problem-0007", "n_100k")

@show find_nth_prime(1000000)
benchmark_1m = @benchmark find_nth_prime(1000000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1m, "problem-0007", "n_1M")
