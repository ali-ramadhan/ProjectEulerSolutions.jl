using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0014: longest_collatz_under

@show longest_collatz_under(1_000_000)
b_1M = @benchmark longest_collatz_under(1_000_000) samples=100 evals=1 seconds=1000
save_benchmark(b_1M, 14, "longest_collatz_under_1M")

@show longest_collatz_under(10_000_000)
b_10M = @benchmark longest_collatz_under(10_000_000) samples=100 evals=1 seconds=1000
save_benchmark(b_10M, 14, "longest_collatz_under_10M")

@show longest_collatz_under(100_000_000)
b_100M = @benchmark longest_collatz_under(100_000_000) samples=10 evals=1 seconds=1000
save_benchmark(b_100M, 14, "longest_collatz_under_100M")
