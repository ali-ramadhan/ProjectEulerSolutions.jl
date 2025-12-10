using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0017: count_letters_in_range

@show count_letters_in_range(1, 1000)
benchmark_1_1000 = @benchmark count_letters_in_range(1, 1000)
save_benchmark(benchmark_1_1000, "problem-0017", "range_1_1000")
