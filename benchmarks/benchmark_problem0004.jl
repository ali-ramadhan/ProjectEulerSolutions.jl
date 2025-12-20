using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0004

@show largest_palindrome_product(100, 999)
benchmark_3_digits = @benchmark largest_palindrome_product(100, 999)
save_benchmark(benchmark_3_digits, "problem-0004", "3_digits")

@show largest_palindrome_product(100000, 999999)
benchmark_6_digits = @benchmark largest_palindrome_product(100000, 999999)
save_benchmark(benchmark_6_digits, "problem-0004", "6_digits")

@show largest_palindrome_product(100000000, 999999999)
benchmark_9_digits = @benchmark largest_palindrome_product(100000000, 999999999) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_9_digits, "problem-0004", "9_digits")
