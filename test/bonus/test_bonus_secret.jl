using Test
using ProjectEulerSolutions.BonusSecret: simulate_cellular_automaton, solve

# Test simulate_cellular_automaton with a small example
# A 3x3 grid with toroidal boundary conditions
@testset "simulate_cellular_automaton" begin
    # Simple test: after 1 step, each cell becomes the sum of its 4 neighbors
    # Grid:  1 2 3
    #        4 5 6
    #        7 8 9
    # For cell (2,2) with value 5: neighbors are 2, 4, 6, 8 -> sum = 20 % 7 = 6
    grid = [1 2 3; 4 5 6; 7 8 9]

    result = simulate_cellular_automaton(grid, 1, 7)

    # Check center cell: neighbors are 2+4+6+8 = 20, 20 % 7 = 6
    @test result[2, 2] == 6

    # Check corner (1,1): neighbors are 3 (left wraps), 7 (up wraps), 2 (right), 4 (down)
    # Sum = 3 + 7 + 2 + 4 = 16, 16 % 7 = 2
    @test result[1, 1] == 2

    # Test that multiple steps work
    result_10 = simulate_cellular_automaton(grid, 10, 7)
    @test all(0 .<= result_10 .< 7)  # All values should be in Z_7

    # Test with more steps - verify the base-7 decomposition works
    result_49 = simulate_cellular_automaton(grid, 49, 7)  # 49 = 7^2
    @test all(0 .<= result_49 .< 7)
end

# Test that solve() runs without error
# Note: solve() returns nothing but produces an output file
@testset "solve produces output" begin
    output_path = joinpath(@__DIR__, "..", "..", "data", "bonus_secret_result.png")

    # Remove existing output if present
    isfile(output_path) && rm(output_path)

    # Run the solution
    result = solve()

    # Check it returns nothing
    @test result === nothing

    # Check output file was created
    @test isfile(output_path)
end
