using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0003: largest_prime_factor

@show largest_prime_factor(600851475143)
benchmark1 = @benchmark largest_prime_factor(600851475143)
save_benchmark(benchmark1, "problem-0003", "problem")

@show largest_prime_factor(2^55 - 55)
benchmark2 = @benchmark largest_prime_factor(2^55 - 55) samples=100 evals=1 seconds=1000
save_benchmark(benchmark2, "problem-0003", "cool_prime")

@show largest_prime_factor(268435399 * 536870923)
benchmark3 = @benchmark largest_prime_factor(268435399 * 536870923) samples=100 evals=1 seconds=1000
save_benchmark(benchmark3, "problem-0003", "semiprime")
