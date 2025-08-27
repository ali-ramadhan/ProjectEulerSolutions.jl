"""
Project Euler Problem 41: Pandigital Prime

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n
exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?

## Solution approach

The key insight is that many n-digit pandigitals cannot be prime due to divisibility by 3.
Since the sum of digits 1+2+...+n equals n(n+1)/2, if this sum is divisible by 3, then all
n-digit pandigitals are divisible by 3 and cannot be prime (except 3 itself).

For n=9: sum=45 (divisible by 3), n=8: sum=36 (divisible by 3), n=6: sum=21 (divisible by
3), n=3: sum=6 (divisible by 3).

So we only need to check n=7, 5, 4, 2, 1. We start from n=7 and work downward, generating
permutations and checking primality.

## Complexity analysis

Time complexity: O(n! × √p)
- Generate all n! permutations for valid n values
- Check primality for each candidate number p, taking O(√p) time

Space complexity: O(n!)
- Store all valid permutation candidates before checking primality
"""
module Problem041

using Combinatorics
using ProjectEulerSolutions.Utils.Primes: is_prime
using ProjectEulerSolutions.Utils.Digits: digits_to_number

"""
    find_largest_pandigital_prime()

Find the largest n-digit pandigital prime. A pandigital number uses all digits from 1 to n
exactly once. Optimized by skipping n values where sum of digits 1 to n is divisible by 3
and checking only numbers that end in 1, 3, 7, or 9.

By divisibility rules, 9-digit, 8-digit, 6-digit, and 3-digit pandigitals cannot be prime
(sum of digits 1 to n is divisible by 3).
"""
function find_largest_pandigital_prime()
    for n in 7:-1:1
        if sum(1:n) % 3 == 0
            continue
        end

        # Generate pandigital candidates that may be prime
        candidates = Int[]
        for p in permutations(1:n)
            if p[end] % 2 != 0 && p[end] != 5
                push!(candidates, digits_to_number(p))
            end
        end

        sort!(candidates; rev = true)

        for num in candidates
            if is_prime(num)
                return num
            end
        end
    end

    return nothing
end

function solve()
    n = find_largest_pandigital_prime()
    @info "The largest pandigital prime is $n with $(length(digits(n))) digits!"
    return n
end

end # module
