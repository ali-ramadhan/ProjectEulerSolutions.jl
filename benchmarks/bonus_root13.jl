using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.BonusRoot13: sum_sqrt_decimal_digits

function S_not_creative(n, d)
    precision_bits = ceil(Int, (d + 2) * log2(10))
    setprecision(BigFloat, precision_bits) do
        val = sqrt(big(n))
        frac_digits_str = split(string(val), '.')[2][1:d]
        return sum(parse(Int, c) for c in frac_digits_str)
    end
end

@show S_not_creative(13, 1000)
benchmark_S_not_creative = @benchmark S_not_creative(13, 1000)
save_benchmark(benchmark_S_not_creative, "bonus-root13", "S_not_creative_13_1000")

@show S_not_creative(13, 10000)
benchmark_S_not_creative = @benchmark S_not_creative(13, 10000)
save_benchmark(benchmark_S_not_creative, "bonus-root13", "S_not_creative_13_10000")

@show S_not_creative(13, 100000)
benchmark_S_not_creative = @benchmark S_not_creative(13, 100000)
save_benchmark(benchmark_S_not_creative, "bonus-root13", "S_not_creative_13_100000")

@show sum_sqrt_decimal_digits(13, 1000)
benchmark_sum_sqrt_decimal_digits = @benchmark sum_sqrt_decimal_digits(13, 1000)
save_benchmark(benchmark_sum_sqrt_decimal_digits, "bonus-root13", "S_13_1000")

@show sum_sqrt_decimal_digits(13, 10000)
benchmark_sum_sqrt_decimal_digits = @benchmark sum_sqrt_decimal_digits(13, 10000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_sum_sqrt_decimal_digits, "bonus-root13", "S_13_10000")

@show sum_sqrt_decimal_digits(13, 100000)
benchmark_sum_sqrt_decimal_digits = @benchmark sum_sqrt_decimal_digits(13, 100000) samples=100 evals=1 seconds=1000
save_benchmark(benchmark_sum_sqrt_decimal_digits, "bonus-root13", "S_13_100000")
