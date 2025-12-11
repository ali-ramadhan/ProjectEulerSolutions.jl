using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0019: count_sundays_on_first

@show count_sundays_on_first(1901, 2000)
benchmark1 = @benchmark count_sundays_on_first(1901, 2000)
save_benchmark(benchmark1, "problem-0019", "years_1901_2000")

@show count_sundays_on_first(2000, 10000)
benchmark2 = @benchmark count_sundays_on_first(2000, 10000)
save_benchmark(benchmark2, "problem-0019", "years_2000_10000")
