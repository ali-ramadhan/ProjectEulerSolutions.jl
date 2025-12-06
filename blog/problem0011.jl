using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0011: GRID, find_greatest_product

@show find_greatest_product(GRID, 4)
benchmark_len4 = @benchmark find_greatest_product(GRID, 4)
save_benchmark(benchmark_len4, 11, "len4")

@show find_greatest_product(GRID, 3)
benchmark_len3 = @benchmark find_greatest_product(GRID, 3)
save_benchmark(benchmark_len3, 11, "len3")

@show find_greatest_product(GRID, 6)
benchmark_len6 = @benchmark find_greatest_product(GRID, 6)
save_benchmark(benchmark_len6, 11, "len6")
