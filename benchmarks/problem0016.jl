using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0016: power_digit_sum

@show power_digit_sum(2, 1000)
b_2_1000 = @benchmark power_digit_sum(2, 1000)
save_benchmark(b_2_1000, "problem-0016", "power_digit_sum_2_1000")

@show power_digit_sum(2, 1000000)
b_2_1M = @benchmark power_digit_sum(2, 1000000)
save_benchmark(b_2_1M, "problem-0016", "power_digit_sum_2_1M")
