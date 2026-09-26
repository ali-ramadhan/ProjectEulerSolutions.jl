using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0036: find_double_base_palindromes

@show find_double_base_palindromes(10^6, 2)
benchmark_1M = @benchmark find_double_base_palindromes(10^6, 2)
save_benchmark(benchmark_1M, "problem-0036", "find_double_base_palindromes_1M")

@show find_double_base_palindromes(10^12, 2)
benchmark_1T = @benchmark find_double_base_palindromes(10^12, 2) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1T, "problem-0036", "find_double_base_palindromes_1T")

for K in 3:9
    @show K, find_double_base_palindromes(10^12, K)
    b = @benchmark find_double_base_palindromes(10^12, $K) samples=100 evals=1 seconds=1000
    save_benchmark(b, "problem-0036", "find_double_base_palindromes_1T_K$K")
end
