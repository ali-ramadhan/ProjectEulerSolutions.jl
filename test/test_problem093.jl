using Test
using ProjectEulerSolutions.Problem093: all_expressions, consecutive_length, solve

# Test the example case with digits {1, 2, 3, 4}
@testset "Example case {1, 2, 3, 4}" begin
    results = all_expressions(1, 2, 3, 4)

    # Should be able to generate specific values mentioned in problem
    @test 8 in results    # (4 * (1 + 3)) / 2
    @test 14 in results   # 4 * (3 + 1 / 2)
    @test 19 in results   # 4 * (2 + 3) - 1
    @test 36 in results   # 3 * 4 * (2 + 1)

    # Test consecutive length - should be 28 for {1,2,3,4}
    consecutive = consecutive_length(results)
    @test consecutive == 28
end

@testset "Consecutive length function" begin
    # Test with simple set
    @test consecutive_length(Set([1, 2, 3, 5, 6])) == 3  # 1,2,3 consecutive
    @test consecutive_length(Set([2, 3, 4, 5])) == 0     # starts from 2, not 1
    @test consecutive_length(Set([1, 3, 4, 5])) == 1     # only 1 consecutive from start
end

@testset "Fractional intermediate results" begin
    # Test case that requires fractional intermediates (from forum feedback)
    results_1258 = all_expressions(1, 2, 5, 8)
    @test 44 in results_1258  # Requires intermediate 5.5 (e.g., 8 * (5 + 1/2))
    @test consecutive_length(results_1258) == 51

    # Contrasting case - should produce shorter sequence
    results_1256 = all_expressions(1, 2, 5, 6)
    consecutive_1256 = consecutive_length(results_1256)
    @test consecutive_1256 < 51  # Should be around 43
end

@testset "Performance benchmark" begin
    # Test that solution runs in reasonable time (sub-second as reported in forums)
    elapsed_time = @elapsed solve()
    @test elapsed_time < 1.0  # Should be sub-second
    println("Problem 93 solve() took $(elapsed_time) seconds")
end

# Correct answer
@test solve() == "1258"
