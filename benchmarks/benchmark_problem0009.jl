using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0009

@show find_pythagorean_triplets_search(10^3)
benchmark_1e3_search = @benchmark find_pythagorean_triplets_search(10^3)
save_benchmark(benchmark_1e3_search, "problem-0009", "n_1e3_search")

@show find_pythagorean_triplets_search(10^6)
benchmark_1e6_search = @benchmark find_pythagorean_triplets_search(10^6)
save_benchmark(benchmark_1e6_search, "problem-0009", "n_1e6_search")

@show find_pythagorean_triplets_search(10^9)
benchmark_1e9_search = @benchmark find_pythagorean_triplets_search(10^9) samples=100 evals=1 seconds=3600
save_benchmark(benchmark_1e9_search, "problem-0009", "n_1e9_search")

@show find_pythagorean_triplets_euclid(10^3)
benchmark_1e3_euclid = @benchmark find_pythagorean_triplets_euclid(10^3)
save_benchmark(benchmark_1e3_euclid, "problem-0009", "n_1e3_euclid")

@show find_pythagorean_triplets_euclid(10^6)
benchmark_1e6_euclid = @benchmark find_pythagorean_triplets_euclid(10^6)
save_benchmark(benchmark_1e6_euclid, "problem-0009", "n_1e6_euclid")

@show find_pythagorean_triplets_euclid(10^9)
benchmark_1e9_euclid = @benchmark find_pythagorean_triplets_euclid(10^9)
save_benchmark(benchmark_1e9_euclid, "problem-0009", "n_1e9_euclid")

# A P near 10^9 that's hard to factor: P/2 = 22349 × 22367, two primes either side of √(P/2)
@show find_pythagorean_triplets_euclid(999760166)
benchmark_1e9_hard_euclid = @benchmark find_pythagorean_triplets_euclid(999760166)
save_benchmark(benchmark_1e9_hard_euclid, "problem-0009", "n_1e9_hard_euclid")

@show find_pythagorean_triplets_divisors(10^3)
benchmark_1e3_divisors = @benchmark find_pythagorean_triplets_divisors(10^3)
save_benchmark(benchmark_1e3_divisors, "problem-0009", "n_1e3_divisors")

@show find_pythagorean_triplets_divisors(10^6)
benchmark_1e6_divisors = @benchmark find_pythagorean_triplets_divisors(10^6)
save_benchmark(benchmark_1e6_divisors, "problem-0009", "n_1e6_divisors")

@show find_pythagorean_triplets_divisors(10^9)
benchmark_1e9_divisors = @benchmark find_pythagorean_triplets_divisors(10^9)
save_benchmark(benchmark_1e9_divisors, "problem-0009", "n_1e9_divisors")

@show find_pythagorean_triplets_divisors(999760166)
benchmark_1e9_hard_divisors = @benchmark find_pythagorean_triplets_divisors(999760166)
save_benchmark(benchmark_1e9_hard_divisors, "problem-0009", "n_1e9_hard_divisors")

@show find_pythagorean_triplets_divisors(10^18)
benchmark_1e18_divisors = @benchmark find_pythagorean_triplets_divisors(10^18)
save_benchmark(benchmark_1e18_divisors, "problem-0009", "n_1e18_divisors")
