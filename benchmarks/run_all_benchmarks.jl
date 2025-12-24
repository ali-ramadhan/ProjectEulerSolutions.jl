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

    all_scripts = filter(readdir(@__DIR__)) do f
        endswith(f, ".jl") && f != "run_all_benchmarks.jl"
    end

    # Separate bonus and problem scripts
    bonus_scripts = filter(s -> startswith(s, "benchmark_bonus_"), all_scripts)
    problem_scripts = filter(s -> startswith(s, "benchmark_problem"), all_scripts)

    # Filter problem scripts by range if specified
    if !isnothing(n_start) && !isnothing(n_end)
        problem_scripts = filter(problem_scripts) do s
            m = match(r"benchmark_problem(\d+)\.jl", s)
            if !isnothing(m)
                num = parse(Int, m.captures[1])
                return n_start <= num <= n_end
            end
            return false
        end
    end

    total_time = 0.0

    # Run problem scripts first
    for script in sort(problem_scripts)
        GC.gc()
        @info "Running $script"
        elapsed = @elapsed Base.include(Module(), joinpath(@__DIR__, script))
        total_time += elapsed
        @info "Completed $script in $(format_time(elapsed))"
    end

    # Run bonus scripts after (if enabled)
    if run_bonus
        for script in sort(bonus_scripts)
            GC.gc()
            @info "Running $script"
            elapsed = @elapsed Base.include(Module(), joinpath(@__DIR__, script))
            total_time += elapsed
            @info "Completed $script in $(format_time(elapsed))"
        end
    end

    @info "Total runtime: $(format_time(total_time))"
end

main()
