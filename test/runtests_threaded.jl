# Runs the tests of only the solutions that use threads, e.g. `julia --threads=4 --project=. test/runtests_threaded.jl`
#
# Those solutions take a serial path when Julia has a single thread, which is how the full test suite runs,
# so their threaded code is only exercised here (and in CI by a separate job).
using Test

include("runtests_single.jl")

Threads.nthreads() > 1 || error("Julia was started with one thread; run with e.g. `--threads=4` to exercise the threaded solutions")

const SOLUTIONS_DIR = joinpath(@__DIR__, "..", "src", "solutions")

uses_threads(file) = occursin(r"Threads\.|@spawn\b|@threads\b", read(joinpath(SOLUTIONS_DIR, file), String))

threaded_solutions = filter(readdir(SOLUTIONS_DIR)) do file
    occursin(r"^(problem\d{4}|bonus_\w+)\.jl$", file) && uses_threads(file)
end
isempty(threaded_solutions) && error("No solutions using threads found in $SOLUTIONS_DIR")

# Problems first, then bonus problems
sort!(threaded_solutions; by = file -> (startswith(file, "bonus_"), file))

# `problemNNNN.jl` -> "NNNN" and `bonus_<name>.jl` -> "<name>", which is what `test_problem` takes
problem_ids = map(threaded_solutions) do file
    m = match(r"^(?:problem(\d{4})|bonus_(\w+))\.jl$", file)
    something(m[1], m[2])
end

@info "Testing the $(length(problem_ids)) solution(s) that use threads with $(Threads.nthreads()) threads: $(join(problem_ids, ", "))"

@testset "Threaded solutions ($(Threads.nthreads()) threads)" verbose=true begin
    for problem_id in problem_ids
        test_problem(problem_id)
    end
end
