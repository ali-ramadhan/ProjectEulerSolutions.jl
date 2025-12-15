using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0021: sum_of_amicable_numbers

@show sum_of_amicable_numbers(10000)
benchmark1 = @benchmark sum_of_amicable_numbers(10000)
save_benchmark(benchmark1, "problem-0021", "limit_10k")

@show sum_of_amicable_numbers(1000000)
benchmark2 = @benchmark sum_of_amicable_numbers(1000000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark2, "problem-0021", "limit_1M")
