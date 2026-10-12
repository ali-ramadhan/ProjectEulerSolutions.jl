using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0007

@show find_nth_prime(10001)
benchmark_10001 = @benchmark find_nth_prime(10001)
save_benchmark(benchmark_10001, "problem-0007", "n_10001")

@show find_nth_prime(100000)
benchmark_100k = @benchmark find_nth_prime(100000)
save_benchmark(benchmark_100k, "problem-0007", "n_100k")

@show find_nth_prime(1000000)
benchmark_1m = @benchmark find_nth_prime(1000000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1m, "problem-0007", "n_1M")

@show find_nth_prime_counting(10001)
benchmark_counting_10001 = @benchmark find_nth_prime_counting(10001)
save_benchmark(benchmark_counting_10001, "problem-0007", "counting_n_10001")

@show find_nth_prime_counting(10^6)
benchmark_counting_1M = @benchmark find_nth_prime_counting(10^6)
save_benchmark(benchmark_counting_1M, "problem-0007", "counting_n_1M")

@show find_nth_prime_counting(10^9)
benchmark_counting_1B = @benchmark find_nth_prime_counting(10^9)
save_benchmark(benchmark_counting_1B, "problem-0007", "counting_n_1B")

@show find_nth_prime_counting(10^12)
benchmark_counting_1T = @benchmark find_nth_prime_counting(10^12) samples=10 evals=1 seconds=1000
save_benchmark(benchmark_counting_1T, "problem-0007", "counting_n_1T")
