using Test

using ProjectEulerSolutions.Utils.Sequences:
    fibonacci_sequence,
    triangle_number,
    pentagonal_number,
    hexagonal_number,
    sum_of_squares,
    square_of_sum

@testset "Sequences" begin
    @testset "fibonacci_sequence" begin
        @test fibonacci_sequence(10) == [1, 1, 2, 3, 5, 8]
        @test fibonacci_sequence(100) == [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
        @test fibonacci_sequence(1) == [1, 1]  # starts with a=1, b=1, so both are included
        @test fibonacci_sequence(0) == Int[]
        @test fibonacci_sequence(2) == [1, 1, 2]
    end

    @testset "triangle_number" begin
        @test triangle_number(1) == 1
        @test triangle_number(2) == 3
        @test triangle_number(3) == 6
        @test triangle_number(4) == 10
        @test triangle_number(5) == 15
        @test triangle_number(6) == 21
        @test triangle_number(7) == 28
        @test triangle_number(8) == 36
        @test triangle_number(9) == 45
        @test triangle_number(10) == 55
    end

    @testset "pentagonal_number" begin
        @test pentagonal_number(1) == 1
        @test pentagonal_number(2) == 5
        @test pentagonal_number(3) == 12
        @test pentagonal_number(4) == 22
        @test pentagonal_number(5) == 35
        @test pentagonal_number(6) == 51
    end

    @testset "hexagonal_number" begin
        @test hexagonal_number(1) == 1
        @test hexagonal_number(2) == 6
        @test hexagonal_number(3) == 15
        @test hexagonal_number(4) == 28
        @test hexagonal_number(5) == 45
        @test hexagonal_number(6) == 66
    end

    @testset "sum_of_squares" begin
        @test sum_of_squares(1) == 1
        @test sum_of_squares(3) == 14  # 1² + 2² + 3² = 1 + 4 + 9 = 14
        @test sum_of_squares(10) == 385  # as mentioned in Problem 6
        @test sum_of_squares(100) == 338350  # for Problem 6 solution
    end

    @testset "square_of_sum" begin
        @test square_of_sum(1) == 1
        @test square_of_sum(3) == 36  # (1 + 2 + 3)² = 6² = 36
        @test square_of_sum(10) == 3025  # as mentioned in Problem 6
        @test square_of_sum(100) == 25502500  # for Problem 6 solution
    end
end
