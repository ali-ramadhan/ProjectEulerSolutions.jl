"""
Project Euler Problem 9: Special Pythagorean Triplet

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a² + b² = c².

For example, 3² + 4² = 9 + 16 = 25 = 5².

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.

## Solution approach

Instead of using nested loops to check all combinations, we derive a direct formula
for b given a. From the constraints a² + b² = c² and a + b + c = n, we can
substitute c = n - a - b into the Pythagorean theorem to get:
a² + b² = (n - a - b)²

Expanding and simplifying:
a² + b² = n² - 2n(a+b) + (a+b)²
0 = n² - 2na - 2nb + 2ab
2b(n - a) = n(n - 2a)

Solving for b yields: b = n(n - 2a) / (2(n - a))

We iterate through valid values of a and check if b is a positive integer greater
than a, then verify the resulting triplet satisfies all constraints. We search the
entire space to find all valid triplets.

## Complexity analysis

Time complexity: O(n)
- We iterate through at most n/3 values of a (since a < n/3 for a < b < c)
- Each iteration performs constant-time arithmetic and checks

Space complexity: O(k)
- Where k is the number of valid triplets found (typically very small)
"""
module Problem0009

"""
    find_pythagorean_triplets(n)

Find all Pythagorean triplets (a, b, c) where a + b + c = n and a < b < c.
Returns a vector of tuples [(a, b, c), ...].
"""
function find_pythagorean_triplets(n)
    triplets = Tuple{Int,Int,Int}[]

    # Since a < b < c and a + b + c = n, a must be less than n/3
    for a in 1:(n÷3)
        # Use formula: b = n(n - 2a) / (2(n - a))
        # Derived from a² + b² = c² and a + b + c = n
        numerator = n * (n - 2a)
        denominator = 2 * (n - a)

        # Check if b is a natural number
        if numerator % denominator == 0
            b = numerator ÷ denominator

            # Check if b is positive and greater than a
            if b > 0 && b > a
                c = n - a - b

                # Verify that a < b < c and it's a Pythagorean triplet
                if a < b < c && a^2 + b^2 == c^2
                    push!(triplets, (a, b, c))
                end
            end
        end
    end

    return triplets
end

"""
    solve()

Solve Problem 9 by finding the product of the Pythagorean triplet.
"""
function solve()
    triplets = find_pythagorean_triplets(1000)
    @info "Found $(length(triplets)) Pythagorean triplet(s) for n=1000: $triplets"
    a, b, c = first(triplets)
    return a * b * c
end

end # module
