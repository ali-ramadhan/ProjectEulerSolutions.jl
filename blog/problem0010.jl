using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0010: sum_of_primes_below

@show sum_of_primes_below(2_000_000)[2]
benchmark_2M = @benchmark sum_of_primes_below(2_000_000)
save_benchmark(benchmark_2M, 10, "sum_of_primes_below_2M")

@show sum_of_primes_below(100_000_000)[2]
benchmark_100M = @benchmark sum_of_primes_below(100_000_000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_100M, 10, "sum_of_primes_below_100M")
