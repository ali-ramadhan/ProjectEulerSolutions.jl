"""
Project Euler Problem 9: Special Pythagorean Triplet

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a² + b² = c².

For example, 3² + 4² = 9 + 16 = 25 = 5².

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.

## Solution approach

Instead of using nested loops to check all combinations, we derive a direct formula
for b given a. From the constraints a² + b² = c² and a + b + c = 1000, we can
substitute c = 1000 - a - b into the Pythagorean theorem to get:
a² + b² = (1000 - a - b)²

Solving for b yields: b = (500000 - 1000a) / (1000 - a)

We iterate through valid values of a and check if b is a positive integer greater
than a, then verify the resulting triplet satisfies all constraints.

## Complexity analysis

Time complexity: O(n)
- We iterate through at most 332 values of a (since a < 1000/3 for a < b < c)
- Each iteration performs constant-time arithmetic and checks

Space complexity: O(1)
- Only uses a constant amount of additional space for variables
"""
module Problem009

"""
    find_pythagorean_triplet()

Find the unique Pythagorean triplet (a, b, c) where a + b + c = 1000.
Returns a tuple (a, b, c).
"""
function find_pythagorean_triplet()
    # Since a < b < c and a + b + c = 1000, a must be less than 1000/3
    for a in 1:332
        # Use a formula to find b directly
        # Derived from a² + b² = c² and a + b + c = 1000
        numerator = 500000 - 1000 * a
        denominator = 1000 - a

        # Check if b is a natural number
        if numerator % denominator == 0
            b = numerator ÷ denominator

            # Check if b is positive and greater than a
            if b > 0 && b > a
                c = 1000 - a - b

                # Verify that a < b < c and it's a Pythagorean triplet
                if a < b < c && a^2 + b^2 == c^2
                    return a, b, c
                end
            end
        end
    end

    return nothing  # No solution found
end

"""
    solve()

Solve Problem 9 by finding the product of the Pythagorean triplet.
"""
function solve()
    a, b, c = find_pythagorean_triplet()
    @info "Found Pythagorean triplet: $(a)² + $(b)² = $(c)² where $a + $b + $c = 1000"
    return a * b * c
end

end # module
