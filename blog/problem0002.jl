using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0002: sum_even_fibonacci

@show sum_even_fibonacci(4_000_000)
benchmark_4M = @benchmark sum_even_fibonacci(4_000_000)
save_benchmark(benchmark_4M, 2, "limit_4M")

@show sum_even_fibonacci(4 * 10^15)
benchmark_4e15 = @benchmark sum_even_fibonacci(4 * 10^15)
save_benchmark(benchmark_4e15, 2, "limit_4e15")
