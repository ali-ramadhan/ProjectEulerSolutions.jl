using BenchmarkTools
import CUDA
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0004

# The GPU search needs a working NVIDIA GPU, and Julia 1.12 or later to pass UInt128s to the kernel. CUDA.@sync waits
# for the GPU to finish, so the times include all of its work.
if CUDA.functional() && VERSION >= v"1.12"
    @show largest_palindrome_product_gpu(15)
    benchmark_gpu_15_digits = @benchmark CUDA.@sync largest_palindrome_product_gpu(15)
    save_benchmark(benchmark_gpu_15_digits, "problem-0004", "gpu_15_digits"; gpu=true)

    @show largest_palindrome_product_gpu(20)
    benchmark_gpu_20_digits = @benchmark CUDA.@sync largest_palindrome_product_gpu(20)
    save_benchmark(benchmark_gpu_20_digits, "problem-0004", "gpu_20_digits"; gpu=true)

    @show largest_palindrome_product_gpu(24)
    benchmark_gpu_24_digits = @benchmark CUDA.@sync largest_palindrome_product_gpu(24)
    save_benchmark(benchmark_gpu_24_digits, "problem-0004", "gpu_24_digits"; gpu=true)

    # Without the parentheses, CUDA.@sync would take evals=1 as one of its own arguments
    @show largest_palindrome_product_gpu(26)
    benchmark_gpu_26_digits = @benchmark (CUDA.@sync largest_palindrome_product_gpu(26)) evals=1
    save_benchmark(benchmark_gpu_26_digits, "problem-0004", "gpu_26_digits"; gpu=true)
else
    @warn "Skipping the GPU benchmarks since they need a working GPU and Julia 1.12 or later"
end
