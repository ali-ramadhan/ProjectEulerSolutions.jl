module ProjectEulerSolutions

# Find all problem files in the solutions directory
problem_files = filter(
    file -> occursin(r"problem\d{3}\.jl$", file),
    readdir(joinpath(@__DIR__, "solutions"), join=true)
)

for file in sort(problem_files)
    include(file)
end

end # module
