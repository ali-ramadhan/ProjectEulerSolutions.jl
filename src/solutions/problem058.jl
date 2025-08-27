"""
Project Euler Problem 58: Spiral Primes

Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side
length 7 is formed.

37 36 35 34 33 32 31
38 17 16 15 14 13 30
39 18  5  4  3 12 29
40 19  6  1  2 11 28
41 20  7  8  9 10 27
42 21 22 23 24 25 26
43 44 45 46 47 48 49

It is interesting to note that the odd squares lie along the bottom right diagonal, but what
is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime;
that is, a ratio of 8/13 ≈ 62%.

If one complete new layer is wrapped around the spiral above, a square spiral with side
length 9 will be formed. If this process is continued, what is the side length of the square
spiral for which the ratio of primes along both diagonals first falls below 10%?

## Solution approach

We build the spiral layer by layer, computing the four corner values for each layer. The
bottom-right corners are always perfect squares (never prime for n > 1), so we only need to
test the other three corners for primality. We track the running count of primes and total
diagonal numbers, checking when the ratio drops below 10%.

## Complexity analysis

Time complexity: O(n √n)
- We check O(n) spiral layers until the ratio drops below 10%
- Each corner primality test takes O(√m) time where m is the corner value

Space complexity: O(1)
- Only constant space for counters and current layer values

## Key insights

The spiral construction follows a predictable pattern: for side length s, the corners are at
positions s², s²-(s-1), s²-2(s-1), s²-3(s-1). Since s² is always composite for s > 1, we
only test the other three positions.
"""
module Problem058

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    find_spiral_side_length()

Find the side length of the square spiral for which the ratio
of primes along both diagonals first falls below 10%.

The spiral is constructed by starting with 1 in the center and spiraling outward
counterclockwise. For each new layer, we add 4 corners to the diagonals.
Bottom-right corners are always perfect squares (n²) which are never prime for n > 1.
"""
function find_spiral_side_length()
    side_length = 1
    diagonal_count = 1  # Start with just the center (1)
    prime_count = 0     # 1 is not prime

    while true
        side_length += 2  # Increase side length by 2 each time (always odd)

        # Calculate the three non-square corners
        square = side_length^2
        bottom_left = square - (side_length - 1)
        top_left = bottom_left - (side_length - 1)
        top_right = top_left - (side_length - 1)

        # Check if corners are prime
        for corner in [bottom_left, top_left, top_right]
            if is_prime(corner)
                prime_count += 1
            end
        end

        diagonal_count += 4  # Add 4 corners for each new layer

        # Calculate the ratio
        ratio = prime_count / diagonal_count

        if ratio < 0.1
            return side_length
        end
    end
end

function solve()
    result = find_spiral_side_length()

    @info "Prime ratio in spiral diagonals falls below 10% at side length $result"

    return result
end

end # module
