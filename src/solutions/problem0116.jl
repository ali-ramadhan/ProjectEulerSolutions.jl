"""
Project Euler Problem 116: Red, Green or Blue Tiles

A row of grey squares is to be replaced with red, green, or blue oblong tiles. There are
five unit lengths and the colours being used are:

- Red: 2 units
- Green: 3 units
- Blue: 4 units

At least one colored tile must be used and colors cannot be mixed.

For a row measuring five units in length, it is possible to use:
- Red tiles in 7 ways
- Green tiles in 3 ways
- Blue tiles in 2 ways

In exactly how many different ways can the grey tiles in a row measuring fifty units in
length be replaced if colours cannot be mixed and at least one coloured tile must be used?

## Solution approach

This is a dynamic programming problem similar to Problem 114, but simpler since:
1. We don't need separators between tiles of the same color
2. Colors cannot be mixed, so we solve for each color independently
3. We sum the results for all colors

For each tile size, we use DP where dp[i] represents the number of ways to tile a row of
length i. At each position, we can either:
1. Place a grey tile (1 unit): contributes dp[i-1] ways
2. Place a colored tile of the given size: contributes dp[i-tile_size] ways

Since at least one colored tile must be used, we subtract 1 from each color's count (the
all-grey arrangement) before summing.

## Complexity analysis

Time complexity: O(n) for each tile size, O(n) total
- We compute dp values for positions 0 to n for each of the 3 tile sizes
- Each dp computation takes O(n) time since we only consider 2 transitions per position

Space complexity: O(n)
- We store dp values for positions 0 to n
"""
module Problem0116

"""
    count_tile_arrangements(n, tile_size)

Count the number of ways to arrange grey tiles (1 unit) and colored tiles (tile_size units)
in a row of length n, including the all-grey arrangement.

Uses dynamic programming where dp[i] represents the number of arrangements for a row of
length i.
"""
function count_tile_arrangements(n, tile_size)
    # dp[i] = number of ways to tile row of length i
    dp = zeros(Int, n + 1)
    dp[1] = 1  # Base case: empty row has one arrangement

    for i in 1:n
        # Option 1: Place a grey tile (1 unit)
        dp[i + 1] = dp[i]

        # Option 2: Place a colored tile (tile_size units)
        if i >= tile_size
            dp[i + 1] += dp[i - tile_size + 1]
        end
    end

    return dp[n + 1]
end

function solve()
    n = 50

    # Count arrangements for each color, excluding all-grey arrangement
    red_arrangements = count_tile_arrangements(n, 2) - 1
    green_arrangements = count_tile_arrangements(n, 3) - 1
    blue_arrangements = count_tile_arrangements(n, 4) - 1

    result = red_arrangements + green_arrangements + blue_arrangements

    @info "Red tiles (2 units): $red_arrangements ways"
    @info "Green tiles (3 units): $green_arrangements ways"
    @info "Blue tiles (4 units): $blue_arrangements ways"
    @info "Total arrangements: $result"

    return result
end

end # module
