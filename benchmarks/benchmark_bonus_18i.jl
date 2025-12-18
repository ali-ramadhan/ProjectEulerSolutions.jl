using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Bonus18i: sum_R_mod_p

b = @benchmark sum_R_mod_p(1_000_000_000, 1_100_000_000) samples=20 evals=1 seconds=1000
save_benchmark(b, "bonus-18i", "solution")
