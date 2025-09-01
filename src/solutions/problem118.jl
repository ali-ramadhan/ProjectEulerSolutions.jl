"""
Project Euler Problem 118: Pandigital Prime Sets

Using all of the digits 1 through 9 and concatenating them freely to form decimal
integers, different sets can be formed. Interestingly with the set {2,5,47,89,631},
all of the elements belonging to it are prime.

How many distinct sets containing each of the digits one through nine exactly once
contain only prime elements?

## Solution approach

This problem requires finding all possible ways to partition the digits 1-9 into groups
that form prime numbers. The key insight is to use backtracking to generate all possible
partitions of the 9 digits, then check if each partition forms a valid set of primes.

To avoid counting duplicate sets, we generate partitions systematically and use a
canonical representation (sorted sets) to ensure uniqueness.

The algorithm:
1. Generate all permutations of digits 1-9
2. For each permutation, try all ways to partition it into subsequences
3. Check if all subsequences form prime numbers
4. Count unique valid sets

## Complexity analysis

Time complexity: O(9! × 2^8) worst case
- 9! permutations of digits 1-9
- 2^8 ways to partition each permutation into groups
- Prime checking is O(√n) for each number formed

Space complexity: O(n)
- Recursion stack depth and temporary storage for partitions

## Key insights

- Early pruning: numbers ending in even digits (except 2) or 5 cannot be prime
- Canonical representation: use sorted sets to avoid counting duplicates
- Backtracking allows efficient exploration of the search space
"""
module Problem118

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    generate_all_permutations!(digits, start_idx, prime_sets)

Generate all permutations of the digits and find prime partitions for each.
"""
function generate_all_permutations!(digits, start_idx, prime_sets)
    # Base case: we have a complete permutation
    if start_idx > length(digits)
        find_prime_partitions!(copy(digits), 1, Int[], prime_sets)
        return
    end

    # Try each remaining digit at the current position
    for i in start_idx:length(digits)
        # Swap digits[start_idx] with digits[i]
        digits[start_idx], digits[i] = digits[i], digits[start_idx]

        # Recurse with the next position
        generate_all_permutations!(digits, start_idx + 1, prime_sets)

        # Backtrack: swap back
        digits[start_idx], digits[i] = digits[i], digits[start_idx]
    end
end

"""
    find_prime_partitions!(digits, start_idx, current_partition, prime_sets)

Find all partitions of a specific digit arrangement that form sets of primes.
"""
function find_prime_partitions!(digits, start_idx, current_partition, prime_sets)
    # Base case: we've used all digits
    if start_idx > length(digits)
        if !isempty(current_partition)
            # Sort the partition to create canonical representation
            sorted_partition = sort(current_partition)
            push!(prime_sets, sorted_partition)
        end
        return
    end

    # Try all possible lengths for the next number starting at start_idx
    for end_idx in start_idx:length(digits)
        # Form a number from digits[start_idx:end_idx]
        number = form_number(digits, start_idx, end_idx)

        # Early pruning: skip if number can't be prime
        if !could_be_prime(number)
            continue
        end

        # Check if the number is actually prime
        if is_prime(number)
            # Add this number to current partition and recurse
            push!(current_partition, number)
            find_prime_partitions!(digits, end_idx + 1, current_partition, prime_sets)
            pop!(current_partition)
        end
    end
end

"""
    form_number(digits, start_idx, end_idx)

Form a number from consecutive digits in the array.
"""
function form_number(digits, start_idx, end_idx)
    number = 0
    for i in start_idx:end_idx
        number = number * 10 + digits[i]
    end
    return number
end

"""
    could_be_prime(n)

Quick check if a number could potentially be prime. Eliminates numbers ending in even digits
(except 2) or 5.
"""
function could_be_prime(n)
    n <= 1 && return false
    n == 2 && return true
    n == 5 && return true

    last_digit = n % 10
    # Numbers ending in 0, 2, 4, 5, 6, 8 cannot be prime (except 2 and 5)
    return last_digit in [1, 3, 7, 9]
end

function solve()
    # Use a set to store unique prime sets (represented as sorted tuples)
    prime_sets = Set{Vector{Int}}()

    # Generate all permutations of digits 1-9 and find valid partitions for each
    digits = collect(1:9)
    generate_all_permutations!(digits, 1, prime_sets)

    # Log the example set from the problem to verify it's found
    example_set = [2, 5, 47, 89, 631]
    if example_set in prime_sets
        @info "Found example set from problem description: {2, 5, 47, 89, 631}"
    end

    @info "Total number of pandigital prime sets found: $(length(prime_sets))"

    return length(prime_sets)
end

end # module
