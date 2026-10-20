using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0004

@show largest_palindrome_product_naive(3)
benchmark_naive_3_digits = @benchmark largest_palindrome_product_naive(3)
save_benchmark(benchmark_naive_3_digits, "problem-0004", "naive_3_digits")

@show largest_palindrome_product_naive(4)
benchmark_naive_4_digits = @benchmark largest_palindrome_product_naive(4) evals=1
save_benchmark(benchmark_naive_4_digits, "problem-0004", "naive_4_digits")

@show largest_palindrome_product_pruned(3)
benchmark_pruned_3_digits = @benchmark largest_palindrome_product_pruned(3)
save_benchmark(benchmark_pruned_3_digits, "problem-0004", "pruned_3_digits")

@show largest_palindrome_product_pruned(4)
benchmark_pruned_4_digits = @benchmark largest_palindrome_product_pruned(4)
save_benchmark(benchmark_pruned_4_digits, "problem-0004", "pruned_4_digits")

@show largest_palindrome_product_pruned(6)
benchmark_pruned_6_digits = @benchmark largest_palindrome_product_pruned(6)
save_benchmark(benchmark_pruned_6_digits, "problem-0004", "pruned_6_digits")

@show largest_palindrome_product_pruned(8)
benchmark_pruned_8_digits = @benchmark largest_palindrome_product_pruned(8)
save_benchmark(benchmark_pruned_8_digits, "problem-0004", "pruned_8_digits")

@show largest_palindrome_product_fermat(3)
benchmark_fermat_3_digits = @benchmark largest_palindrome_product_fermat(3)
save_benchmark(benchmark_fermat_3_digits, "problem-0004", "fermat_3_digits")

@show largest_palindrome_product_fermat(6)
benchmark_fermat_6_digits = @benchmark largest_palindrome_product_fermat(6)
save_benchmark(benchmark_fermat_6_digits, "problem-0004", "fermat_6_digits")

@show largest_palindrome_product_fermat(8)
benchmark_fermat_8_digits = @benchmark largest_palindrome_product_fermat(8)
save_benchmark(benchmark_fermat_8_digits, "problem-0004", "fermat_8_digits")

@show largest_palindrome_product_fermat(12)
benchmark_fermat_12_digits = @benchmark largest_palindrome_product_fermat(12)
save_benchmark(benchmark_fermat_12_digits, "problem-0004", "fermat_12_digits")

@show largest_palindrome_product_fermat(15)
benchmark_fermat_15_digits = @benchmark largest_palindrome_product_fermat(15)
save_benchmark(benchmark_fermat_15_digits, "problem-0004", "fermat_15_digits")

@show largest_palindrome_product_fermat_filtered(12)
benchmark_fermat_filtered_12_digits = @benchmark largest_palindrome_product_fermat_filtered(12)
save_benchmark(benchmark_fermat_filtered_12_digits, "problem-0004", "fermat_filtered_12_digits")

@show largest_palindrome_product_fermat_filtered(15)
benchmark_fermat_filtered_15_digits = @benchmark largest_palindrome_product_fermat_filtered(15)
save_benchmark(benchmark_fermat_filtered_15_digits, "problem-0004", "fermat_filtered_15_digits")

@show largest_palindrome_product_fermat_filtered(20)
benchmark_fermat_filtered_20_digits = @benchmark largest_palindrome_product_fermat_filtered(20) evals=1
save_benchmark(benchmark_fermat_filtered_20_digits, "problem-0004", "fermat_filtered_20_digits")
