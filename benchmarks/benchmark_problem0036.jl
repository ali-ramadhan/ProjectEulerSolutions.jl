using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Utils.Digits: is_palindrome, make_palindrome
using ProjectEulerSolutions.Problem0036: find_double_base_palindromes_naive, find_double_base_palindromes

# The same search without the Val{K} specialization, so K is only known at runtime, to see what specializing buys
function find_double_base_palindromes_runtime_base(N, K)
    result = N > 0 ? [0] : Int[]
    for L in 1:ndigits(N - 1)
        k = cld(L, 2)
        for h in 10^(k-1):10^k-1
            p = make_palindrome(h; odd=isodd(L))
            p >= N && break
            is_palindrome(p; base=K) && push!(result, p)
        end
    end
    return result
end

@show find_double_base_palindromes_naive(10^6, 2)
benchmark_naive_1M = @benchmark find_double_base_palindromes_naive(10^6, 2)
save_benchmark(benchmark_naive_1M, "problem-0036", "find_double_base_palindromes_naive_1M")

@show find_double_base_palindromes(10^6, 2)
benchmark_1M = @benchmark find_double_base_palindromes(10^6, 2)
save_benchmark(benchmark_1M, "problem-0036", "find_double_base_palindromes_1M")

@show find_double_base_palindromes(10^12, 2)
benchmark_1T = @benchmark find_double_base_palindromes(10^12, 2) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_1T, "problem-0036", "find_double_base_palindromes_1T")

# The base goes in as $(Ref(2))[] so the compiler can't treat it as a constant
@show find_double_base_palindromes_runtime_base(10^12, 2) == find_double_base_palindromes(10^12, 2)
benchmark_runtime_base_1T = @benchmark find_double_base_palindromes_runtime_base(10^12, $(Ref(2))[]) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_runtime_base_1T, "problem-0036", "find_double_base_palindromes_runtime_base_1T")

@show find_double_base_palindromes(10^15, 2)
benchmark_1e15 = @benchmark find_double_base_palindromes(10^15, 2) samples=10 evals=1 seconds=1000
save_benchmark(benchmark_1e15, "problem-0036", "find_double_base_palindromes_1e15")

for K in 3:9
    @show K, find_double_base_palindromes(10^12, K)
    b = @benchmark find_double_base_palindromes(10^12, $K) samples=100 evals=1 seconds=1000
    save_benchmark(b, "problem-0036", "find_double_base_palindromes_1T_K$K")
end
