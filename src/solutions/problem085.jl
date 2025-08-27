"""
Project Euler Problem 85: Counting rectangles

By counting carefully it can be seen that a rectangular grid measuring 3 by 2 contains
eighteen rectangles.

Although there exists no rectangular grid that contains exactly two million rectangles, find
the area of the grid with the nearest solution.

## Solution approach

This problem requires deriving the formula for counting rectangles in an m×n grid, then
finding the grid dimensions that produce a count closest to 2,000,000.

To count rectangles in an m×n grid, we choose 2 horizontal lines from (m+1) available lines
and 2 vertical lines from (n+1) available lines. This gives us: rectangles = C(m+1, 2) ×
C(n+1, 2) = (m(m+1)/2) × (n(n+1)/2)

We search through possible grid dimensions, computing the rectangle count for each and
tracking the one closest to our target.

## Complexity analysis

Time complexity: O(√target)
- We search dimensions up to roughly √(2×target) in each direction
- For target = 2,000,000, this means checking roughly 2000×2000 combinations

Space complexity: O(1)
- Only constant space needed for tracking the best solution found so far

## Mathematical background

The rectangle counting formula comes from combinatorics: to form a rectangle, we need to
select 2 horizontal boundaries (from m+1 choices) and 2 vertical boundaries (from n+1
choices). Each such selection uniquely defines one rectangle in the grid.
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
