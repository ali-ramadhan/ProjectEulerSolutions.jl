"""
Project Euler Problem 60: Prime Pair Sets

The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating
them in any order the result will always be prime. For example, taking 7 and 109, both 7109
and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set
of four primes with this property.

Find the lowest sum for a set of five primes for which any two primes concatenate to produce
another prime.
"""
module Problem060

using ProjectEulerSolutions.Utils.Primes: is_prime, sieve_of_eratosthenes

"""
    concat_numbers(a, b)

Concatenate two numbers a and b as digits (e.g., concat_numbers(3, 7) = 37).
"""
function concat_numbers(a, b)
    return parse(Int, string(a) * string(b))
end

"""
    is_pair_compatible(p, q, prime_cache)

Check if primes p and q form a compatible pair where both concatenations are prime.
Uses a cache to avoid repeated primality tests.
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
    find_prime_pair_set(set_size=5, limit=10000)

Find a set of `set_size` primes with the minimum sum where any two primes,
when concatenated in any order, form prime numbers.

Builds a compatibility graph where each prime is connected to others that meet our criteria
Each node (prime) has edges to other primes where both concatenations are prime.
We want to find a 5-clique, a fully connected subgraph of 5 nodes within this graph.

Uses a graph-based approach with depth-first search with some pruning strategies to efficiently find the solution

Parameters:

  - set_size: Size of the prime set to find (default: 5)
  - limit: Upper limit for generating primes (default: 10000)

Returns:

  - A tuple (prime_set, sum) where prime_set is the set of primes and sum is their sum
"""
function find_prime_pair_set(set_size = 5, limit = 10000)
    # Generate primes up to the limit (exclude 2 as it can't form a compatible set with odd primes)
    # Any concatenation with 2 at the end would be even and thus not prime
    primes = filter(p -> p > 2, sieve_of_eratosthenes(limit))

    prime_cache = Dict{Int, Bool}()

    # Build a compatibility graph: for each prime, store the list of compatible primes
    graph = Dict{Int, Vector{Int}}()
    for p in primes
        graph[p] = Int[]
    end

    # Fill the graph by testing all pairs
    for i in 1:length(primes)
        p = primes[i]
        for j in (i + 1):length(primes)
            q = primes[j]
            if is_pair_compatible(p, q, prime_cache)
                push!(graph[p], q)
                push!(graph[q], p)
            end
        end
    end

    # Recursive DFS function to find prime sets
    function find_set(current_set, remaining_size)
        # Base case: we found a set of the required size
        if remaining_size == 0
            return current_set, sum(current_set)
        end

        # If this is the first element, try each prime as a starting point
        if isempty(current_set)
            best_set = Int[]
            best_sum = typemax(Int)

            for p in primes
                # Skip primes that are too large
                if p * remaining_size >= best_sum
                    break
                end

                new_set, new_sum = find_set([p], remaining_size - 1)
                if !isempty(new_set) && new_sum < best_sum
                    best_set = new_set
                    best_sum = new_sum
                end
            end

            return best_set, best_sum
        end

        # Find candidates that are compatible with all primes in the current set
        candidates = copy(graph[current_set[1]])
        for i in 2:length(current_set)
            filter!(p -> p in graph[current_set[i]], candidates)
        end

        # Keep only candidates greater than the last prime to avoid duplicates
        last_prime = current_set[end]
        filter!(p -> p > last_prime, candidates)

        # If there aren't enough candidates, return empty
        if length(candidates) < remaining_size
            return Int[], typemax(Int)
        end

        # Sort candidates to try smaller ones first
        sort!(candidates)

        # Try adding each candidate to the set
        best_set = Int[]
        best_sum = typemax(Int)
        current_sum = sum(current_set)

        for candidate in candidates
            # Early pruning: if adding this candidate would exceed best sum, skip
            if current_sum + candidate + (remaining_size - 1) * candidate >= best_sum
                continue
            end

            new_current = [current_set; candidate]
            new_set, new_sum = find_set(new_current, remaining_size - 1)

            if !isempty(new_set) && new_sum < best_sum
                best_set = new_set
                best_sum = new_sum
            end
        end

        return best_set, best_sum
    end

    return find_set(Int[], set_size)
end

function solve()
    prime_set, sum_value = find_prime_pair_set(5)
    return sum_value
end

end # module
