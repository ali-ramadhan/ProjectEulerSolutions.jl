module ProjectEulerSolutions

include("utils/Utils.jl")
using .Utils

# Solution files are discovered with `readdir`, which precompilation does not track.
# Declaring the directory as a dependency makes the package recompile when a file is added or removed.
Base.include_dependency(joinpath(@__DIR__, "solutions"))

# Problem solutions are `problemNNNN.jl` and bonus problems are `bonus_<name>.jl`.
solution_files = filter(
    file -> occursin(r"^(problem\d{4}|bonus_\w+)\.jl$", file),
    readdir(joinpath(@__DIR__, "solutions")),
)

# Problems first, then bonus problems
sort!(solution_files; by = file -> (startswith(file, "bonus_"), file))

for file in solution_files
    include(joinpath(@__DIR__, "solutions", file))
end

end # module
