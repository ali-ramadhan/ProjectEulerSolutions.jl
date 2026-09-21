using Test
using SafeTestsets

const TEST_DATA_DIR = joinpath(@__DIR__, "data")

# HackerRank runs submissions on Julia 1.2.0 (https://support.hackerrank.com/articles/6693750503-execution-environment),
# so CI runs the scripts with that version by pointing `HACKERRANK_JULIA` at its executable (see .github/workflows/ci.yaml).
# Without the override the scripts run with the same Julia as the tests.
const HACKERRANK_JULIA = haskey(ENV, "HACKERRANK_JULIA") ? `$(ENV["HACKERRANK_JULIA"])` : Base.julia_cmd()

function load_test_input(prefix::String)
    input_path = joinpath(TEST_DATA_DIR, "$(prefix)_input.txt")
    return read(input_path, String)
end

function load_test_data(prefix::String)
    input_path = joinpath(TEST_DATA_DIR, "$(prefix)_input.txt")
    output_path = joinpath(TEST_DATA_DIR, "$(prefix)_output.txt")
    input = read(input_path, String)
    output = read(output_path, String)
    return (input, output)
end

include("test_cases.jl")

@info "Running HackerRank scripts with $(readchomp(`$HACKERRANK_JULIA --version`))"

# Wrapped in a testset so this file can also be run on its own: `julia --project=. test/hacker_rank/test_hacker_rank.jl`
@testset "HackerRank" verbose=true begin
    for test_case in test_cases
        script = test_case[1]

        # Resolve input/output (inline or from file)
        if test_case[2] === :file
            input, expected = load_test_data(test_case[3])
        elseif test_case[2] === :file_input
            input = load_test_input(test_case[3])
            expected = test_case[4]
        else
            input, expected = test_case[2], test_case[3]
        end

        problem_num = match(r"projecteuler\+_problem(\d{4})\.jl", script).captures[1]
        test_name = "HackerRank ProjectEuler+ Problem $problem_num"
        @info "Testing $test_name..."

        @eval @safetestset $test_name begin
            julia_cmd = $HACKERRANK_JULIA
            hacker_rank_dir = joinpath(@__DIR__, "..", "..", "hacker_rank")
            script_path = joinpath(hacker_rank_dir, $script)
            output = read(pipeline(`$julia_cmd --startup-file=no $script_path`, stdin=IOBuffer($input)), String)
            @test output == $expected
        end
    end
end
