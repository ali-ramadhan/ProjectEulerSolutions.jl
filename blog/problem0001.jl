using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0001: sum_multiples, sum_multiples_two as sum_multiples_two_ie

function sum_multiples_two_generator(a, b, L)
    return sum(n for n in 1:L-1 if n % a == 0 || n % b == 0)
end

function sum_multiples_three_generator(a, b, c, L)
    return sum(n for n in 1:L-1 if n % a == 0 || n % b == 0 || n % c == 0)
end

function sum_multiples_three_ie(a, b, c, L)
    return sum_multiples(a, L) +
           sum_multiples(b, L) +
           sum_multiples(c, L) -
           sum_multiples(lcm(a, b), L) -
           sum_multiples(lcm(a, c), L) -
           sum_multiples(lcm(b, c), L) +
           sum_multiples(lcm(a, b, c), L)
end

@show sum_multiples_two_generator(3, 5, 1000)
benchmark_two_generator = @benchmark sum_multiples_two_generator(3, 5, 1000)
save_benchmark(benchmark_two_generator, 1, "two_generator")

@show sum_multiples_two_ie(3, 5, 1000)
benchmark_two_ie = @benchmark sum_multiples_two_ie(3, 5, 1000)
save_benchmark(benchmark_two_ie, 1, "two_ie")

@show sum_multiples_three_generator(3, 5, 7, 10^6)
benchmark_three_generator = @benchmark sum_multiples_three_generator(3, 5, 7, 10^6)
save_benchmark(benchmark_three_generator, 1, "three_generator")

@show sum_multiples_three_ie(3, 5, 7, 10^6)
benchmark_three_ie = @benchmark sum_multiples_three_ie(3, 5, 7, 10^6)
save_benchmark(benchmark_three_ie, 1, "three_ie")
