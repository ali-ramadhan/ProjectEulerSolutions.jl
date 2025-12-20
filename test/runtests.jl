using Test
using SafeTestsets

@testset "ProjectEulerSolutions.jl" verbose=true begin
    @safetestset "Digits" include("utils/test_digits.jl")
    @safetestset "Divisors" include("utils/test_divisors.jl")
    @safetestset "Primes" include("utils/test_primes.jl")
    @safetestset "Sequences" include("utils/test_sequences.jl")
    @safetestset "NumberTheory" include("utils/test_number_theory.jl")

    # Test problem solutions
    test_files = filter(
        file -> occursin(r"^test_problem\d{4}\.jl$", file),
        readdir(joinpath(@__DIR__, "problems"))
    )

    sort!(test_files)

    for test_file in test_files
        problem_num = match(r"test_problem(\d{4})\.jl", test_file).captures[1]
        test_name = "Problem $problem_num"
        @info "Testing $test_name..."
        @eval @safetestset $test_name include(joinpath("problems", $test_file))
    end

    # Test bonus problems
    bonus_test_files = filter(
        file -> occursin(r"^test_bonus_.*\.jl$", file),
        readdir(joinpath(@__DIR__, "bonus"))
    )

    sort!(bonus_test_files)

    for test_file in bonus_test_files
        bonus_name = match(r"test_bonus_(.*)\.jl", test_file).captures[1]
        test_name = "Bonus $bonus_name"
        @info "Testing $test_name..."
        @eval @safetestset $test_name include(joinpath("bonus", $test_file))
    end

    @safetestset "HackerRank ProjectEuler+" include("hacker_rank/test_hacker_rank.jl")
end
