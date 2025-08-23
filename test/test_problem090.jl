using Test
using ProjectEulerSolutions.Problem090: normalize_cube, can_form_number, can_form_all_numbers, count_valid_cube_arrangements, solve

@testset "normalize_cube" begin
    # Test that 6 and 9 are both included when either is present
    @test normalize_cube([0, 1, 2, 3, 4, 6]) == Set([0, 1, 2, 3, 4, 6, 9])
    @test normalize_cube([0, 1, 2, 3, 4, 9]) == Set([0, 1, 2, 3, 4, 6, 9])
    @test normalize_cube([0, 1, 2, 3, 6, 9]) == Set([0, 1, 2, 3, 6, 9])

    # Test that other digits remain unchanged
    @test normalize_cube([0, 1, 2, 3, 4, 5]) == Set([0, 1, 2, 3, 4, 5])
end

@testset "can_form_number" begin
    cube1 = [0, 5, 6, 7, 8, 9]
    cube2 = [1, 2, 3, 4, 8, 9]

    # Test that we can form some square numbers
    @test can_form_number(cube1, cube2, 0, 1) == true  # 01
    @test can_form_number(cube1, cube2, 6, 4) == true  # 64
    @test can_form_number(cube1, cube2, 8, 1) == true  # 81

    # Test 6/9 equivalence
    @test can_form_number(cube1, cube2, 0, 9) == true  # 09 (using 6 as 9)
    @test can_form_number(cube1, cube2, 1, 6) == true  # 16 (using 9 as 6)
end

@testset "can_form_all_numbers" begin
    # Example from problem description
    cube1 = [0, 5, 6, 7, 8, 9]
    cube2 = [1, 2, 3, 4, 8, 9]
    squares = [(0,1), (0,4), (0,9), (1,6), (2,5), (3,6), (4,9), (6,4), (8,1)]
    @test can_form_all_numbers(cube1, cube2, squares) == true

    # Test a combination that shouldn't work
    bad_cube1 = [0, 1, 2, 3, 4, 5]
    bad_cube2 = [0, 1, 2, 3, 4, 5]
    @test can_form_all_numbers(bad_cube1, bad_cube2, squares) == false
end

@testset "count_valid_cube_arrangements" begin
    # Test with a smaller set of numbers
    small_numbers = [(0,1), (0,4)]
    result = count_valid_cube_arrangements(small_numbers)
    @test result > 0  # Should find some valid arrangements
end

# Correct answer
@test solve() == 1217
