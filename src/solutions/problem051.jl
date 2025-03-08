"""
Project Euler Problem 51: Prime Digit Replacements

By replacing the 1st digit of the 2-digit number *3, it turns out that six of the nine possible values:
13, 23, 43, 53, 73, and 83, are all prime.

By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first
example having seven primes among the ten generated numbers, yielding the family:
56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member
of this family, is the smallest prime with this property.

Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits)
with the same digit, is part of an eight prime value family.
"""
module Problem051

"""
    sieve_of_eratosthenes(limit)

Generate all prime numbers up to limit using the Sieve of Eratosthenes algorithm.
Returns a vector of primes.
"""
function sieve_of_eratosthenes(limit)
    sieve = fill(true, limit)
    sieve[1] = false

    for i in 2:isqrt(limit)
        if sieve[i]
            for j in i^2:i:limit
                sieve[j] = false
            end
        end
    end

    return [i for i in 1:limit if sieve[i]]
end

"""
    generate_subsets(positions)

Generate all non-empty subsets of the given positions using bit manipulation.

This function leverages binary representation to create a "mask" for each possible subset:
1. For a set with n elements, there are 2^n possible subsets (including the empty set)
2. Each subset can be represented by an n-bit binary number, where each bit indicates whether
   to include (1) or exclude (0) the corresponding element
3. We iterate from 1 to 2^n-1 (skipping 0 to exclude the empty set)
"""
function generate_subsets(positions)
    n = length(positions)
    subsets = Vector{Int}[]

    for mask in 1:2^n-1
        subset = [positions[i] for i in 1:n if (mask >> (i-1)) & 1 == 1]
        push!(subsets, subset)
    end

    return subsets
end

"""
    find_prime_family(family_size, limit=1_000_000)

Find the smallest prime which, by replacing part of the number with the same digit,
is part of a family of at least family_size primes.
Returns a tuple (smallest_prime, family).
"""
function find_prime_family(family_size, limit=1_000_000)
    primes = sieve_of_eratosthenes(limit)
    primes_set = Set(primes)
    checked_primes = Set{Int}()

    for prime in primes
        if prime in checked_primes
            continue
        end

        # Skip small primes that can't form a large enough family
        if prime < 10
            continue
        end

        prime_str = string(prime)

        # Group positions by digit
        positions_by_digit = Dict{Char, Vector{Int}}()
        for (i, digit) in enumerate(prime_str)
            positions = get(positions_by_digit, digit, Int[])
            push!(positions, i)
            positions_by_digit[digit] = positions
        end

        # Check each digit's positions
        for (digit, positions) in positions_by_digit
            # Skip digits with too few occurrences
            if length(positions) <= 1
                continue
            end

            # Generate all non-empty subsets of positions
            for replace_pos in generate_subsets(positions)
                family = Int[]

                for d in 0:9
                    # Skip if we'd replace the first digit with 0
                    if d == 0 && 1 in replace_pos
                        continue
                    end

                    new_digits = collect(prime_str)
                    for p in replace_pos
                        new_digits[p] = Char('0' + d)
                    end
                    new_num = parse(Int, join(new_digits))

                    if new_num in primes_set
                        push!(family, new_num)
                    end
                end

                if length(family) >= family_size
                    union!(checked_primes, family)
                    return minimum(family), sort(family)
                end
            end
        end
    end

    return nothing, []  # No solution found
end

"""
    find_eight_prime_family(limit=1_000_000)

Find the smallest prime which, by replacing part of the number with the same digit,
is part of an eight prime value family.
"""
function find_eight_prime_family(limit=1_000_000)
    smallest, _ = find_prime_family(8, limit)
    return smallest
end

function solve()
    return find_eight_prime_family()
end

end # module
