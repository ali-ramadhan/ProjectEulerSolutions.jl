using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0013: first_ten_digits_of_sum

@show first_ten_digits_of_sum()
b = @benchmark first_ten_digits_of_sum()
save_benchmark(b, "problem-0013", "first_ten_digits_of_sum")
