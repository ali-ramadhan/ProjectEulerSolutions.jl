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

function count_integer_routes(max_dimension::Int)
    count = 0

    # For a cuboid with dimensions a × b × c, there are three ways to unfold it:
    # 1. √((a+b)² + c²)
    # 2. √((a+c)² + b²)
    # 3. √((b+c)² + a²)
    # We want the minimum to be an integer.

    # For each a from 1 to max_dimension, find all valid (b,c) pairs where the shortest
    # distance is an integer.

    for a in 1:max_dimension
        for bc_sum in 1:(2a)  # b+c can range from 1 to 2a
            # Check if a² + (b+c)² is a perfect square
            dist_sq = a^2 + bc_sum^2
            dist = isqrt(dist_sq)

            if dist^2 == dist_sq
                # Count valid (b,c) pairs where b+c = bc_sum and 1 ≤ c ≤ b ≤ a
                # For bc_sum = b + c, we have:
                # c ranges from 1 to min(bc_sum÷2, a)
                # b = bc_sum - c, and we need b ≤ a

                valid_pairs = 0
                for c in 1:min(bc_sum ÷ 2, a)
                    b = bc_sum - c
                    if b >= c && b <= a
                        valid_pairs += 1
                    end
                end
                count += valid_pairs
            end
        end
    end

    return count
end

function find_first_m_exceeding_target(target::Int)
    m = 1

    while true
        solutions = count_integer_routes(m)

        if solutions > target
            return m
        end

        m += 1

        # Add some progress tracking for larger values
        if m % 100 == 0
            println("M = $m: $solutions solutions")
        end
    end
end

function solve()
    return find_first_m_exceeding_target(1_000_000)
end

end # module
