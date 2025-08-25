"""
Project Euler Problem 9: Special Pythagorean Triplet

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a² + b² = c².

For example, 3² + 4² = 9 + 16 = 25 = 5².

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
"""
module Problem009

"""
    find_pythagorean_triplet()

Find the unique Pythagorean triplet (a, b, c) where a + b + c = 1000.
Uses the formula b = (500000 - 1000a)/(1000 - a) derived by combining
the Pythagorean theorem with the sum constraint to avoid nested loops.
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
    return a * b * c
end

end # module
