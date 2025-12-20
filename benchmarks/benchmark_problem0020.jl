using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0020

@show sum_of_factorial_digits(100)
benchmark1 = @benchmark sum_of_factorial_digits(100)
save_benchmark(benchmark1, "problem-0020", "factorial_100")

@show sum_of_factorial_digits(1000000)
benchmark2 = @benchmark sum_of_factorial_digits(1000000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark2, "problem-0020", "factorial_1M")
