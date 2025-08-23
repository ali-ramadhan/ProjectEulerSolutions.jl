using Test
using ProjectEulerSolutions.Utils.Digits:
    digit_sum, get_digits, count_digits, is_palindrome, is_pandigital,
    digit_rotations, are_permutations, digits_to_number, has_even_digit

@testset "Digits" begin
    @testset "digit_sum" begin
        @test digit_sum(0) == 0
        @test digit_sum(9) == 9
        @test digit_sum(123) == 6
        @test digit_sum(999) == 27
        @test digit_sum(1234567890) == 45
        @test digit_sum(BigInt(10)^100) == 1
    end

    @testset "get_digits" begin
        @test get_digits(0) == [0]
        @test get_digits(9) == [9]
        @test get_digits(123) == [1, 2, 3]
        @test get_digits(1000) == [1, 0, 0, 0]
        @test get_digits(2357) == [2, 3, 5, 7]
    end

    @testset "count_digits" begin
        @test count_digits(0) == 1
        @test count_digits(9) == 1
        @test count_digits(123) == 3
        @test count_digits(1000) == 4
        @test count_digits(2357) == 4
        @test count_digits(123456789) == 9
    end

    @testset "is_palindrome" begin
        @test is_palindrome(0)
        @test is_palindrome(9)
        @test is_palindrome(121)
        @test is_palindrome(1221)
        @test is_palindrome(9009)
        @test is_palindrome(12321)
        @test is_palindrome(7337)

        @test !is_palindrome(12)
        @test !is_palindrome(123)
        @test !is_palindrome(12345)
        @test !is_palindrome(349)
        @test !is_palindrome(1292)
    end

    @testset "is_pandigital" begin
        @test is_pandigital(123, 1:3)
        @test is_pandigital(321, 1:3)
        @test is_pandigital(12345, 1:5)
        @test is_pandigital(987654321, 1:9)

        @test !is_pandigital(111, 1:3)
        @test !is_pandigital(124, 1:3)  # missing 3
        @test !is_pandigital(1234, 1:3)  # too many digits
        @test !is_pandigital(12340, 1:5)  # contains 0
    end

    @testset "digit_rotations" begin
        @test digit_rotations(5) == [5]
        @test digit_rotations(13) == [13, 31]
        @test digit_rotations(123) == [123, 231, 312]
        @test digit_rotations(197) == [197, 971, 719]
    end

    @testset "are_permutations" begin
        @test are_permutations(123, 321)
        @test are_permutations(1487, 4817)
        @test are_permutations(8147, 1487)

        @test !are_permutations(123, 124)
        @test !are_permutations(123, 1234)
    end

    @testset "digits_to_number" begin
        @test digits_to_number([0]) == 0
        @test digits_to_number([9]) == 9
        @test digits_to_number([1, 2, 3]) == 123
        @test digits_to_number([1, 0, 0, 0]) == 1000
    end

    @testset "has_even_digit" begin
        @test has_even_digit(123)  # contains 2
        @test has_even_digit(1024)  # contains 0, 2, 4
        @test has_even_digit(8)

        @test !has_even_digit(135)  # all odd
        @test !has_even_digit(1379)  # all odd
        @test !has_even_digit(7)
    end
end
