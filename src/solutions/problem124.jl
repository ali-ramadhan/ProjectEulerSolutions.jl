"""
Project Euler Problem 124: Ordered radicals

The radical of n, rad(n), is the product of the distinct prime factors of n. For example,
504 = 2³ × 3² × 7, so rad(504) = 2 × 3 × 7 = 42.

If we calculate rad(n) for 1 ≤ n ≤ 10, then sort them on rad(n), and sorting on n if the
radical values are equal, we get:

Unsorted           Sorted
n    rad(n)      n    rad(n)    k
1      1         1      1       1
2      2         2      2       2
3      3         4      2       3
4      2         8      2       4
5      5         3      3       5
6      6         9      3       6
7      7         5      5       7
8      2         6      6       8
9      3         7      7       9
10    10        10     10      10

Let E(k) be the k-th element in the sorted n column; for example, E(4) = 8 and E(6) = 9.

If rad(n) is sorted for 1 ≤ n ≤ 100000, find E(10000).

## Solution approach

The key insight is to compute all radicals efficiently using a sieve-like approach:

1. Initialize rad[i] = 1 for all i
2. For each prime p (found using a sieve), multiply rad[i] by p for all multiples of p
3. This ensures each distinct prime factor is counted exactly once in the radical
4. Sort the (n, rad(n)) pairs by radical value, then by n
5. Return the 10000th element

This approach is much more efficient than computing prime factorizations individually for
each number.

## Complexity analysis

Time complexity: O(n log log n + n log n)
- Computing radicals using sieve: O(n log log n)
- Sorting n pairs: O(n log n)

Space complexity: O(n)
- Arrays for radicals and sorted pairs: O(n)
- The sieve approach is memory efficient as it only stores radicals, not full factorizations

## Key insights

- The sieve approach for computing radicals is analogous to the Sieve of Eratosthenes
- Each prime p contributes exactly once to rad(n) for each multiple n of p
- Sorting by (rad(n), n) gives the required ordering with ties broken by n value
"""
module Problem124

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

function find_kth_ordered_radical(limit, target_k)
    @info "Computing radicals for numbers 1 to $limit using sieve approach"
    radicals = compute_radicals_sieve(limit)

    # Create pairs (n, rad(n)) and sort by rad(n), then by n
    @info "Creating and sorting (n, rad(n)) pairs"
    pairs = [(n, radicals[n]) for n in 1:limit]

    # Sort by radical value first, then by n value
    sort!(pairs, by = pair -> (pair[2], pair[1]))

    # Return the n value of the target_k-th element
    result = pairs[target_k][1]

    @info "Found E($target_k) = $result with rad($result) = $(radicals[result])"

    return result
end

function solve()
    return find_kth_ordered_radical(100_000, 10_000)
end

end # module
