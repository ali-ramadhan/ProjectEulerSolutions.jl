using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.BonusSecret: solve

b = @benchmark solve() samples=100 evals=1 seconds=1000
save_benchmark(b, "bonus-secret", "solution")
