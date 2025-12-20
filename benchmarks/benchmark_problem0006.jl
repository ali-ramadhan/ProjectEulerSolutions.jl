using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0006

@show sum_square_difference(100)
benchmark_100 = @benchmark sum_square_difference(100)
save_benchmark(benchmark_100, "problem-0006", "n_100")
