# Run all benchmark scripts in the benchmarks directory

using Printf

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

function main()
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
    scripts = filter(readdir(@__DIR__)) do f
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

    total_time = 0.0

    for script in scripts
        GC.gc()
        @info "Running $script"
        elapsed = @elapsed Base.include(Module(), joinpath(@__DIR__, script))
        total_time += elapsed
        @info "Completed $script in $(format_time(elapsed))"
    end

    @info "Total runtime: $(format_time(total_time))"
end

main()
