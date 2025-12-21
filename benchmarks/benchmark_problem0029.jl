using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0029

@time @show count_distinct_powers(2, 100, 2, 100)
benchmark = @benchmark count_distinct_powers(2, 100, 2, 100)
save_benchmark(benchmark, "problem-0029", "count_distinct_powers_100")

@time @show count_distinct_powers(2, 1000, 2, 1000)
benchmark_1k = @benchmark count_distinct_powers(2, 1000, 2, 1000)
save_benchmark(benchmark_1k, "problem-0029", "count_distinct_powers_1k")

@time @show count_distinct_powers(2, 10000, 2, 10000)
benchmark_10k = @benchmark count_distinct_powers(2, 10000, 2, 10000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_10k, "problem-0029", "count_distinct_powers_10k")
