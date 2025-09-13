using Test
using SafeTestsets

"""
    test_problem(problem_num)

Run tests for a single Project Euler problem.

# Arguments

  - `problem_num`: Problem number (e.g., 1, "001", "42")

# Examples

```julia
# From REPL or script
include("runtests_single.jl")
test_problem(1)      # Test problem 1
test_problem("042")  # Test problem 42
test_problem(83)     # Test problem 83
```

# Usage from command line

```bash
julia runtests_single.jl 42    # Test problem 42
julia runtests_single.jl       # Interactive mode - prompts for problem number
```
"""
function test_problem(problem_num)
    # Convert to 4-digit string format
    problem_str = string(problem_num)
    if length(problem_str) <= 4
        problem_str = lpad(problem_str, 4, '0')
    else
        error("Problem number must be 4 digits or less")
    end

    test_file = "test_problem$problem_str.jl"
    test_path = joinpath(@__DIR__, test_file)

    if !isfile(test_path)
        error("Test file not found: $test_file")
    end

    @info "Running tests for Problem $problem_str..."

    test_name = "Problem $problem_str"
    @eval @safetestset $test_name include($test_file)
end

if abspath(PROGRAM_FILE) == @__FILE__
    if length(ARGS) == 1
        problem_num = parse(Int, ARGS[1])
        test_problem(problem_num)
    else
        println("Usage: julia runtests_single.jl [problem_number]")
        println("Examples:")
        println("  julia runtests_single.jl 17    # Test problem 17")
        exit(1)
    end
end
