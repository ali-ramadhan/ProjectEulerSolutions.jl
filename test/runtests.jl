using Test
using SafeTestsets

@safetestset "ProjectEulerSolutions.jl" begin
    @safetestset "Problem 001" include("test_problem001.jl")
    @safetestset "Problem 002" include("test_problem002.jl")
end
