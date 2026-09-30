using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0004

@show largest_palindrome_product_naive(3)
benchmark_naive_3_digits = @benchmark largest_palindrome_product_naive(3)
save_benchmark(benchmark_naive_3_digits, "problem-0004", "naive_3_digits")

@show largest_palindrome_product(3)
benchmark_3_digits = @benchmark largest_palindrome_product(3)
save_benchmark(benchmark_3_digits, "problem-0004", "3_digits")

@show largest_palindrome_product(6)
benchmark_6_digits = @benchmark largest_palindrome_product(6)
save_benchmark(benchmark_6_digits, "problem-0004", "6_digits")

@show largest_palindrome_product(9)
benchmark_9_digits = @benchmark largest_palindrome_product(9) samples=10 evals=1 seconds=100
save_benchmark(benchmark_9_digits, "problem-0004", "9_digits")

@show largest_palindrome_product_fermat(9)
benchmark_fermat_9_digits = @benchmark largest_palindrome_product_fermat(9)
save_benchmark(benchmark_fermat_9_digits, "problem-0004", "fermat_9_digits")

@show largest_palindrome_product_fermat(12)
benchmark_fermat_12_digits = @benchmark largest_palindrome_product_fermat(12)
save_benchmark(benchmark_fermat_12_digits, "problem-0004", "fermat_12_digits")

@show largest_palindrome_product_fermat(15)
benchmark_fermat_15_digits = @benchmark largest_palindrome_product_fermat(15)
save_benchmark(benchmark_fermat_15_digits, "problem-0004", "fermat_15_digits")
