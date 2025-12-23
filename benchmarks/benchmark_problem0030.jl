using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0030

@show find_digit_power_numbers(4)
b = @benchmark find_digit_power_numbers(4)
save_benchmark(b, "problem-0030", "digits4")

@show find_digit_power_numbers(5)
b = @benchmark find_digit_power_numbers(5)
save_benchmark(b, "problem-0030", "digits5")

@show find_digit_power_numbers(6)
b = @benchmark find_digit_power_numbers(6)
save_benchmark(b, "problem-0030", "digits6")

@show find_digit_power_numbers(7)
b = @benchmark find_digit_power_numbers(7)
save_benchmark(b, "problem-0030", "digits7")
