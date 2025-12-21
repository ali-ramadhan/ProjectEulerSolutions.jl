using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0021

@show sum_of_amicable_numbers(10000)
benchmark_10k = @benchmark sum_of_amicable_numbers(10000)
save_benchmark(benchmark_10k, "problem-0021", "limit_10k")

@show sum_of_amicable_numbers(100000)
benchmark_100k = @benchmark sum_of_amicable_numbers(100000)
save_benchmark(benchmark_100k, "problem-0021", "limit_100k")

@show sum_of_amicable_numbers(1000000)
benchmark_1M = @benchmark sum_of_amicable_numbers(1000000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1M, "problem-0021", "limit_1M")

@show sum_of_amicable_numbers(10000000)
benchmark_10M = @benchmark sum_of_amicable_numbers(10000000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_10M, "problem-0021", "limit_10M")
