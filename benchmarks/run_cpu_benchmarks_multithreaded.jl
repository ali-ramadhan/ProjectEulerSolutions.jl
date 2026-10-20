# Runs the multi-threaded CPU benchmarks, e.g. `julia --threads=auto --project=. benchmarks/run_cpu_benchmarks_multithreaded.jl`
#
# These are the scripts in `multithreaded/`, one for each solution that uses threads. They save their results with the
# number of threads and under benchmark names ending with `_multithreaded`, so that they don't replace the serial
# results on the same CPU. Takes the same arguments as `run_cpu_benchmarks_serial.jl`.
include("runner.jl")

Threads.nthreads() > 1 || error("Julia was started with one thread; run with e.g. `--threads=auto` to benchmark with threads")

run_benchmarks(joinpath(@__DIR__, "multithreaded"))
