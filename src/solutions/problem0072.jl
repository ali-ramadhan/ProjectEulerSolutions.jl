"""
Project Euler Problem 72: Counting Fractions

Consider the fraction, n/d, where n and d are positive integers. If n < d and HCF(n,d)=1, it
is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5,
5/6, 6/7, 7/8

It can be seen that there are 21 elements in this set.

How many elements would be contained in the set of reduced proper fractions for d ≤
1,000,000?

## Solution approach

The number of reduced proper fractions with denominator d equals φ(d), Euler's totient
function, which counts integers from 1 to d-1 that are coprime to d.

The total count is the sum of φ(d) for d from 2 to limit. We use an efficient sieve to
compute all totient values simultaneously.

## Complexity analysis

Time complexity: O(n log log n)
- The totient sieve has the same complexity as the Sieve of Eratosthenes

Space complexity: O(n)
- Stores the totient array for all numbers up to limit
"""
module Problem0072

using ProjectEulerSolutions.Utils.NumberTheory: totient_sieve

"""
    count_reduced_proper_fractions(limit)

Count the number of reduced proper fractions with denominator ≤ limit.
"""
function count_reduced_proper_fractions(limit)
    phi = totient_sieve(limit)

    result = BigInt(0)
    for d in 2:limit
        result += phi[d]
    end

    return result
end

function solve()
    result = count_reduced_proper_fractions(1_000_000)
    @info "Sum of totient values φ(d) for d=2 to 1,000,000: $result"
    return result
end

end # module
