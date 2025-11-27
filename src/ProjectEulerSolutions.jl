module ProjectEulerSolutions

include("utils/Utils.jl")
using .Utils

include("utils/Benchmarks.jl")
using .Benchmarks

# Find all problem files in the solutions directory
problem_files = filter(
    file -> occursin(r"problem\d{4}\.jl$", file),
    readdir(joinpath(@__DIR__, "solutions"); join = true),
)

for file in sort(problem_files)
    include(file)
end

# Include bonus problems
bonus_files = filter(
    file -> occursin(r"bonus_.*\.jl$", file),
    readdir(joinpath(@__DIR__, "bonus"); join = true),
)

for file in sort(bonus_files)
    include(file)
end

end # module
