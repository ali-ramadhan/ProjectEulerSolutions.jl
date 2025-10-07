using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0004: largest_palindrome_product

@show largest_palindrome_product(100, 999)
benchmark_3_digits = @benchmark largest_palindrome_product(100, 999)
save_benchmark(benchmark_3_digits, 4, "3_digits")

@show largest_palindrome_product(100000, 999999)
benchmark_6_digits = @benchmark largest_palindrome_product(100000, 999999)
save_benchmark(benchmark_6_digits, 4, "6_digits")

@show largest_palindrome_product(100000000, 999999999)
benchmark_9_digits = @benchmark largest_palindrome_product(100000000, 999999999) samples=100 seconds=1000
save_benchmark(benchmark_9_digits, 4, "9_digits")
