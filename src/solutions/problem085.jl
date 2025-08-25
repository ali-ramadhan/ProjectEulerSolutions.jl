"""
Project Euler Problem 85: Counting rectangles

By counting carefully it can be seen that a rectangular grid measuring 3 by 2 contains
eighteen rectangles.

Although there exists no rectangular grid that contains exactly two million rectangles,
find the area of the grid with the nearest solution.
"""
module Problem085

"""
    count_rectangles(m, n)

Count the total number of rectangles in an m×n grid.

To count rectangles in an m×n grid, we need to count all possible ways
to choose 2 horizontal lines from (m+1) available horizontal lines
and 2 vertical lines from (n+1) available vertical lines.

For an m×n grid:

  - There are (m+1) horizontal lines (top, bottom, and m-1 internal)
  - There are (n+1) vertical lines (left, right, and n-1 internal)

The formula uses combinations: C(m+1,2) * C(n+1,2) where C(n,k) = binomial(n,k)
"""
function count_rectangles(m, n)
    return binomial(m + 1, 2) * binomial(n + 1, 2)
end

function find_closest_grid_area(target)
    best_area = 0
    best_diff = typemax(Int)

    # We don't need to check very large values since the number of rectangles grows quadratically
    # For efficiency, we can limit our search based on the target
    max_dim = Int(ceil(sqrt(2 * target)))

    for m in 1:max_dim
        for n in 1:max_dim
            rectangles = count_rectangles(m, n)
            diff = abs(rectangles - target)

            if diff < best_diff
                best_diff = diff
                best_area = m * n
            end

            # If we're getting too many rectangles with this m, we can break
            if rectangles > target + best_diff
                break
            end
        end
    end

    return best_area
end

function solve()
    return find_closest_grid_area(2_000_000)
end

end # module
