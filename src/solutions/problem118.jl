"""
Project Euler Problem 118: Pandigital Prime Sets

Using all of the digits 1 through 9 and concatenating them freely to form decimal integers,
different sets can be formed. Interestingly with the set {2,5,47,89,631}, all of the
elements belonging to it are prime.

How many distinct sets containing each of the digits one through nine exactly once contain
only prime elements?

## Solution approach

The most efficient approach is to partition the set of digits {1,2,3,4,5,6,7,8,9} directly
rather than generating all permutations. For each partition of the digit set, we calculate
how many prime numbers can be formed from each subset by considering all permutations of
that subset. The total count for a partition is the product of counts from all its subsets.

Key optimizations:
1. Use set partitioning instead of permutation generation
2. Memoize prime counts for digit subsets to avoid recalculation
3. Apply divisibility-by-3 pruning: subsets with digit sum divisible by 3 (except 3) cannot
   form primes since the resulting numbers are divisible by 3
4. Early termination when any subset in a partition cannot form primes

## Complexity analysis

Time complexity: O(B(9) × k × p!) where:
- B(9) = 21,147 is the 9th Bell number (number of set partitions)
- k is average subset size (~3-4)
- p! is permutations of subset (typically small due to pruning)

Space complexity: O(2^9) for memoization cache

## Mathematical background

Bell numbers count the ways to partition a set. The key insight is that digits 1-9 sum to
45, which is divisible by 3, so no 9-digit pandigital number can be prime. Similarly, any
subset whose digits sum to a multiple of 3 cannot form a prime (except the trivial case
where the sum is 3 itself).

## Key insights

- Set partitioning is more efficient than permutation-based approaches
- Divisibility rules provide powerful pruning opportunities
- Memoization eliminates redundant prime counting for identical digit sets
- The problem has elegant mathematical structure via combinatorics
"""
module Problem118

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    digits_to_number(digits)

Convert an array of digits to the corresponding integer.
"""
function digits_to_number(digits)
    number = 0
    for digit in digits
        number = number * 10 + digit
    end
    return number
end

"""
    unique_permutations(arr)

Generate all unique permutations of an array (handles duplicate elements).
"""
function unique_permutations(arr)
    if length(arr) <= 1
        return [copy(arr)]
    end

    perms = Set{Vector{Int}}()

    function permute!(current, remaining)
        if isempty(remaining)
            push!(perms, copy(current))
            return
        end

        for (i, elem) in enumerate(remaining)
            push!(current, elem)
            new_remaining = vcat(remaining[1:i-1], remaining[i+1:end])
            permute!(current, new_remaining)
            pop!(current)
        end
    end

    permute!(Int[], arr)
    return collect(perms)
end

"""
    count_prime_permutations(digits, cache)

Count how many prime numbers can be formed by permuting the given digits. Uses memoization
to avoid recalculation.
"""
function count_prime_permutations(digits, cache)
    # Sort digits for consistent cache key
    sorted_digits = sort(digits)

    # Check cache first
    if haskey(cache, sorted_digits)
        return cache[sorted_digits]
    end

    # Apply divisibility-by-3 pruning
    digit_sum = sum(sorted_digits)
    if digit_sum > 3 && digit_sum % 3 == 0
        cache[sorted_digits] = 0
        return 0
    end

    count = 0

    # Generate all unique permutations and check for primality
    for perm in unique_permutations(sorted_digits)
        number = digits_to_number(perm)

        if is_prime(number)
            count += 1
        end
    end

    # Cache and return result
    cache[sorted_digits] = count
    return count
end

"""
    generate_set_partitions(elements)

Generate all set partitions of the given elements.
"""
function generate_set_partitions(elements)
    if isempty(elements)
        return [[]]
    end

    partitions = Vector{Vector{Vector{Int}}}()
    first = elements[1]
    rest = elements[2:end]

    for smaller_partition in generate_set_partitions(rest)
        # Add first element to each existing subset
        for i in 1:length(smaller_partition)
            new_partition = deepcopy(smaller_partition)
            push!(new_partition[i], first)
            push!(partitions, new_partition)
        end

        # Create new subset with just the first element
        new_partition = deepcopy(smaller_partition)
        push!(new_partition, [first])
        push!(partitions, new_partition)
    end

    return partitions
end

function solve()
    # Create local memoization cache
    prime_count_cache = Dict{Vector{Int}, Int}()

    total_count = 0
    digits = collect(1:9)

    # Generate all set partitions of digits 1-9
    partitions = generate_set_partitions(digits)

    @info "Generated $(length(partitions)) set partitions to check"

    for partition in partitions
        # Calculate the product of prime counts for each subset in the partition
        partition_count = 1
        valid_partition = true

        for subset in partition
            subset_prime_count = count_prime_permutations(subset, prime_count_cache)

            # If any subset cannot form primes, skip entire partition
            if subset_prime_count == 0
                valid_partition = false
                break
            end

            partition_count *= subset_prime_count
        end

        if valid_partition
            total_count += partition_count
        end
    end

    @info "Cache size after computation: $(length(prime_count_cache)) unique digit subsets"
    @info "Total pandigital prime sets found: $total_count"

    return total_count
end

end # module
