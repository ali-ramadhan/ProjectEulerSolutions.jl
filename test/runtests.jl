using Test
using SafeTestsets

@testset "ProjectEulerSolutions.jl" verbose=true begin
    @safetestset "Problem 001" include("test_problem001.jl")
    @safetestset "Problem 002" include("test_problem002.jl")
    @safetestset "Problem 003" include("test_problem003.jl")
    @safetestset "Problem 004" include("test_problem004.jl")
end
