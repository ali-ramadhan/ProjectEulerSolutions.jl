using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0025

# 1000 digits
@show first_fibonacci_with_n_digits(1000)
benchmark = @benchmark first_fibonacci_with_n_digits(1000)
save_benchmark(benchmark, "problem-0025", "iterative_1000")

@show first_fibonacci_with_n_digits_formula(1000)
benchmark_formula = @benchmark first_fibonacci_with_n_digits_formula(1000)
save_benchmark(benchmark_formula, "problem-0025", "formula_1000")

# 10000 digits
@show first_fibonacci_with_n_digits(10_000)
benchmark_1m = @benchmark first_fibonacci_with_n_digits(10_000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1m, "problem-0025", "iterative_10000")

@show first_fibonacci_with_n_digits_formula(10_000)
benchmark_formula_1m = @benchmark first_fibonacci_with_n_digits_formula(10_000)
save_benchmark(benchmark_formula_1m, "problem-0025", "formula_10000")
