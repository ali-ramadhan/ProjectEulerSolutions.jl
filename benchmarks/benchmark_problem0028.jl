using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0028

@show diagonal_sum(1001)
benchmark = @benchmark diagonal_sum(1001)
save_benchmark(benchmark, "problem-0028", "diagonal_sum_1001")

@show diagonal_sum(1_000_001)
benchmark_1m = @benchmark diagonal_sum(1_000_001)
save_benchmark(benchmark_1m, "problem-0028", "diagonal_sum_1m")
