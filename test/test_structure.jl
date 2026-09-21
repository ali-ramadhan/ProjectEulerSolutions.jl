# Checks that the files describing each solution stay in sync: every solution in `src/solutions/` must have a
# test file, a benchmark script and a recorded answer hash, and every numbered problem a HackerRank script with
# an entry in the HackerRank test cases. Without this a HackerRank script with no test case is silently untested.
using Test
using TOML

const REPO_DIR = normpath(joinpath(@__DIR__, ".."))

# The solutions the files in `dir` matching `pattern` belong to, e.g. "problem0001" or "bonus_root13"
function solution_names(dir, pattern)
    names = Set{String}()
    for file in readdir(joinpath(REPO_DIR, dir))
        m = match(pattern, file)
        isnothing(m) || push!(names, m[1])
    end
    return names
end

solutions  = solution_names("src/solutions",  r"^(problem\d{4}|bonus_\w+)\.jl$")
tests      = solution_names("test/solutions", r"^test_(problem\d{4}|bonus_\w+)\.jl$")
benchmarks = solution_names("benchmarks",     r"^benchmark_(problem\d{4}|bonus_\w+)\.jl$")
scripts    = solution_names("hacker_rank",    r"^projecteuler\+_(problem\d{4})\.jl$")

problems = filter(startswith("problem"), solutions)

include(joinpath(@__DIR__, "hacker_rank", "test_cases.jl"))
tested_scripts = Set(replace(first(case), r"^projecteuler\+_(problem\d{4})\.jl$" => s"\1") for case in test_cases)

hashes = TOML.parsefile(joinpath(REPO_DIR, "test", "answers.toml"))
problem_hashes = Set("problem" * id for id in keys(hashes["problems"]))
bonus_hashes   = Set("bonus_" * name for name in keys(hashes["bonus"]))

# Both directions: nothing missing, nothing left over (a failure lists the offending solution names)
function test_matching(a_name, a, b_name, b)
    @testset "$a_name without $b_name" begin
        @test isempty(setdiff(a, b))
    end
    @testset "$b_name without $a_name" begin
        @test isempty(setdiff(b, a))
    end
end

@testset "Repository structure" begin
    @test !isempty(solutions)

    test_matching("solutions", solutions, "test files", tests)
    test_matching("solutions", solutions, "benchmark scripts", benchmarks)
    test_matching("problems", problems, "HackerRank scripts", scripts)
    test_matching("HackerRank scripts", scripts, "HackerRank test cases", tested_scripts)
    test_matching("problems", problems, "answer hashes", problem_hashes)

    # Not every bonus problem has an answer to hash (e.g. `secret`), but every recorded hash must belong to one
    @testset "bonus answer hashes without solutions" begin
        @test isempty(setdiff(bonus_hashes, solutions))
    end
end
