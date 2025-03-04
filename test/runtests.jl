using Test
using SafeTestsets

@testset "ProjectEulerSolutions.jl" verbose=true begin
    test_files = filter(
        file -> occursin(r"^test_problem\d{3}\.jl$", file),
        readdir(@__DIR__)
    )

    sort!(test_files)

    for test_file in test_files
        problem_num = match(r"test_problem(\d{3})\.jl", test_file).captures[1]
        test_name = "Problem $problem_num"
        @info "Testing $test_name..."
        @eval @safetestset $test_name include($test_file)
    end
end
