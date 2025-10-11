using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0008: largest_product_in_series

@show largest_product_in_series(4)
benchmark_4 = @benchmark largest_product_in_series(4)
save_benchmark(benchmark_4, 8, "window_4")

@show largest_product_in_series(13)
benchmark_13 = @benchmark largest_product_in_series(13)
save_benchmark(benchmark_13, 8, "window_13")

@show largest_product_in_series(50)
benchmark_50 = @benchmark largest_product_in_series(50)
save_benchmark(benchmark_50, 8, "window_50")
