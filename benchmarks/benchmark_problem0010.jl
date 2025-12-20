using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0010

@show sum_of_primes_below(2_000_000)[2]
benchmark_2M = @benchmark sum_of_primes_below(2_000_000)
save_benchmark(benchmark_2M, "problem-0010", "sum_of_primes_below_2M")

@show sum_of_primes_below(200_000_000)[2]
benchmark_200M = @benchmark sum_of_primes_below(200_000_000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_200M, "problem-0010", "sum_of_primes_below_200M")
