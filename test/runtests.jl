using Test
using SafeTestsets

# The Aqua.jl checks run on their own (a separate CI job) with `Pkg.test(test_args=["aqua"])`
if "aqua" in ARGS
    include("aqua.jl")
else
    @testset "ProjectEulerSolutions.jl" verbose=true begin
        @safetestset "Digits" include("utils/test_digits.jl")
        @safetestset "Divisors" include("utils/test_divisors.jl")
        @safetestset "Primes" include("utils/test_primes.jl")
        @safetestset "Sequences" include("utils/test_sequences.jl")
        @safetestset "NumberTheory" include("utils/test_number_theory.jl")
        @safetestset "AnswerHashing" include("utils/test_answer_hashing.jl")

        # Problem tests are `test_problemNNNN.jl` and bonus problem tests are `test_bonus_<name>.jl`.
        test_files = filter(
            file -> occursin(r"^test_(problem\d{4}|bonus_\w+)\.jl$", file),
            readdir(joinpath(@__DIR__, "solutions"))
        )

        # Problems first, then bonus problems
        sort!(test_files; by = file -> (startswith(file, "test_bonus_"), file))

        for test_file in test_files
            m = match(r"^test_(?:problem(\d{4})|bonus_(\w+))\.jl$", test_file)
            test_name = isnothing(m[1]) ? "Bonus $(m[2])" : "Problem $(m[1])"
            test_path = joinpath(@__DIR__, "solutions", test_file)
            @info "Testing $test_name..."
            @eval @safetestset $test_name include($test_path)
        end

        include("hacker_rank/test_hacker_rank.jl")
    end
end
