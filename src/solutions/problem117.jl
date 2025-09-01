"""
Project Euler Problem 117: Red, Green, and Blue Tiles

Using grey square tiles (1×1) and oblong tiles (red: 2×1, green: 3×1, blue: 4×1), it is
possible to tile a row measuring five units in length in exactly fifteen different ways.

In how many different ways can a row measuring fifty units in length be tiled?

## Solution approach

This is a dynamic programming problem where we can use any combination of tile types. Unlike
Problem 116, colors CAN be mixed, so we solve this as a single DP problem.

At each position i, we can place:
1. A grey tile (1 unit): contributes dp[i-1] ways
2. A red tile (2 units): contributes dp[i-2] ways
3. A green tile (3 units): contributes dp[i-3] ways
4. A blue tile (4 units): contributes dp[i-4] ways

The recurrence relation is: dp[i] = dp[i-1] + dp[i-2] + dp[i-3] + dp[i-4]

This counts all arrangements including the all-grey arrangement.

## Complexity analysis

Time complexity: O(n)
- We compute dp values for positions 0 to n
- Each position considers at most 4 previous positions (constant time)

Space complexity: O(n)
- We store dp values for positions 0 to n
"""
module Problem117

"""
    count_mixed_tile_arrangements(n)

Count the number of ways to arrange grey tiles (1 unit) and colored tiles (red: 2 units,
green: 3 units, blue: 4 units) in a row of length n.

Colors can be mixed, so this solves the problem as a single DP recurrence.
"""
function count_mixed_tile_arrangements(n)
    # dp[i] = number of ways to tile row of length i
    dp = zeros(Int, n + 1)
    dp[1] = 1  # Base case: empty row has one arrangement

    for i in 1:n
        # Option 1: Place a grey tile (1 unit)
        dp[i + 1] = dp[i]

        # Option 2: Place a red tile (2 units)
        if i >= 2
            dp[i + 1] += dp[i - 2 + 1]
        end

        # Option 3: Place a green tile (3 units)
        if i >= 3
            dp[i + 1] += dp[i - 3 + 1]
        end

        # Option 4: Place a blue tile (4 units)
        if i >= 4
            dp[i + 1] += dp[i - 4 + 1]
        end
    end

    return dp[n + 1]
end

function solve()
    n = 50
    result = count_mixed_tile_arrangements(n)
    @info "Solution (50-unit row): $result ways"
    return result
end

end # module
