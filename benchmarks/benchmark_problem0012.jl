using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0012: find_first_triangle_with_divisors

@show find_first_triangle_with_divisors(500)
benchmark_500 = @benchmark find_first_triangle_with_divisors(500)
save_benchmark(benchmark_500, "problem-0012", "divisors_500")

@show find_first_triangle_with_divisors(1000)
benchmark_1000 = @benchmark find_first_triangle_with_divisors(1000)
save_benchmark(benchmark_1000, "problem-0012", "divisors_1000")

@show find_first_triangle_with_divisors(2000)
benchmark_2000 = @benchmark find_first_triangle_with_divisors(2000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_2000, "problem-0012", "divisors_2000")
