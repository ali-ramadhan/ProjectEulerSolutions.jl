using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0037: find_truncatable_primes

@show find_truncatable_primes()
benchmark_base10 = @benchmark find_truncatable_primes()
save_benchmark(benchmark_base10, "problem-0037", "find_truncatable_primes_base10")
