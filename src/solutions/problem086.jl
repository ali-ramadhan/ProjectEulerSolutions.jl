"""
Project Euler Problem 86: Cuboid Route

A spider sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly sits in the
opposite corner. By traveling on the surfaces of the room the shortest "straight line"
distance from the spider to the fly is 10, which can be found by unfolding the room.

However, there are up to three "shortest" path candidates for any given cuboid and the
shortest route doesn't always have integer length.

It can be shown that there are exactly 2060 distinct cuboids, ignoring rotations, with a
shortest route of integer length when the longest dimension is no more than 100. This is the
least value of M such that the number of solutions first exceeds two thousand; the number of
solutions when M = 100 is exactly 2060.

Find the least value of M such that the number of solutions first exceeds one million.

## Solution approach

For a cuboid with ordered dimensions a ≤ b ≤ c, the shortest surface path between opposite
corners has length √((a+b)² + c²). This comes from unfolding the cuboid optimally by placing
the two smaller dimensions adjacent.

We count integer solutions by:
1. For each potential longest dimension c from 1 to M
2. For each sum s = a+b from 2 to 2c
3. Check if c² + s² is a perfect square
4. If so, count valid (a,b) pairs where a ≤ b ≤ c and a+b = s

The direct counting formula avoids nested loops: for sum s and constraint c, the number of
valid pairs is max(0, min(s÷2, c) - max(1, s-c) + 1).

## Complexity analysis

Time complexity: O(M²)
- For each of M values of longest dimension c
- We check up to 2c values of sum s = a+b
- Each check involves constant-time operations

Space complexity: O(1)
- Only constant extra space for counters and temporary variables

## Mathematical background

The problem relies on the Pythagorean theorem applied to unfolded cuboids. When unfolding a
cuboid with dimensions a×b×c, there are three possible unfoldings, but for ordered
dimensions a ≤ b ≤ c, the optimal path is always √((a+b)² + c²).

## Key insights

Using binary search to find the answer M is much more efficient than linear search,
especially for large targets. The exponential search phase quickly finds bounds, then binary
search narrows to the exact answer.
"""
module Problem086

"""
    count_integer_routes(max_dimension::Int) -> Int

Count distinct cuboids with integer shortest routes where the longest dimension ≤
max_dimension. Uses the direct counting formula to avoid nested loops over individual
dimension combinations.
"""
function count_integer_routes(max_dimension::Int)
    count = 0

    for c in 1:max_dimension  # c is the longest dimension
        for ab_sum in 2:(2c)  # ab_sum = a+b where a ≤ b ≤ c
            # Check if c² + ab_sum² is a perfect square
            dist_sq = c^2 + ab_sum^2
            dist = isqrt(dist_sq)

            if dist^2 == dist_sq
                # Count valid (a,b) pairs where a ≤ b ≤ c and a + b = ab_sum
                min_a = max(1, ab_sum - c)
                max_a = min(ab_sum ÷ 2, c)

                if max_a >= min_a
                    count += max_a - min_a + 1
                end
            end
        end
    end

    return count
end

"""
    find_first_m_exceeding_target(target::Int) -> Int

Find the smallest M such that count_integer_routes(M) > target using binary search.

This is much more efficient than linear search, especially for large targets.
The algorithm has two phases:

 1. **Exponential search**: Find upper bound by doubling until we exceed the target.
 2. **Binary search**: Narrow down the exact answer between lower and upper bounds.

Time complexity: O(log M * cost_of_counting) vs O(M * cost_of_counting) for linear search
"""
function find_first_m_exceeding_target(target::Int)
    # Phase 1: Exponential search to find upper bound
    upper = 2
    while count_integer_routes(upper) <= target
        upper *= 2
        if upper >= 1000
            current_count = count_integer_routes(upper)
            @info "Exponential search: M = $upper, solutions = $current_count"
        end
    end

    # Phase 2: Binary search between lower and upper bounds
    lower = upper ÷ 2
    @info "Binary search phase: searching between M = $lower and M = $upper"

    while lower < upper - 1
        mid = (lower + upper) ÷ 2
        mid_count = count_integer_routes(mid)
        @info "Binary search: M = $mid gives $mid_count solutions"

        if mid_count <= target
            lower = mid  # Need to search higher
        else
            upper = mid  # Need to search lower
        end
    end

    # At this point: count_integer_routes(lower) ≤ target < count_integer_routes(upper)
    # So upper is our answer
    final_count = count_integer_routes(upper)
    @info "Found minimum M = $upper where integer cuboid routes first exceed target: " *
          "$final_count solutions"

    return upper
end

function solve()
    return find_first_m_exceeding_target(1_000_000)
end

end # module
