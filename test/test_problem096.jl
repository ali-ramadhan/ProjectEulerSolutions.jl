using Test
using ProjectEulerSolutions.Problem096: parse_sudoku_file, is_valid_move, solve_sudoku!, get_top_left_number, solve

@testset "Problem096 Tests" begin
    
    @testset "is_valid_move tests" begin
        grid = [
            5 3 0 0 7 0 0 0 0
            6 0 0 1 9 5 0 0 0
            0 9 8 0 0 0 0 6 0
            8 0 0 0 6 0 0 0 3
            4 0 0 8 0 3 0 0 1
            7 0 0 0 2 0 0 0 6
            0 6 0 0 0 0 2 8 0
            0 0 0 4 1 9 0 0 5
            0 0 0 0 8 0 0 7 9
        ]
        
        @test is_valid_move(grid, 1, 3, 4) == true
        @test is_valid_move(grid, 1, 3, 5) == false
        @test is_valid_move(grid, 1, 3, 1) == true
        @test is_valid_move(grid, 1, 3, 9) == false
    end
    
    @testset "get_top_left_number tests" begin
        grid = [
            4 8 3 9 2 1 6 5 7
            9 6 7 3 4 5 8 2 1
            2 5 1 8 7 6 4 9 3
            5 4 8 1 3 2 9 7 6
            7 2 9 5 6 4 1 3 8
            1 3 6 7 9 8 2 4 5
            3 7 2 6 8 9 5 1 4
            8 1 4 2 5 3 7 6 9
            6 9 5 4 1 7 3 8 2
        ]
        
        @test get_top_left_number(grid) == 483
    end
    
    @testset "solve_sudoku! tests" begin
        grid = [
            0 0 3 0 2 0 6 0 0
            9 0 0 3 0 5 0 0 1
            0 0 1 8 0 6 4 0 0
            0 0 8 1 0 2 9 0 0
            7 0 0 0 0 0 0 0 8
            0 0 6 7 0 8 2 0 0
            0 0 2 6 0 9 5 0 0
            8 0 0 2 0 3 0 0 9
            0 0 5 0 1 0 3 0 0
        ]
        
        original_grid = copy(grid)
        @test solve_sudoku!(grid) == true
        @test grid != original_grid
        @test get_top_left_number(grid) == 483
    end
    
    @test solve() == 24702
end