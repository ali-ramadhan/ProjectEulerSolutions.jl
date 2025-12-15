using Test

using ProjectEulerSolutions.Utils.Divisors: divisors, sum_divisors, num_divisors, is_abundant, is_perfect, is_amicable

@testset "Divisors" begin
    @testset "divisors" begin
        @test divisors(1) == [1]
        @test divisors(2) == [1, 2]
        @test divisors(3) == [1, 3]
        @test divisors(6) == [1, 2, 3, 6]
        @test divisors(12) == [1, 2, 3, 4, 6, 12]
        @test divisors(28) == [1, 2, 4, 7, 14, 28]
        @test divisors(220) == [1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110, 220]
    end

    @testset "sum_divisors" begin
        @test sum_divisors(1) == 1
        @test sum_divisors(2) == 3      # 1 + 2
        @test sum_divisors(6) == 12     # 1 + 2 + 3 + 6
        @test sum_divisors(12) == 28    # 1 + 2 + 3 + 4 + 6 + 12
        @test sum_divisors(28) == 56    # 1 + 2 + 4 + 7 + 14 + 28
        @test sum_divisors(220) == 504  # sum of all divisors of 220

        for n in [100, 360, 1000, 2520, 5040, 10000, 12345, 99999]
            @test sum_divisors(n) == sum(divisors(n))
        end
    end

    @testset "num_divisors" begin
        @test num_divisors(1) == 1
        @test num_divisors(2) == 2
        @test num_divisors(6) == 4      # 1, 2, 3, 6
        @test num_divisors(12) == 6     # 1, 2, 3, 4, 6, 12
        @test num_divisors(28) == 6     # 1, 2, 4, 7, 14, 28
        @test num_divisors(36) == 9     # perfect square: 1, 2, 3, 4, 6, 9, 12, 18, 36
        @test num_divisors(220) == 12

        for n in [100, 360, 1000, 2520, 5040, 10000, 12345, 99999]
            @test num_divisors(n) == length(divisors(n))
        end
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

    @testset "is_amicable" begin
        @test is_amicable(220)   # 220 and 284 are amicable
        @test is_amicable(284)
        @test is_amicable(1184)  # 1184 and 1210 are amicable
        @test is_amicable(1210)

        @test !is_amicable(1)
        @test !is_amicable(6)    # perfect number, not amicable
        @test !is_amicable(12)   # abundant, not amicable
        @test !is_amicable(28)   # perfect number, not amicable
    end
end
