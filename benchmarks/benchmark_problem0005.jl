using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0005

@show smallest_multiple(20)
benchmark_20 = @benchmark smallest_multiple(20)
save_benchmark(benchmark_20, "problem-0005", "n_20")

@show smallest_multiple(42)
benchmark_42 = @benchmark smallest_multiple(42)
save_benchmark(benchmark_42, "problem-0005", "n_42")

@show smallest_multiple(Int128(88))
benchmark_88 = @benchmark smallest_multiple(Int128(88))
save_benchmark(benchmark_88, "problem-0005", "n_88_i128")

@show ndigits(smallest_multiple(BigInt(100000)))
benchmark_1000 = @benchmark smallest_multiple(BigInt(100000))
save_benchmark(benchmark_1000, "problem-0005", "n_100k_bigint")

@show ndigits(smallest_multiple_primorial(100000))
benchmark_primorial_100k = @benchmark smallest_multiple_primorial(100000)
save_benchmark(benchmark_primorial_100k, "problem-0005", "primorial_n_100k")

@show ndigits(smallest_multiple_primorial(10^6))
benchmark_primorial_1M = @benchmark smallest_multiple_primorial(10^6)
save_benchmark(benchmark_primorial_1M, "problem-0005", "primorial_n_1M")

@show ndigits(smallest_multiple_primorial(10^8))
benchmark_primorial_100M = @benchmark smallest_multiple_primorial(10^8)
save_benchmark(benchmark_primorial_100M, "problem-0005", "primorial_n_100M")
