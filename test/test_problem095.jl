using Test
using ProjectEulerSolutions.Problem095: sum_proper_divisors, find_chain, solve

@testset "Problem 95 Tests" begin
    # Test sum of proper divisors
    @test sum_proper_divisors(220) == 284
    @test sum_proper_divisors(284) == 220
    @test sum_proper_divisors(28) == 28  # Perfect number

    # Test the known amicable chain from problem description
    chain = find_chain(12496, 1_000_000)
    @test 12496 in chain
    @test 14288 in chain
    @test 15472 in chain
    @test 14536 in chain
    @test 14264 in chain
    @test length(chain) == 5

    # Test that the chain is valid (each number leads to the next)
    @test sum_proper_divisors(12496) == 14288
    @test sum_proper_divisors(14288) == 15472
    @test sum_proper_divisors(15472) == 14536
    @test sum_proper_divisors(14536) == 14264
    @test sum_proper_divisors(14264) == 12496

    # Test the final answer
    @test solve() == 14316
end
