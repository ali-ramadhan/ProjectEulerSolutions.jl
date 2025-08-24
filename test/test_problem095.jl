using Test
using ProjectEulerSolutions.Problem095: sum_proper_divisors, find_amicable_chain, solve

@testset "Divisor sum" begin
    @test sum_proper_divisors(220) == 284
    @test sum_proper_divisors(284) == 220
    @test sum_proper_divisors(28) == 28  # Perfect number
    @test sum_proper_divisors(6) == 6    # Perfect number
    @test sum_proper_divisors(496) == 496 # Perfect number

    # Test amicable pair (1184, 1210)
    @test sum_proper_divisors(1184) == 1210
    @test sum_proper_divisors(1210) == 1184

    # Prime numbers lead to 1
    @test sum_proper_divisors(2) == 1
    @test sum_proper_divisors(3) == 1
    @test sum_proper_divisors(5) == 1

    # Edge cases
    @test sum_proper_divisors(1) == 0  # 1 has no proper divisors

    # Highly composite numbers
    @test sum_proper_divisors(120) == 240
    @test sum_proper_divisors(240) == 504
end

@testset "Chain detection tests" begin
    # Test that we can find the 5-element chain starting from 12496
    chain_length, min_element = find_amicable_chain(12496, 20000)
    @test chain_length == 5
    @test min_element == 12496  # 12496 is the smallest in this chain

    # Test that the chain is valid (each number leads to the next)
    @test sum_proper_divisors(12496) == 14288
    @test sum_proper_divisors(14288) == 15472
    @test sum_proper_divisors(15472) == 14536
    @test sum_proper_divisors(14536) == 14264
    @test sum_proper_divisors(14264) == 12496

    # Test amicable pair (220, 284) forms a 2-element chain
    chain_length, min_element = find_amicable_chain(220, 1000)
    @test chain_length == 2
    @test min_element == 220
end

# Test the final answer
@test solve() == 14316
