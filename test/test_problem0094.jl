using Test
using ProjectEulerSolutions.Problem0094: solve_pell_equation, solve

@testset "Pell equation approach validation" begin
    # Test known triangle results - these are the expected sums
    # (5,5,6): perimeter 16
    @test solve_pell_equation(16) == 16

    # (5,5,6): perimeter 16, (17,17,16): perimeter 50
    @test solve_pell_equation(50) == 66

    # First three triangles: (5,5,6):16, (17,17,16):50, (65,65,66):196
    @test solve_pell_equation(200) == 262

    # Test edge cases
    @test solve_pell_equation(10) == 0   # No triangles with perimeter <= 10
    @test solve_pell_equation(15) == 0   # Just below first triangle
end

@testset "Mathematical properties validation" begin
    # Test that results increase monotonically with limit
    result_100 = solve_pell_equation(100)
    result_1000 = solve_pell_equation(1000)
    result_10000 = solve_pell_equation(10000)

    @test result_1000 > result_100
    @test result_10000 > result_1000
    @test result_100 > 0
end

# Correct answer
@test solve() == 518408346
