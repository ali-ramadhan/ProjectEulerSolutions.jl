using Test

# Test data: (script_name, input, expected_output)
test_cases = [
    ("projecteuler+_problem0001.jl", "2\n10\n100", "23\n2318\n"),
    ("projecteuler+_problem0002.jl", "2\n10\n100", "10\n44\n"),
    ("projecteuler+_problem0003.jl", "2\n10\n17", "5\n17\n"),
    ("projecteuler+_problem0004.jl", "2\n101110\n800000", "101101\n793397\n"),
    ("projecteuler+_problem0005.jl", "2\n3\n10", "6\n2520\n"),
    ("projecteuler+_problem0006.jl", "2\n3\n10", "22\n2640\n"),
    ("projecteuler+_problem0007.jl", "2\n3\n6", "5\n13\n"),
    ("projecteuler+_problem0008.jl", "2\n10 5\n3675356291\n10 5\n2709360626", "3150\n0\n"),
    ("projecteuler+_problem0009.jl", "2\n12\n4", "60\n-1\n"),
    ("projecteuler+_problem0010.jl", "2\n5\n10", "10\n17\n"),
]

for (script, input, expected) in test_cases
    problem_num = match(r"projecteuler\+_problem(\d{4})\.jl", script).captures[1]
    test_name = "HackerRank ProjectEuler+ Problem $problem_num"
    @info "Testing $test_name..."

    @eval @safetestset $test_name begin
        hacker_rank_dir = joinpath(@__DIR__, "..", "..", "hacker_rank")
        script_path = joinpath(hacker_rank_dir, $script)
        output = read(pipeline(`julia --startup-file=no $script_path`, stdin=IOBuffer($input)), String)
        @test output == $expected
    end
end
