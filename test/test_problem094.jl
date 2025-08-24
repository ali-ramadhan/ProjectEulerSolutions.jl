using Test
using ProjectEulerSolutions.Problem094: has_integer_area, find_almost_equilateral_triangles, solve

@testset "Integer area detection" begin
    # Test the example case: 5-5-6 triangle should have integer area (12)
    @test has_integer_area(5, 6) == true

    # Test some cases that shouldn't have integer area
    @test has_integer_area(3, 4) == false
    @test has_integer_area(4, 5) == false

    # Test edge cases
    @test has_integer_area(1, 1) == false  # degenerate triangle
    @test has_integer_area(2, 1) == false  # invalid triangle (2+1 = 3, not > 2)
end

@testset "Small limit cases" begin
    # Test with a small limit to verify basic functionality
    # The 5-5-6 triangle has perimeter 16, so limit=20 should include it
    @test find_almost_equilateral_triangles(20) >= 16

    # Test with limit that excludes the first triangle
    @test find_almost_equilateral_triangles(10) == 0  # No triangles with perimeter <= 10
end

# Correct answer
@test solve() == 518408346
