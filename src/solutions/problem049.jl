"""
Project Euler Problem 49: Prime Permutations

The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is
unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit
numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting
this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this sequence?

## Solution approach

1. Generate all 4-digit primes using the Sieve of Eratosthenes
2. Group primes by their sorted digits to identify permutation groups
3. For each group with at least 3 primes, check all pairs to see if they form an arithmetic
   sequence with a third prime
4. Exclude the known sequence (1487, 4817, 8147) and return the other one

## Complexity analysis

Time complexity: O(N log log N + G × K²)
- O(N log log N) to generate primes up to N=10000
- G groups of permutations, each with K primes on average
- Check O(K²) pairs per group

Space complexity: O(N + G × K)
- Store N primes and G permutation groups
"""
module Problem049

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

"""
    get_sorted_digits(n)

Get the sorted digits of a number as a string key.
This allows for grouping numbers that are permutations of each other.
"""
function get_sorted_digits(n)
    return join(sort(collect(string(n))))
end

"""
    find_prime_permutation_sequence()

Find the arithmetic sequence of three 4-digit primes where each prime
is a permutation of the others, and the sequence is different from 1487, 4817, 8147.
Returns a tuple of the three primes in the sequence.
"""
function find_prime_permutation_sequence()
    primes = sieve_of_eratosthenes(10000)

    four_digit_primes = filter(p -> p >= 1000 && p <= 9999, primes)

    prime_set = Set(four_digit_primes)

    # Group primes by their sorted digits
    permutation_groups = Dict()
    for prime in four_digit_primes
        key = get_sorted_digits(prime)
        if !haskey(permutation_groups, key)
            permutation_groups[key] = Int[]
        end
        push!(permutation_groups[key], prime)
    end

    # Check each group with at least 3 primes
    for (_, group) in permutation_groups
        if length(group) >= 3
            sort!(group)

            # Check all pairs to see if a third prime completes an arithmetic sequence
            for i in 1:(length(group) - 1)
                for j in (i + 1):length(group)
                    p1, p2 = group[i], group[j]
                    diff = p2 - p1

                    p3 = p2 + diff

                    if p3 <= 9999 &&
                       p3 in prime_set &&
                       get_sorted_digits(p3) == get_sorted_digits(p1)
                        if !(p1 == 1487 && p2 == 4817 && p3 == 8147)
                            return (p1, p2, p3)
                        end
                    end
                end
            end
        end
    end

    return nothing
end

"""
    solve()

Solve Problem 49 by finding the sequence and concatenating the terms.
"""
function solve()
    sequence = find_prime_permutation_sequence()
    result = parse(Int, string(sequence[1], sequence[2], sequence[3]))
    @info "Found prime permutation arithmetic sequence: " *
          "$(sequence[1]), $(sequence[2]), $(sequence[3])"
    return result
end

end # module
