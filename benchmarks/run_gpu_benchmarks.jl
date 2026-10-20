# Runs the GPU benchmarks on the current CUDA device, e.g. `julia --project=. benchmarks/run_gpu_benchmarks.jl`
#
# These are the scripts in `gpu/`, one for each solution that runs on an NVIDIA GPU. They save their results under the
# GPU's name rather than the CPU's, with benchmark names starting with `gpu_`. Takes the same arguments as
# `run_cpu_benchmarks_serial.jl`.
import CUDA

include("runner.jl")

CUDA.functional() || error("The GPU benchmarks need a working NVIDIA GPU, but `CUDA.functional()` is false")

run_benchmarks(joinpath(@__DIR__, "gpu"))
