using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0002

# Arguments go in as $(Ref(x))[] so the compiler can't compute the result at compile time

@show sum_even_fibonacci_naive(4_000_000)
benchmark_naive_4M = @benchmark sum_even_fibonacci_naive($(Ref(4_000_000))[])
save_benchmark(benchmark_naive_4M, "problem-0002", "naive_limit_4M")

@show sum_even_fibonacci_naive(4 * 10^15)
benchmark_naive_4e15 = @benchmark sum_even_fibonacci_naive($(Ref(4 * 10^15))[])
save_benchmark(benchmark_naive_4e15, "problem-0002", "naive_limit_4e15")

@show sum_even_fibonacci(4_000_000)
benchmark_4M = @benchmark sum_even_fibonacci($(Ref(4_000_000))[])
save_benchmark(benchmark_4M, "problem-0002", "limit_4M")

@show sum_even_fibonacci(4 * 10^15)
benchmark_4e15 = @benchmark sum_even_fibonacci($(Ref(4 * 10^15))[])
save_benchmark(benchmark_4e15, "problem-0002", "limit_4e15")
