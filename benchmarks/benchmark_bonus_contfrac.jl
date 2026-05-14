using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.BonusContfrac: compute_Q

@show compute_Q(8)
b = @benchmark compute_Q(8)
save_benchmark(b, "bonus-contfrac", "Q_8")

@show compute_Q(10)
b = @benchmark compute_Q(10)
save_benchmark(b, "bonus-contfrac", "Q_10")

@show compute_Q(12)
b = @benchmark compute_Q(12) samples=100 evals=1 seconds=600
save_benchmark(b, "bonus-contfrac", "Q_12")
