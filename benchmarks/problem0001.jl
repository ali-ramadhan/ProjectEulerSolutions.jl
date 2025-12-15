using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0001:
    sum_multiples_two_generator,
    sum_multiples_two_ie,
    sum_multiples_three_generator,
    sum_multiples_three_ie

@show sum_multiples_two_generator(3, 5, 1000)
benchmark_two_generator = @benchmark sum_multiples_two_generator(3, 5, 1000)
save_benchmark(benchmark_two_generator, "problem-0001", "two_generator")

@show sum_multiples_two_ie(3, 5, 1000)
benchmark_two_ie = @benchmark sum_multiples_two_ie(3, 5, 1000)
save_benchmark(benchmark_two_ie, "problem-0001", "two_ie")

@show sum_multiples_three_generator(3, 5, 7, 10^6)
benchmark_three_generator = @benchmark sum_multiples_three_generator(3, 5, 7, 10^6)
save_benchmark(benchmark_three_generator, "problem-0001", "three_generator")

@show sum_multiples_three_ie(3, 5, 7, 10^6)
benchmark_three_ie = @benchmark sum_multiples_three_ie(3, 5, 7, 10^6)
save_benchmark(benchmark_three_ie, "problem-0001", "three_ie")
