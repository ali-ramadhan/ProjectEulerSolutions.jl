using Test
using SafeTestsets

@testset "ProjectEulerSolutions.jl" verbose=true begin
    @safetestset "Problem 001" include("test_problem001.jl")
    @safetestset "Problem 002" include("test_problem002.jl")
    @safetestset "Problem 003" include("test_problem003.jl")
    @safetestset "Problem 004" include("test_problem004.jl")
    @safetestset "Problem 005" include("test_problem005.jl")
    @safetestset "Problem 006" include("test_problem006.jl")
    @safetestset "Problem 007" include("test_problem007.jl")
    @safetestset "Problem 008" include("test_problem008.jl")
    @safetestset "Problem 009" include("test_problem009.jl")
    @safetestset "Problem 010" include("test_problem010.jl")
    @safetestset "Problem 011" include("test_problem011.jl")
    @safetestset "Problem 012" include("test_problem012.jl")
    @safetestset "Problem 013" include("test_problem013.jl")
    @safetestset "Problem 014" include("test_problem014.jl")
end
