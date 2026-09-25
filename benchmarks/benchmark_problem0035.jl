using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0035: find_circular_primes

@show find_circular_primes(10^6)
benchmark_1M = @benchmark find_circular_primes(10^6)
save_benchmark(benchmark_1M, "problem-0035", "find_circular_primes_1M")

@show find_circular_primes(10^12)
benchmark_1T = @benchmark find_circular_primes(10^12) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1T, "problem-0035", "find_circular_primes_1T")
