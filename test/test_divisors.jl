using ProjectEulerSolutions.Utils.Divisors: get_divisors, is_abundant, is_perfect

@testset "Divisors Utils" begin
    @testset "get_divisors" begin
        @test get_divisors(1) == [1]
        @test get_divisors(2) == [1, 2]
        @test get_divisors(3) == [1, 3]
        @test get_divisors(6) == [1, 2, 3, 6]
        @test get_divisors(12) == [1, 2, 3, 4, 6, 12]
        @test get_divisors(28) == [1, 2, 4, 7, 14, 28]
        @test get_divisors(220) == [1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110, 220]
    end

    @testset "is_abundant" begin
        @test is_abundant(12)  # 1+2+3+4+6 = 16 > 12
        @test is_abundant(18)  # 1+2+3+6+9 = 21 > 18
        @test is_abundant(20)  # 1+2+4+5+10 = 22 > 20

        @test !is_abundant(1)
        @test !is_abundant(6)  # perfect number: 1+2+3 = 6
        @test !is_abundant(8)  # deficient: 1+2+4 = 7 < 8
        @test !is_abundant(28)  # perfect number
    end

    @testset "is_perfect" begin
        @test is_perfect(6)   # 1+2+3 = 6
        @test is_perfect(28)  # 1+2+4+7+14 = 28
        @test is_perfect(496) # next perfect number

        @test !is_perfect(1)
        @test !is_perfect(12)  # abundant
        @test !is_perfect(8)   # deficient
    end
end
