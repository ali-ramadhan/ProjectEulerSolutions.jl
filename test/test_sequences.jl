using Test

using ProjectEulerSolutions.Utils.Sequences:
    Fibonacci,
    triangle_number,
    pentagonal_number,
    hexagonal_number,
    sum_of_squares,
    square_of_sum

@testset "Fibonacci iterator" begin
    # Basic functionality - collect first few values
    @test collect(Fibonacci(2)) == [0, 1, 1, 2]
    @test collect(Fibonacci(3)) == [0, 1, 1, 2, 3]
    @test collect(Fibonacci(10)) == [0, 1, 1, 2, 3, 5, 8]

    # Test edge cases
    @test collect(Fibonacci(1)) == [0, 1, 1]
    @test collect(Fibonacci(0)) == [0]
    @test collect(Fibonacci(-1)) == Int[]

    # Test with different integer types
    @test collect(Fibonacci(Int8(10))) == Int8[0, 1, 1, 2, 3, 5, 8]
    @test collect(Fibonacci(UInt16(10))) == UInt16[0, 1, 1, 2, 3, 5, 8]
    @test collect(Fibonacci(BigInt(10))) == BigInt[0, 1, 1, 2, 3, 5, 8]

    # Test type stability
    @test eltype(Fibonacci(10)) == Int
    @test eltype(Fibonacci(Int128(10))) == Int128
    @test eltype(Fibonacci(BigInt(10))) == BigInt

    # Test unlimited iterator (take first 10) using safer approach
    unlimited = Int[]
    for (i, x) in enumerate(Fibonacci())
        i > 10 && break
        push!(unlimited, x)
    end
    @test unlimited == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]

    # Test that iterator terminates correctly
    @test collect(Fibonacci(100)) == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
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
