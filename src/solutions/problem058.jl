"""
Project Euler Problem 58: Spiral Primes

Starting with 1 and spiralling anticlockwise in the following way, a square spiral with
side length 7 is formed.

37 36 35 34 33 32 31
38 17 16 15 14 13 30
39 18  5  4  3 12 29
40 19  6  1  2 11 28
41 20  7  8  9 10 27
42 21 22 23 24 25 26
43 44 45 46 47 48 49

It is interesting to note that the odd squares lie along the bottom right diagonal, but
what is more interesting is that 8 out of the 13 numbers lying along both diagonals are
prime; that is, a ratio of 8/13 ≈ 62%.

If one complete new layer is wrapped around the spiral above, a square spiral with side
length 9 will be formed. If this process is continued, what is the side length of the
square spiral for which the ratio of primes along both diagonals first falls below 10%?
"""
module Problem058

"""
    is_prime(n)

Check if n is prime using trial division with the 6k±1 optimization.
Only checks divisors up to sqrt(n) and filters common cases.
"""
function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end

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
    return find_spiral_side_length()
end

end # module
