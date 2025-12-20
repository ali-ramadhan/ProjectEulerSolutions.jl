using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0008

@show largest_product_in_series(4)
benchmark_4 = @benchmark largest_product_in_series(4)
save_benchmark(benchmark_4, "problem-0008", "window_4")

@show largest_product_in_series(13)
benchmark_13 = @benchmark largest_product_in_series(13)
save_benchmark(benchmark_13, "problem-0008", "window_13")

@show largest_product_in_series(50)
benchmark_50 = @benchmark largest_product_in_series(50)
save_benchmark(benchmark_50, "problem-0008", "window_50")
