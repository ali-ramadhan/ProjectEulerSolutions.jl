using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0001

# Arguments go in as $(Ref(x))[] so the compiler can't compute the result at compile time

@show sum_multiples_two_generator(3, 5, 1000)
benchmark_two_generator = @benchmark sum_multiples_two_generator($(Ref(3))[], $(Ref(5))[], $(Ref(1000))[])
save_benchmark(benchmark_two_generator, "problem-0001", "two_generator")

@show sum_multiples_two_inclusion_exclusion(3, 5, 1000)
benchmark_two_inclusion_exclusion = @benchmark sum_multiples_two_inclusion_exclusion($(Ref(3))[], $(Ref(5))[], $(Ref(1000))[])
save_benchmark(benchmark_two_inclusion_exclusion, "problem-0001", "two_inclusion_exclusion")

@show sum_multiples_three_generator(3, 5, 7, 10^6)
benchmark_three_generator = @benchmark sum_multiples_three_generator($(Ref(3))[], $(Ref(5))[], $(Ref(7))[], $(Ref(10^6))[])
save_benchmark(benchmark_three_generator, "problem-0001", "three_generator")

@show sum_multiples_three_inclusion_exclusion(3, 5, 7, 10^6)
benchmark_three_inclusion_exclusion = @benchmark sum_multiples_three_inclusion_exclusion($(Ref(3))[], $(Ref(5))[], $(Ref(7))[], $(Ref(10^6))[])
save_benchmark(benchmark_three_inclusion_exclusion, "problem-0001", "three_inclusion_exclusion")
