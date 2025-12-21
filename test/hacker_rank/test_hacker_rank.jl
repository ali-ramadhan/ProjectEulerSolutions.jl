using Test
using SafeTestsets

const TEST_DATA_DIR = joinpath(@__DIR__, "data")

function load_test_input(prefix::String)
    input_path = joinpath(TEST_DATA_DIR, "$(prefix)_input.txt")
    return read(input_path, String)
end

function load_test_data(prefix::String)
    input_path = joinpath(TEST_DATA_DIR, "$(prefix)_input.txt")
    output_path = joinpath(TEST_DATA_DIR, "$(prefix)_output.txt")
    input = read(input_path, String)
    output = read(output_path, String)
    return (input, output)
end

# Test data formats:
#   Inline:           (script, input, expected)
#   Input from file:  (script, :file_input, prefix, expected)
#   Both from files:  (script, :file, prefix)
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
    ("projecteuler+_problem0011.jl", :file_input, "problem0011", "73812150\n"),
    ("projecteuler+_problem0012.jl", "4\n1\n2\n3\n4", "3\n6\n6\n28\n"),
    ("projecteuler+_problem0013.jl", :file_input, "problem0013", "2728190129\n"),
    ("projecteuler+_problem0014.jl", "3\n10\n15\n20", "9\n9\n19\n"),
    ("projecteuler+_problem0015.jl", "2\n2 2\n3 2", "6\n10\n"),
    ("projecteuler+_problem0016.jl", "3\n3\n4\n7", "8\n7\n11\n"),
    ("projecteuler+_problem0017.jl", "2\n10\n17", "Ten\nSeventeen\n"),
    ("projecteuler+_problem0018.jl", "1\n4\n3\n7 4\n2 4 6\n8 5 9 3", "23\n"),
    ("projecteuler+_problem0019.jl", "2\n1900 1 1\n1910 1 1\n2000 1 1\n2020 1 1", "18\n35\n"),
    ("projecteuler+_problem0020.jl", "2\n3\n6", "6\n9\n"),
    ("projecteuler+_problem0021.jl", "1\n300", "504\n"),
    ("projecteuler+_problem0022.jl", "5\nALEX\nLUIS\nJAMES\nBRIAN\nPAMELA\n1\nPAMELA", "240\n"),
    ("projecteuler+_problem0023.jl", "2\n24\n49", "YES\nNO\n"),
    ("projecteuler+_problem0024.jl", "2\n1\n2", "abcdefghijklm\nabcdefghijkml\n"),
    ("projecteuler+_problem0025.jl", "2\n3\n4", "12\n17\n"),
    ("projecteuler+_problem0026.jl", "2\n5\n10", "3\n7\n"),
    ("projecteuler+_problem0027.jl", "42", "-1 41\n"),
    ("projecteuler+_problem0028.jl", "2\n3\n5", "25\n101\n"),
]

for test_case in test_cases
    script = test_case[1]

    # Resolve input/output (inline or from file)
    if test_case[2] === :file
        input, expected = load_test_data(test_case[3])
    elseif test_case[2] === :file_input
        input = load_test_input(test_case[3])
        expected = test_case[4]
    else
        input, expected = test_case[2], test_case[3]
    end

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
