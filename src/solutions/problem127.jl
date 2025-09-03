"""
Project Euler Problem 127: abc-hits

The radical of n, rad(n), is the product of distinct prime factors of n. For example, 504 =
2³ × 3² × 7, so rad(504) = 2 × 3 × 7 = 42.

We shall define the triplet of positive integers (a, b, c) to be an abc-hit if:

1. gcd(a, b) = gcd(a, c) = gcd(b, c) = 1
2. a < b
3. a + b = c
4. rad(abc) < c

For example, (5, 27, 32) is an abc-hit, because:

1. gcd(5, 27) = gcd(5, 32) = gcd(27, 32) = 1
2. 5 < 27
3. 5 + 27 = 32
4. rad(4320) = 30 < 32

It turns out that abc-hits are quite rare and there are only thirty-one abc-hits for c <
1000, with ∑c = 12523.

Find ∑c for c < 120000.

## Solution approach

The key insight is that abc-hits are extremely rare, so we need an efficient search
algorithm:

1. Precompute rad(n) for all n up to the limit using a sieve approach
2. For each possible c value, iterate through a values from 1 to c/2
3. For each (a, c) pair, compute b = c - a
4. Check if gcd(a, b) = 1 (this implies all pairwise gcd conditions are met)
5. Check if rad(a) × rad(b) × rad(c) < c

Key optimizations:
- Since c = a + b and we need gcd(a,c) = 1, we only need to check gcd(a,b) = 1
- We can sort numbers by their radical values and use early termination
- Most triplets fail the rad(abc) < c condition, so check this last

## Complexity analysis

Time complexity: O(n log log n + n²)
- Computing radicals using sieve: O(n log log n)
- Searching all (a,c) pairs: O(n²) but heavily pruned in practice

Space complexity: O(n)
- Array to store radical values: O(n)

## Key insights

- The condition gcd(a,b) = gcd(a,c) = gcd(b,c) = 1 with c = a + b simplifies to just
  gcd(a,b) = 1
- abc-hits are extremely rare, making exhaustive search feasible with good pruning
- The radical condition rad(abc) < c is the main filter that eliminates most candidates
"""
module Problem127

"""
    compute_radicals_sieve(limit)

Compute rad(n) for all n from 1 to limit using a sieve-like approach.
Returns an array where result[i] = rad(i).

This is much more efficient than computing individual prime factorizations,
with time complexity O(n log log n) instead of O(n * sqrt(n)).
"""
function compute_radicals_sieve(limit)
    # Initialize radical values - rad(1) = 1, others start at 1
    rad = ones(Int, limit)

    # Sieve to find all primes and compute radicals
    for p in 2:limit
        # If rad[p] is still 1, then p is prime
        if rad[p] == 1
            # For each multiple of p, multiply its radical by p
            for multiple in p:p:limit
                rad[multiple] *= p
            end
        end
    end

    return rad
end

"""
    find_abc_hits_sum(limit)

Find all abc-hits where c < limit and return the sum of all c values.
"""
function find_abc_hits_sum(limit)
    @info "Computing radicals for numbers 1 to $limit"
    radicals = compute_radicals_sieve(limit - 1)

    abc_hits = Int[]
    total_sum = 0

    @info "Searching for abc-hits with c < $limit"

    # For each possible c value
    for c in 3:(limit - 1)
        rad_c = radicals[c]

        # For each possible a value (a < b implies a < c/2)
        for a in 1:(c ÷ 2)
            b = c - a

            # Check if gcd(a, b) = 1
            if gcd(a, b) != 1
                continue
            end

            # Check the radical condition: rad(abc) < c
            rad_a = radicals[a]
            rad_b = radicals[b]

            if rad_a * rad_b * rad_c < c
                push!(abc_hits, c)
                total_sum += c
                # @info "Found abc-hit: ($a, $b, $c) with rad($a × $b × $c) = $(rad_a * rad_b * rad_c) < $c"
            end
        end
    end

    @info "Found $(length(abc_hits)) abc-hits for c < $limit with sum = $total_sum"
    return total_sum
end

function solve()
    return find_abc_hits_sum(120_000)
end

end # module
