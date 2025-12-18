using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0027: find_quadratic_with_most_primes

@show find_quadratic_with_most_primes(a_max=1000, b_max=1000)
benchmark = @benchmark find_quadratic_with_most_primes(a_max=1000, b_max=1000)
save_benchmark(benchmark, "problem-0027", "find_quadratic_with_most_primes_1000")

@show find_quadratic_with_most_primes(a_max=10_000, b_max=10_000)
benchmark_10k = @benchmark find_quadratic_with_most_primes(a_max=10_000, b_max=10_000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_10k, "problem-0027", "find_quadratic_with_most_primes_10k")
