using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0022: solve

@show solve()
benchmark = @benchmark solve()
save_benchmark(benchmark, "problem-0022", "solution")
