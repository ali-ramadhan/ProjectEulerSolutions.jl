using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0023

@show solve()
benchmark = @benchmark solve()
save_benchmark(benchmark, "problem-0023", "solution")
