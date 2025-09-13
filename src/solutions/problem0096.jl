"""
Project Euler Problem 96: Su Doku

Su Doku (Japanese meaning number place) is the name given to a popular puzzle concept.
Its origin is unclear, but credit must be attributed to Leonhard Euler who invented a
similar, and much more difficult, puzzle idea called Latin Squares. The objective of
Su Doku puzzles, however, is much simpler.

By filling in the missing numbers in a 9×9 grid, in such a way that every row, column,
and 3×3 box contains the numbers 1 to 9. A well constructed Su Doku puzzle has a unique
solution and can be solved by logic, although it may be necessary to employ "guess and
test" methods in order to eliminate options (there is much contested opinion over this).
The complexity of the search determines the difficulty of the puzzle; the example above
is considered easy because it can be solved by straight forward direct deduction.

The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'), contains fifty
different Su Doku puzzles ranging in difficulty, but all with unique solutions (the
first puzzle solution is shown above).

By solving all fifty puzzles find the sum of the 3-digit numbers found in the top left
corner of each solution grid; for example, the above solution grid starts with the
number 483 in the top left corner.
"""
module Problem0096

function parse_sudoku_file(filename)
    puzzles = []
    lines = readlines(filename)
    i = 1
    while i <= length(lines)
        if startswith(lines[i], "Grid")
            grid = zeros(Int, 9, 9)
            for row in 1:9
                line = lines[i + row]
                for col in 1:9
                    grid[row, col] = parse(Int, line[col])
                end
            end
            push!(puzzles, grid)
            i += 10
        else
            i += 1
        end
    end
    return puzzles
end

function is_valid_move(grid, row, col, num)
    for i in 1:9
        if grid[row, i] == num || grid[i, col] == num
            return false
        end
    end

    start_row = 3 * ((row - 1) ÷ 3) + 1
    start_col = 3 * ((col - 1) ÷ 3) + 1
    for i in start_row:(start_row + 2)
        for j in start_col:(start_col + 2)
            if grid[i, j] == num
                return false
            end
        end
    end

    return true
end

function solve_sudoku!(grid)
    for row in 1:9
        for col in 1:9
            if grid[row, col] == 0
                for num in 1:9
                    if is_valid_move(grid, row, col, num)
                        grid[row, col] = num
                        if solve_sudoku!(grid)
                            return true
                        end
                        grid[row, col] = 0
                    end
                end
                return false
            end
        end
    end
    return true
end

function get_top_left_number(grid)
    return grid[1, 1] * 100 + grid[1, 2] * 10 + grid[1, 3]
end

function solve()
    data_path = joinpath(@__DIR__, "..", "..", "data", "0096_sudoku.txt")
    puzzles = parse_sudoku_file(data_path)

    total = 0
    for puzzle in puzzles
        grid_copy = copy(puzzle)
        if solve_sudoku!(grid_copy)
            total += get_top_left_number(grid_copy)
        else
            error("Failed to solve puzzle")
        end
    end

    return total
end

end # module
