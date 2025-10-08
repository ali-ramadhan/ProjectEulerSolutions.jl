using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0006: sum_square_difference

@show sum_square_difference(100)
benchmark_100 = @benchmark sum_square_difference(100)
save_benchmark(benchmark_100, 6, "n_100")
