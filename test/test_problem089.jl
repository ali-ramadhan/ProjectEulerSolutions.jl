using Test
using ProjectEulerSolutions.Problem089: roman_to_int, int_to_minimal_roman, solve

@testset "Roman to Integer Conversion" begin
    @test roman_to_int("I") == 1
    @test roman_to_int("V") == 5
    @test roman_to_int("X") == 10
    @test roman_to_int("L") == 50
    @test roman_to_int("C") == 100
    @test roman_to_int("D") == 500
    @test roman_to_int("M") == 1000

    @test roman_to_int("IV") == 4
    @test roman_to_int("IX") == 9
    @test roman_to_int("XL") == 40
    @test roman_to_int("XC") == 90
    @test roman_to_int("CD") == 400
    @test roman_to_int("CM") == 900

    @test roman_to_int("XVI") == 16
    @test roman_to_int("XIIIIII") == 16
    @test roman_to_int("MCDXLIV") == 1444
    @test roman_to_int("MMMDLXVIIII") == 3569
end

@testset "Integer to Minimal Roman Conversion" begin
    @test int_to_minimal_roman(1) == "I"
    @test int_to_minimal_roman(4) == "IV"
    @test int_to_minimal_roman(5) == "V"
    @test int_to_minimal_roman(9) == "IX"
    @test int_to_minimal_roman(16) == "XVI"
    @test int_to_minimal_roman(40) == "XL"
    @test int_to_minimal_roman(90) == "XC"
    @test int_to_minimal_roman(400) == "CD"
    @test int_to_minimal_roman(900) == "CM"
    @test int_to_minimal_roman(1444) == "MCDXLIV"
    @test int_to_minimal_roman(1994) == "MCMXCIV"
end

@testset "Round-trip conversion" begin
    test_numbers = [16, 27, 44, 99, 444, 999, 1444, 1994, 3569]
    for num in test_numbers
        @test roman_to_int(int_to_minimal_roman(num)) == num
    end
end

@test solve() == 743
