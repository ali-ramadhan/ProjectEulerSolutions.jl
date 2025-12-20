using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0013

@show first_ten_digits_of_sum()
b = @benchmark first_ten_digits_of_sum()
save_benchmark(b, "problem-0013", "first_ten_digits_of_sum")
