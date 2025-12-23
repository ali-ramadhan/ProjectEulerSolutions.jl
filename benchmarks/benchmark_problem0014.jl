using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0014

@show longest_collatz_under(1_000_000)
b_1M = @benchmark longest_collatz_under(1_000_000) samples=100 evals=1 seconds=1000
save_benchmark(b_1M, "problem-0014", "longest_collatz_under_1M")

@show longest_collatz_under(10_000_000)
b_10M = @benchmark longest_collatz_under(10_000_000) samples=100 evals=1 seconds=1000
save_benchmark(b_10M, "problem-0014", "longest_collatz_under_10M")

if Sys.total_memory() >= 20 * 1024^3
    @show longest_collatz_under(100_000_000)
    b_100M = @benchmark longest_collatz_under(100_000_000) samples=10 evals=1 seconds=1000
    save_benchmark(b_100M, "problem-0014", "longest_collatz_under_100M")
else
    @warn "Skipping benchmark `longest_collatz_under_100M`: requires at least 20 GiB RAM (found $(round(Sys.total_memory() / 1024^3, digits=1)) GiB)"
end
