# HackerRank ProjectEuler+ Problem 11: Largest Product in a Grid
# https://www.hackerrank.com/contests/projecteuler/challenges/euler011/problem
#
# Project Euler: https://projecteuler.net/problem=11
# Solution: https://aliramadhan.me/blog/project-euler/problem-0011/

# Direction vectors: (row_delta, col_delta)
const DIRECTIONS = [
    (0, 1),   # horizontal (right)
    (1, 0),   # vertical (down)
    (1, 1),   # diagonal down-right
    (1, -1),  # diagonal down-left
]

function find_greatest_product(grid, len = 4)
    rows, cols = size(grid)
    max_product = 0

    for (dr, dc) in DIRECTIONS
        for r in 1:rows, c in 1:cols
            end_r, end_c = r + (len - 1) * dr, c + (len - 1) * dc
            if 1 <= end_r <= rows && 1 <= end_c <= cols
                product = prod(grid[r + i * dr, c + i * dc] for i in 0:(len - 1))
                max_product = max(max_product, product)
            end
        end
    end

    return max_product
end

# Read the 20x20 grid
grid = Matrix{Int}(undef, 20, 20)
for i in 1:20
    grid[i, :] = parse.(Int, split(readline()))
end

println(find_greatest_product(grid))
