"""
Project Euler Problem 131: Prime cube partnership

There are some prime values, p, for which there exists a positive integer, n, such that the
expression n³ + n²p is a perfect cube.

For example, when p = 19, 8³ + 8²×19 = 12³.

What is perhaps most surprising is that for each prime with this property the value of n is
unique, and there are only four such primes below one-hundred.

How many primes below one million have this remarkable property?

## Solution approach

The key mathematical insight is that for n³ + n²p to be a perfect cube, p must be
expressible as the difference of two consecutive cubes. Specifically, if n³ + n²p = m³, then
through algebraic manipulation we can show that p must be of the form:

p = (k+1)³ - k³ = 3k² + 3k + 1

for some positive integer k, and the unique value of n for this p is n = k³.

These primes are known as "Cuban primes" of the first kind. The algorithm generates all such
primes below the limit by iterating through values of k and checking if 3k² + 3k + 1 is
prime.

## Complexity analysis

Time complexity: O(√limit × √p)
- We iterate through k values up to approximately ∛limit
- For each k, we check if p = 3k² + 3k + 1 is prime, which takes O(√p) time
- Total: O(∛limit × √(limit^(2/3))) = O(limit^(2/3))

Space complexity: O(1)
- Only stores a constant amount of data regardless of input size

## Mathematical background

The problem is equivalent to finding when n²(n + p) is a perfect cube. If we write the
perfect cube as m³ where m > n, then setting m = n + d for positive integer d gives us:

n³ + n²p = (n + d)³ n²p = 3n²d + 3nd² + d³

For this to have integer solutions, we need specific relationships between n, p, and d. The
Cuban prime form emerges from the constraint that n must be unique for each prime p.

## Key insights

The uniqueness property mentioned in the problem statement follows from the mathematical
structure: each Cuban prime p = 3k² + 3k + 1 corresponds to exactly one value n = k³ that
makes n³ + n²p a perfect cube.
"""
module Problem0131

using ProjectEulerSolutions.Utils.Primes: is_prime

function count_remarkable_primes(limit)
    count = 0
    k = 1

    while true
        p = 3k^2 + 3k + 1
        p >= limit && break

        if is_prime(p)
            count += 1
            @info "Found Cuban prime: p = $p (k = $k, n = $(k^3))"
        end

        k += 1
    end

    return count
end

function solve()
    return count_remarkable_primes(1_000_000)
end

end # module
