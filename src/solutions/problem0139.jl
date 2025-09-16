"""
Project Euler Problem 139: Pythagorean tiles

Let (a, b, c) represent the three sides of a right angle triangle with integral length
sides. It is possible to place four such triangles together to form a square with length c.

For example, (3, 4, 5) triangles can be placed together to form a 5 by 5 square with a 1 by
1 hole in the middle and it can be seen that the 5 by 5 square can be tiled with twenty-five
1 by 1 squares.

However, if (5, 12, 13) triangles were used then the hole would measure 7 by 7 and these
could not be used to tile the 13 by 13 square.

Given that the perimeter of the right triangle is less than one-hundred million, how many
Pythagorean triangles would allow such a tiling to take place?

## Solution approach

When four right triangles (a, b, c) are arranged to form a square of side c, they create a
square hole in the middle with side length |a - b|. For the c×c square to be tileable with
1×1 squares, we need c to be divisible by |a - b|.

We use Euclid's formula to generate all primitive Pythagorean triples:
- For coprime integers m > n > 0 where not both are odd
- a = m² - n², b = 2mn, c = m² + n²
- The hole size is |a - b| = |m² - n² - 2mn| = |(m - n)² - 2n²|

For each primitive triple where c is divisible by |a - b|, we count all multiples within the
perimeter limit.

## Complexity analysis

Time complexity: O(√L)
- Iterate over m up to √(L/2) and n < m
- For each valid primitive triple, count multiples in O(1)

Space complexity: O(1)
- Only storing counters and temporary variables

## Key insights

The key insight is recognizing that the hole size equals |a - b| and the tiling condition
requires c % |a - b| = 0. This dramatically reduces the search space compared to checking
all Pythagorean triples.
"""
module Problem0139

"""
    is_valid_pair(m, n)

Check if a pair (m, n) is valid for generating primitive Pythagorean triples.
Valid pairs have gcd(m, n) = 1 and not both m and n are odd.
"""
function is_valid_pair(m, n)
    return gcd(m, n) == 1 && !(m % 2 == 1 && n % 2 == 1)
end

"""
    count_tileable_pythagorean_triangles(limit)

Count Pythagorean triangles with perimeter < limit that allow tiling when
arranged in a square formation.

For a Pythagorean triple (a, b, c), when four such triangles form a square
of side c, the hole has side |a - b|. For tiling to work, c must be
divisible by |a - b|.
"""
function count_tileable_pythagorean_triangles(limit)
    count = 0

    # Upper bound for m: perimeter = 2m² + 2mn = 2m(m + n) < limit
    # So m < √(limit/2)
    max_m = isqrt(limit ÷ 2)

    for m in 2:max_m
        for n in 1:(m - 1)
            if !is_valid_pair(m, n)
                continue
            end

            # Generate primitive triple using Euclid's formula
            a = m^2 - n^2
            b = 2*m*n
            c = m^2 + n^2
            perimeter = a + b + c

            if perimeter >= limit
                break
            end

            # Check if c is divisible by |a - b| (hole size)
            hole_size = abs(a - b)
            if hole_size > 0 && c % hole_size == 0
                # Count all multiples of this primitive triple
                max_k = (limit - 1) ÷ perimeter
                count += max_k

                if max_k > 0
                    @info "Found tileable primitive triple ($a, $b, $c) with hole size $hole_size, counting $max_k multiples"
                end
            end
        end
    end

    return count
end

function solve()
    return count_tileable_pythagorean_triangles(100_000_000)
end

end # module
