"""
Project Euler Problem 86: Cuboid Route

A spider sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly sits in
the opposite corner. By traveling on the surfaces of the room the shortest "straight
line" distance from the spider to the fly is 10, which can be found by unfolding the
room.

However, there are up to three "shortest" path candidates for any given cuboid and the
shortest route doesn't always have integer length.

It can be shown that there are exactly 2060 distinct cuboids, ignoring rotations, with
a shortest route of integer length when the longest dimension is no more than 100. This
is the least value of M such that the number of solutions first exceeds two thousand;
the number of solutions when M = 100 is exactly 2060.

Find the least value of M such that the number of solutions first exceeds one million.
"""
module Problem086

"""
    count_integer_routes(max_dimension::Int) -> Int

Count the number of distinct cuboids with dimensions a × b × c where a ≤ b ≤ c ≤ max_dimension
and the shortest path between opposite corners is an integer.

Mathematical insight: For ordered dimensions a ≤ b ≤ c, the shortest path is always √((a+b)² + c²).
This is because unfolding the cuboid optimally places the two smaller dimensions adjacent.

The algorithm:

 1. For each longest dimension a from 1 to max_dimension
 2. For each possible sum bc_sum = b + c from 2 to 2a
 3. Check if a² + bc_sum² is a perfect square
 4. If so, count valid (b,c) pairs using the direct formula

Direct counting formula derivation:

  - We need 1 ≤ c ≤ b ≤ a and b + c = bc_sum
  - c can range from max(1, bc_sum - a) to min(bc_sum ÷ 2, a)
  - The count is: min(bc_sum ÷ 2, a) - max(bc_sum - a, 1) + 1
"""
function count_integer_routes(max_dimension::Int)
    count = 0

    # For a cuboid with dimensions a × b × c, there are three ways to unfold it:
    # 1. √((a+b)² + c²)
    # 2. √((a+c)² + b²)
    # 3. √((b+c)² + a²)
    # For ordered dimensions a ≤ b ≤ c, the minimum is always case 1: √((a+b)² + c²)

    for a in 1:max_dimension
        for bc_sum in 2:(2a)  # bc_sum = b+c must be at least 2 (when b=1, c=1)
            # Check if a² + bc_sum² is a perfect square
            dist_sq = a^2 + bc_sum^2
            dist = isqrt(dist_sq)

            if dist^2 == dist_sq
                # Direct formula for counting valid (b,c) pairs where:
                # - b + c = bc_sum
                # - 1 ≤ c ≤ b ≤ a
                #
                # Derivation:
                # c ranges from max(1, bc_sum - a) to min(bc_sum ÷ 2, a)
                # - Lower bound: c ≥ 1 and b = bc_sum - c ≤ a, so c ≥ bc_sum - a
                # - Upper bound: c ≤ b and b + c = bc_sum, so 2c ≤ bc_sum, thus c ≤ bc_sum ÷ 2
                #   Also c ≤ a since c ≤ b ≤ a

                min_c = max(1, bc_sum - a)
                max_c = min(bc_sum ÷ 2, a)

                if max_c >= min_c
                    valid_pairs = max_c - min_c + 1
                    count += valid_pairs
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
        # Optional progress tracking for very large targets
        if upper >= 1000
            println(
                "Searching for upper bound: M = $upper, solutions = $(count_integer_routes(upper))",
            )
        end
    end

    # Phase 2: Binary search between lower and upper bounds
    lower = upper ÷ 2

    println("Binary search between M = $lower and M = $upper")

    while lower < upper - 1
        mid = (lower + upper) ÷ 2
        mid_count = count_integer_routes(mid)

        println("M = $mid: $mid_count solutions")

        if mid_count <= target
            lower = mid  # Need to search higher
        else
            upper = mid  # Need to search lower
        end
    end

    # At this point: count_integer_routes(lower) ≤ target < count_integer_routes(upper)
    # So upper is our answer
    final_count = count_integer_routes(upper)
    println("Found answer: M = $upper with $final_count solutions")

    return upper
end

function solve()
    return find_first_m_exceeding_target(1_000_000)
end

end # module
