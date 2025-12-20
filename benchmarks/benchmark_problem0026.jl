using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0026

@show find_longest_cycle(1000)
benchmark = @benchmark find_longest_cycle(1000)
save_benchmark(benchmark, "problem-0026", "find_longest_cycle_1000")

@show find_longest_cycle(100_000)
benchmark_100k = @benchmark find_longest_cycle(100_000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_100k, "problem-0026", "find_longest_cycle_100k")
