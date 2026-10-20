# Runs the serial CPU benchmarks, e.g. `julia --threads=1 --project=. benchmarks/run_cpu_benchmarks_serial.jl`
#
# `--no-bonus` skips the bonus problems, and two numbers, e.g. `1 10`, restrict the numbered problems to that range.
# The multi-threaded and GPU benchmarks have their own runners, `run_cpu_benchmarks_multithreaded.jl` and
# `run_gpu_benchmarks.jl`, which take the same arguments.
include("runner.jl")

# With more threads, the solutions that use threads would run in parallel, and so would the garbage collector
Threads.nthreads() == 1 || error("Julia was started with $(Threads.nthreads()) threads; run with `--threads=1` to benchmark serially")

run_benchmarks(@__DIR__)
