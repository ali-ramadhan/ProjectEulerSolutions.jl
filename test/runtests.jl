using Test
using SafeTestsets

@testset "ProjectEulerSolutions.jl" verbose=true begin
    @safetestset "Digits" include("test_digits.jl")
    @safetestset "Divisors" include("test_divisors.jl")
    @safetestset "Primes" include("test_primes.jl")
    @safetestset "Sequences" include("test_sequences.jl")
    @safetestset "NumberTheory" include("test_number_theory.jl")

    # Test problem solutions
    test_files =
        filter(file -> occursin(r"^test_problem\d{3}\.jl$", file), readdir(@__DIR__))

    sort!(test_files)

    for test_file in test_files
        problem_num = match(r"test_problem(\d{3})\.jl", test_file).captures[1]
        test_name = "Problem $problem_num"
        @info "Testing $test_name..."
        @eval @safetestset $test_name include($test_file)
    end
end
