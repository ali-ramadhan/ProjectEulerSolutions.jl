using Test
using SafeTestsets

"""
    test_problem(problem_id)

Run the tests for a single Project Euler problem or bonus problem.

# Arguments

  - `problem_id`: Problem number (e.g. `1`, `"042"`, `"0083"`) or bonus problem name (e.g. `"root13"`, `"18i"`)

# Examples

```julia
# From REPL or script
include("runtests_single.jl")
test_problem(1)         # Test problem 1
test_problem("042")     # Test problem 42
test_problem("root13")  # Test bonus problem root13
```

# Usage from command line

```bash
julia runtests_single.jl 42      # Test problem 42
julia runtests_single.jl root13  # Test bonus problem root13
```
"""
function test_problem(problem_id)
    id = string(problem_id)

    if occursin(r"^\d+$", id)
        length(id) <= 4 || error("Problem number must be 4 digits or less: $id")
        id = lpad(id, 4, '0')
        test_name = "Problem $id"
        test_file = "test_problem$id.jl"
    elseif occursin(r"^\w+$", id)
        test_name = "Bonus $id"
        test_file = "test_bonus_$id.jl"
    else
        error("Invalid problem ID: $id (expected a problem number or a bonus problem name)")
    end

    test_path = joinpath(@__DIR__, "solutions", test_file)
    isfile(test_path) || error("Test file not found: solutions/$test_file")

    @info "Running tests for $test_name..."
    @eval @safetestset $test_name include($test_path)
end

if abspath(PROGRAM_FILE) == @__FILE__
    if length(ARGS) == 1
        test_problem(ARGS[1])
    else
        println("Usage: julia runtests_single.jl <problem_number | bonus_name>")
        println("Examples:")
        println("  julia runtests_single.jl 17      # Test problem 17")
        println("  julia runtests_single.jl root13  # Test bonus problem root13")
        exit(1)
    end
end
