using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0024

@show solve()
benchmark = @benchmark solve()
save_benchmark(benchmark, "problem-0024", "solution")
