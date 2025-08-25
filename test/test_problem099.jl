using Test
using ProjectEulerSolutions.Problem99: read_base_exp_pairs, find_largest_exponential, solve

@testset "Problem 99 Tests" begin
    
    @testset "Basic functionality tests" begin
        # Test with simple examples from problem statement
        # 2^11 = 2048 < 3^7 = 2187
        test_pairs = [(2, 11), (3, 7)]
        @test find_largest_exponential(test_pairs) == 2
        
        # Test with the first two lines from the actual file
        # 632382^518061 > 519432^525806 (as stated in problem)
        first_two = [(519432, 525806), (632382, 518061)]
        @test find_largest_exponential(first_two) == 2
    end
    
    @testset "Edge cases" begin
        # Single pair
        @test find_largest_exponential([(10, 5)]) == 1
        
        # Equal values (same base and exponent)
        equal_pairs = [(2, 3), (2, 3)]
        @test find_largest_exponential(equal_pairs) == 1  # First occurrence
    end
    
    # Test the final answer
    @test solve() == 709
end