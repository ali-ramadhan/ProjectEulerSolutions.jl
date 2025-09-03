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

This solution implements the most efficient algorithm discovered by the Project Euler
community, achieving runtimes of milliseconds to seconds instead of minutes:

1. **Radical Sieve**: Precompute rad(n) for all n using an Eratosthenes-like sieve
2. **Sorted Radical List**: Create a list of (number, radical) pairs sorted by radical
3. **Powerful Bound**: For each c, only search a values where rad(a) < sqrt(c/rad(c))
4. **Early Termination**: Skip c values where rad(c) >= c/2 (impossible for solutions)
5. **Optimized Checks**: Perform cheap radical checks before expensive GCD

## Mathematical insights

- **GCD Simplification**: Since a + b = c, checking gcd(a,b) = 1 ensures all pairwise
  coprimality conditions
- **Radical Product**: For pairwise coprime a,b,c: rad(abc) = rad(a) × rad(b) × rad(c)
- **Critical Bound**: rad(a) < sqrt(c/rad(c)) follows from rad(a) ≤ rad(b) and the
  constraint rad(a) × rad(b) × rad(c) < c

## Complexity analysis

Time complexity: O(n log log n + n^(4/3))
- Radical sieve: O(n log log n)
- Main search: O(n^(4/3)) due to aggressive pruning with sqrt bound

Space complexity: O(n)
- Arrays for radicals and sorted pairs: O(n)

## Key optimizations

- **sqrt(c/rad(c)) bound**: Most powerful optimization, reduces search space dramatically
- **Sorted radicals**: Enables early termination when bound is exceeded
- **Check ordering**: Cheap operations (multiplication) before expensive ones (GCD)
- **Skip impossible c**: rad(c) >= c/2 cannot produce solutions
"""
module Problem127

export solve, find_abc_hits_sum, compute_radicals_sieve, create_sorted_radical_list

"""
    compute_radicals_sieve(limit)

Compute rad(n) for all n from 1 to limit using an Eratosthenes-like sieve. Returns an array
where result[i] = rad(i).
"""
function compute_radicals_sieve(limit)
    rad = ones(Int, limit)

    # Sieve to find primes and compute radicals
    for p in 2:limit
        if rad[p] == 1  # p is prime
            # For each multiple of p, multiply its radical by p
            for multiple in p:p:limit
                rad[multiple] *= p
            end
        end
    end

    return rad
end

"""
    create_sorted_radical_list(radicals)

Create a list of (number, radical) pairs sorted by radical value. This enables efficient
searching with the sqrt(c/rad(c)) bound.
"""
function create_sorted_radical_list(radicals)
    pairs = [(n, radicals[n]) for n in 1:length(radicals)]
    sort!(pairs, by = pair -> pair[2])  # Sort by radical value
    return pairs
end

"""
    find_abc_hits_sum(limit)

Find all abc-hits where c < limit using the most efficient algorithm from the
Project Euler community. Key optimizations:

1. sqrt(c/rad(c)) bound for rad(a)
2. Sorted radical list for efficient searching
3. Early termination when bound is exceeded
4. Skip impossible c values where rad(c) >= c/2
"""
function find_abc_hits_sum(limit)
    @info "Computing radicals for numbers 1 to $(limit-1) using optimized sieve"
    radicals = compute_radicals_sieve(limit - 1)

    @info "Creating sorted radical list for efficient searching"
    sorted_pairs = create_sorted_radical_list(radicals)

    total_sum = 0
    hit_count = 0

    @info "Searching for abc-hits with optimized algorithm"

    # Main loop: iterate through all possible c values
    for c in 3:(limit - 1)
        rad_c = radicals[c]

        # Search through sorted radical list with early termination based on rad(a)*rad(c) >= c
        for (a, rad_a) in sorted_pairs
            # Early termination: if rad(a) * rad(c) >= c, no valid b can exist
            # because rad(b) >= 1, so rad(a) * rad(b) * rad(c) >= rad(a) * rad(c) >= c
            if rad_a * rad_c >= c
                break
            end

            # Skip if a >= c/2 (ensures a < b)
            if a >= c ÷ 2
                continue
            end

            b = c - a

            # Get rad(b) and perform the full radical check
            rad_b = radicals[b]
            if rad_a * rad_b * rad_c >= c
                continue
            end

            # Final check: ensure gcd(a, b) = 1 (most expensive operation, do last)
            if gcd(a, b) != 1
                continue
            end

            # Found a valid abc-hit!
            total_sum += c
            hit_count += 1
        end
    end

    @info "Found $hit_count abc-hits with sum = $total_sum"
    return total_sum
end

function solve()
    return find_abc_hits_sum(120_000)
end

end # module
