using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0011

@show find_greatest_product(GRID, 4)
benchmark_len4 = @benchmark find_greatest_product(GRID, 4)
save_benchmark(benchmark_len4, "problem-0011", "len4")

@show find_greatest_product(GRID, 3)
benchmark_len3 = @benchmark find_greatest_product(GRID, 3)
save_benchmark(benchmark_len3, "problem-0011", "len3")

@show find_greatest_product(GRID, 6)
benchmark_len6 = @benchmark find_greatest_product(GRID, 6)
save_benchmark(benchmark_len6, "problem-0011", "len6")
