using Test
using ProjectEulerSolutions.Problem092: sum_square_digits, chain_endpoint, solve

@testset "sum_square_digits" begin
    @test sum_square_digits(44) == 32  # 4² + 4² = 16 + 16 = 32
    @test sum_square_digits(32) == 13  # 3² + 2² = 9 + 4 = 13
    @test sum_square_digits(13) == 10  # 1² + 3² = 1 + 9 = 10
    @test sum_square_digits(10) == 1   # 1² + 0² = 1 + 0 = 1
    @test sum_square_digits(85) == 89  # 8² + 5² = 64 + 25 = 89
    @test sum_square_digits(89) == 145 # 8² + 9² = 64 + 81 = 145
end

@testset "chain_endpoint" begin
    @test chain_endpoint(44) == 1   # 44 → 32 → 13 → 10 → 1
    @test chain_endpoint(85) == 89  # 85 → 89 → ... → 89
    @test chain_endpoint(1) == 1    # Already at endpoint
    @test chain_endpoint(89) == 89  # Already at endpoint
end

# This is the expected answer for numbers below 10 million
@test solve() == 8581146
