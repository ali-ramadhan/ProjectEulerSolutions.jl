using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0018

@show solve()
benchmark = @benchmark solve()
save_benchmark(benchmark, "problem-0018", "solution")
