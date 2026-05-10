using BenchmarkTools
using ProjectEulerSolutions.Problem0033: multiply_curious_fractions, solve
using ProjectEulerSolutions.Utils.Benchmarks: save_benchmark

for (N, K) in [(2, 1), (3, 2), (4, 1), (4, 3)]
    @show N, K, multiply_curious_fractions(N, K)
    b = @benchmark multiply_curious_fractions($N, $K)
    label = "multiply_curious_fractions_N$(N)_K$(K)"
    save_benchmark(b, "problem-0033", label)
end
