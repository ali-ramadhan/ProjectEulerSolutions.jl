"""
Project Euler Problem 60: Prime Pair Sets

The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and
concatenating them in any order the result will always be prime. For example, taking 7 and
109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest
sum for a set of four primes with this property.

Find the lowest sum for a set of five primes for which any two primes concatenate to produce
another prime.

## Solution approach

This problem is equivalent to finding a minimum-weight 5-clique in a graph, which is a known
NP-hard problem. We model each prime as a node and connect primes that are "compatible"
(both concatenations are prime). Our backtracking clique-finding algorithm is a variant of
the classic Bron-Kerbosch algorithm.

## Complexity analysis

Time complexity: O(p² × log² n + exponential clique search)
- p² pairs to test for compatibility (p = number of primes up to limit)
- Each compatibility test involves primality testing of concatenated numbers
- Exponential search space bounded by aggressive pruning

Space complexity: O(p²)
- Storage for the compatibility graph adjacency lists

## Key insights

1. **Divisibility-by-3 pruning**: Except for prime 3, all primes in a valid set must have
   the same sum-of-digits modulo 3. This drastically reduces the search space.
2. **Integer concatenation**: Using arithmetic operations instead of string conversion for
   number concatenation provides significant performance improvements.
3. **Early termination**: Pruning based on current partial sums and remaining candidates
   eliminates many impossible branches early.
"""
module Problem0060

using ProjectEulerSolutions.Utils.Primes: is_prime, sieve_of_eratosthenes

"""
    concat_numbers(a, b)

Concatenate two numbers a and b as digits using integer arithmetic.
"""
function concat_numbers(a, b)
    return a * 10^ndigits(b) + b
end

"""
    sum_of_digits(n)

Calculate the sum of digits of a number.
"""
function sum_of_digits(n)
    total = 0
    while n > 0
        total += n % 10
        n ÷= 10
    end
    return total
end

"""
    is_pair_compatible(p, q, prime_cache)

Check if primes p and q form a compatible pair where both concatenations are prime. Uses a
cache to avoid repeated primality tests.
"""
function is_pair_compatible(p, q, prime_cache)
    pq = concat_numbers(p, q)
    qp = concat_numbers(q, p)

    pq_prime = get!(prime_cache, pq) do
        return is_prime(pq)
    end

    !pq_prime && return false

    qp_prime = get!(prime_cache, qp) do
        return is_prime(qp)
    end

    return qp_prime
end

"""
    passes_mod3_compatibility(p, q)

Check if two primes pass the divisibility-by-3 compatibility rule. Except for prime 3, all
primes in a valid set must have the same sum-of-digits mod 3.
"""
function passes_mod3_compatibility(p, q)
    # Prime 3 can be paired with any prime
    if p == 3 || q == 3
        return true
    end

    # For other primes, they must have the same sum-of-digits mod 3
    return sum_of_digits(p) % 3 == sum_of_digits(q) % 3
end

"""
    find_prime_pair_set(set_size=5, limit=10000)

Find a set of `set_size` primes with the minimum sum where any two primes, when concatenated
in any order, form prime numbers.

Builds a compatibility graph where each prime is connected to others that meet our criteria
Each node (prime) has edges to other primes where both concatenations are prime. We want to
find a 5-clique, a fully connected subgraph of 5 nodes within this graph.

Uses a graph-based approach with depth-first search with some pruning strategies to
efficiently find the solution

Parameters:

  - set_size: Size of the prime set to find (default: 5)
  - limit: Upper limit for generating primes (default: 10000)

Returns:

  - A tuple (prime_set, sum) where prime_set is the set of primes and sum is their sum
"""
function find_prime_pair_set(set_size = 5, limit = 10000)
    # Generate primes up to the limit (exclude 2 as it can't form compatible sets with odd
    # primes)
    primes = filter(p -> p > 2, sieve_of_eratosthenes(limit))

    prime_cache = Dict{Int, Bool}()

    # Build compatibility graph with mod-3 optimization
    graph = Dict{Int, Vector{Int}}()
    for p in primes
        graph[p] = Int[]
    end

    # Fill the graph by testing all pairs
    for i in 1:length(primes)
        p = primes[i]
        for j in (i + 1):length(primes)
            q = primes[j]
            # Apply mod-3 filter first, then full compatibility check
            if passes_mod3_compatibility(p, q) && is_pair_compatible(p, q, prime_cache)
                push!(graph[p], q)
                push!(graph[q], p)
            end
        end
    end

    # Recursive DFS function to find cliques
    function find_clique(current_set, remaining_size)
        # Base case: found a complete set
        if remaining_size == 0
            return current_set, sum(current_set)
        end

        # If starting fresh, try each prime as starting point
        if isempty(current_set)
            best_set = Int[]
            best_sum = typemax(Int)

            for p in primes
                # Skip if this prime alone would make the sum too large
                if p * remaining_size >= best_sum
                    break
                end

                new_set, new_sum = find_clique([p], remaining_size - 1)
                if !isempty(new_set) && new_sum < best_sum
                    best_set = new_set
                    best_sum = new_sum
                end
            end

            return best_set, best_sum
        end

        # Find candidates compatible with all primes in current set
        candidates = copy(graph[current_set[1]])
        for i in 2:length(current_set)
            filter!(p -> p in graph[current_set[i]], candidates)
        end

        # Only consider candidates larger than the last prime to avoid duplicates
        last_prime = current_set[end]
        filter!(p -> p > last_prime, candidates)

        # Early termination if not enough candidates
        if length(candidates) < remaining_size
            return Int[], typemax(Int)
        end

        # Sort to try smaller candidates first
        sort!(candidates)

        best_set = Int[]
        best_sum = typemax(Int)
        current_sum = sum(current_set)

        for candidate in candidates
            # Pruning: skip if this would exceed the best sum
            if current_sum + candidate + (remaining_size - 1) * candidate >= best_sum
                continue
            end

            new_current = [current_set; candidate]
            result_set, result_sum = find_clique(new_current, remaining_size - 1)

            if !isempty(result_set) && result_sum < best_sum
                best_set = result_set
                best_sum = result_sum
            end
        end

        return best_set, best_sum
    end

    return find_clique(Int[], set_size)
end

function solve()
    prime_set, sum_value = find_prime_pair_set(5)

    @info "Found 5-prime set with minimum sum: $prime_set (sum = $sum_value)"

    return sum_value
end

end # module
