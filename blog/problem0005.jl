using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0005: smallest_multiple

@show smallest_multiple(20)
benchmark_20 = @benchmark smallest_multiple(20)
save_benchmark(benchmark_20, 5, "n_20")

@show smallest_multiple(42)
benchmark_42 = @benchmark smallest_multiple(42)
save_benchmark(benchmark_42, 5, "n_42")

@show smallest_multiple(Int128(88))
benchmark_88 = @benchmark smallest_multiple(Int128(88))
save_benchmark(benchmark_88, 5, "n_88_i128")

@show ndigits(smallest_multiple(BigInt(100000)))
benchmark_1000 = @benchmark smallest_multiple(BigInt(100000))
save_benchmark(benchmark_1000, 5, "n_100k_bigint")

