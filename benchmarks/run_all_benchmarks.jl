# Run all benchmark scripts in the benchmarks directory

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
    bonus_scripts = filter(s -> startswith(s, "bonus_"), all_scripts)
    problem_scripts = filter(s -> startswith(s, "problem"), all_scripts)

    # Filter problem scripts by range if specified
    if !isnothing(n_start) && !isnothing(n_end)
        problem_scripts = filter(problem_scripts) do s
            m = match(r"problem(\d+)\.jl", s)
            if !isnothing(m)
                num = parse(Int, m.captures[1])
                return n_start <= num <= n_end
            end
            return false
        end
    end

    # Run problem scripts first
    for script in sort(problem_scripts)
        @info "Running $script"
        include(joinpath(@__DIR__, script))
    end

    # Run bonus scripts after (if enabled)
    if run_bonus
        for script in sort(bonus_scripts)
            @info "Running $script"
            include(joinpath(@__DIR__, script))
        end
    end
end

main()
