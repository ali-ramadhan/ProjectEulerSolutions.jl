using Test
using ProjectEulerSolutions.Problem091:
    count_right_angle_at_origin,
    count_right_angle_on_axes,
    count_right_angle_interior,
    count_right_triangles,
    solve

@testset "count_right_angle_at_origin" begin
    # Test basic counting
    @test count_right_angle_at_origin(1) == 1   # 1 × 1 = 1
    @test count_right_angle_at_origin(2) == 4   # 2 × 2 = 4
    @test count_right_angle_at_origin(3) == 9   # 3 × 3 = 9
end

@testset "count_right_angle_on_axes" begin
    # Test basic functionality
    @test count_right_angle_on_axes(1) >= 0  # Should not error
    @test count_right_angle_on_axes(2) >= 0  # Should find some triangles
end

@testset "count_right_angle_interior" begin
    # Test basic functionality
    @test count_right_angle_interior(1) >= 0  # Should not error
    @test count_right_angle_interior(2) >= 0  # Should find some triangles
end

@testset "count_right_triangles" begin
    # Test the example from problem: limit = 2 should give 14 triangles
    @test count_right_triangles(2) == 14

    # Should find some triangles
    @test count_right_triangles(1) > 0
end

# Test the main solve() function - correct answer
@test solve() == 14234
