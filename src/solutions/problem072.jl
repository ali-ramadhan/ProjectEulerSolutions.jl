"""
Project Euler Problem 72: Counting Fractions

Consider the fraction, n/d, where n and d are positive integers. 
If n < d and HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that there are 21 elements in this set.

How many elements would be contained in the set of reduced proper fractions for d ≤ 1,000,000?
"""
module Problem072

using ProjectEulerSolutions.Utils.NumberTheory: totient_sieve

"""
    count_reduced_proper_fractions(limit)

Count the number of reduced proper fractions with denominator ≤ limit.
A reduced proper fraction n/d satisfies n < d and gcd(n, d) = 1.

This is equivalent to the sum of Euler's totient function φ(d) for d from 2 to limit.
Uses a sieve-like approach for efficient computation of all φ values.
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
    return count_reduced_proper_fractions(1_000_000)
end

end # module
