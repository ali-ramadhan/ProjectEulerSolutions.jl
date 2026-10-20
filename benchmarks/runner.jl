# What the benchmark runners share. Each runner checks that Julia was started the way its benchmarks need, e.g. with
# one thread, and then runs the benchmark scripts in its directory with `run_benchmarks`.

using Printf
using ProjectEulerSolutions.Logging

function format_time(seconds)
    if seconds < 60
        return @sprintf("%.2f seconds", seconds)
    elseif seconds < 3600
        return @sprintf("%.2f minutes", seconds / 60)
    else
        return @sprintf("%.2f hours", seconds / 3600)
    end
end

is_bonus(script) = startswith(script, "benchmark_bonus_")

"""
    run_benchmarks(dir)

Run the benchmark scripts in `dir`, problems first and then bonus problems, each in a fresh module. The command line
arguments are optional: `--no-bonus` skips the bonus problems, and two numbers, e.g. `1 10`, restrict the numbered
problems to that range.
"""
function run_benchmarks(dir)
    # Parse command line arguments
    run_bonus = true
    n_start = nothing
    n_end = nothing

    for arg in ARGS
        if arg == "--no-bonus"
            run_bonus = false
        elseif arg == "--bonus"
            run_bonus = true
        elseif isnothing(n_start)
            n_start = parse(Int, arg)
        elseif isnothing(n_end)
            n_end = parse(Int, arg)
        end
    end

    # Problem benchmarks are `benchmark_problemNNNN.jl` and bonus benchmarks are `benchmark_bonus_<name>.jl`.
    scripts = filter(readdir(dir)) do f
        occursin(r"^benchmark_(problem\d{4}|bonus_\w+)\.jl$", f)
    end

    if !run_bonus
        filter!(!is_bonus, scripts)
    end

    # A problem range only restricts the numbered problems; bonus scripts still run unless --no-bonus is given.
    if !isnothing(n_start) && !isnothing(n_end)
        filter!(scripts) do s
            m = match(r"^benchmark_problem(\d{4})\.jl$", s)
            isnothing(m) || n_start <= parse(Int, m[1]) <= n_end
        end
    end

    # Problems first, then bonus problems
    sort!(scripts; by = s -> (is_bonus(s), s))

    with_logger(TimestampedLogger()) do
        total_time = 0.0

        for script in scripts
            GC.gc()
            @info "Running $script"
            elapsed = @elapsed Base.include(Module(), joinpath(dir, script))
            total_time += elapsed
            @info "Completed $script in $(format_time(elapsed))"
        end

        @info "Total runtime: $(format_time(total_time))"
    end
end
