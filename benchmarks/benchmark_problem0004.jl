using BenchmarkTools
import CUDA
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0004

@show largest_palindrome_product_naive(3)
benchmark_naive_3_digits = @benchmark largest_palindrome_product_naive(3)
save_benchmark(benchmark_naive_3_digits, "problem-0004", "naive_3_digits")

@show largest_palindrome_product(3)
benchmark_3_digits = @benchmark largest_palindrome_product(3)
save_benchmark(benchmark_3_digits, "problem-0004", "3_digits")

@show largest_palindrome_product(6)
benchmark_6_digits = @benchmark largest_palindrome_product(6)
save_benchmark(benchmark_6_digits, "problem-0004", "6_digits")

@show largest_palindrome_product(9)
benchmark_9_digits = @benchmark largest_palindrome_product(9) samples=10 evals=1 seconds=100
save_benchmark(benchmark_9_digits, "problem-0004", "9_digits")

@show largest_palindrome_product_fermat(9)
benchmark_fermat_9_digits = @benchmark largest_palindrome_product_fermat(9)
save_benchmark(benchmark_fermat_9_digits, "problem-0004", "fermat_9_digits")

@show largest_palindrome_product_fermat(12)
benchmark_fermat_12_digits = @benchmark largest_palindrome_product_fermat(12)
save_benchmark(benchmark_fermat_12_digits, "problem-0004", "fermat_12_digits")

@show largest_palindrome_product_fermat(15)
benchmark_fermat_15_digits = @benchmark largest_palindrome_product_fermat(15)
save_benchmark(benchmark_fermat_15_digits, "problem-0004", "fermat_15_digits")

@show largest_palindrome_product_fermat_filtered(12)
benchmark_fermat_filtered_12_digits = @benchmark largest_palindrome_product_fermat_filtered(12)
save_benchmark(benchmark_fermat_filtered_12_digits, "problem-0004", "fermat_filtered_12_digits")

@show largest_palindrome_product_fermat_filtered(15)
benchmark_fermat_filtered_15_digits = @benchmark largest_palindrome_product_fermat_filtered(15)
save_benchmark(benchmark_fermat_filtered_15_digits, "problem-0004", "fermat_filtered_15_digits")

@show largest_palindrome_product_fermat_filtered(20)
benchmark_fermat_filtered_20_digits = @benchmark largest_palindrome_product_fermat_filtered(20)
save_benchmark(benchmark_fermat_filtered_20_digits, "problem-0004", "fermat_filtered_20_digits")

# The GPU search needs a working NVIDIA GPU, and Julia 1.12 or later to pass UInt128s to the kernel. CUDA.@sync waits
# for the GPU to finish, so the times include all of its work.
if CUDA.functional() && VERSION >= v"1.12"
    @show largest_palindrome_product_gpu(20)
    benchmark_gpu_20_digits = @benchmark CUDA.@sync largest_palindrome_product_gpu(20)
    save_benchmark(benchmark_gpu_20_digits, "problem-0004", "gpu_20_digits"; gpu=true)

    @show largest_palindrome_product_gpu(24)
    benchmark_gpu_24_digits = @benchmark CUDA.@sync largest_palindrome_product_gpu(24)
    save_benchmark(benchmark_gpu_24_digits, "problem-0004", "gpu_24_digits"; gpu=true)
else
    @warn "Skipping the GPU benchmarks since they need a working GPU and Julia 1.12 or later"
end
