using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0018: solve

@show solve()
benchmark = @benchmark solve()
save_benchmark(benchmark, "problem-0018", "solution")
