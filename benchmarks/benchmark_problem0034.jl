using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0034: find_digit_factorial_divisors

@show find_digit_factorial_divisors(10^7)
b = @benchmark find_digit_factorial_divisors(10^7)
save_benchmark(b, "problem-0034", "find_digit_factorial_divisors")
