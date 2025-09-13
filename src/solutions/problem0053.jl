"""
Project Euler Problem 53: Combinatoric Selections

There are exactly ten ways of selecting three from five, 12345:
123, 124, 125, 134, 135, 145, 234, 235, 245, and 345.

In combinatorics, we use the notation, 5C3 = 10.

In general, nCr = n! / r!(n-r)!, where r <= n, n! = n * (n-1) * ... * 3 * 2 * 1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

How many, not necessarily distinct, values of nCr for 1 <= n <= 100, are greater than
one-million?

## Solution approach

Rather than computing all binomial coefficients directly, we exploit the symmetry property
C(n,r) = C(n,n-r) and the fact that for fixed n, C(n,r) increases as r approaches n/2.
For each n, we find the smallest r where C(n,r) > limit, then use symmetry to count
all values that exceed the limit without computing them all.

## Complexity analysis

Time complexity: O(n × r_avg × B(n,r))
- For each n from 1 to 100 (constant), we search for the boundary r value
- For each n, we compute at most n/2 binomial coefficients until exceeding the limit
- Each binomial coefficient computation B(n,r) uses Julia's optimized implementation
- In practice, very efficient since we stop early when values exceed 1,000,000

Space complexity: O(1)
- Only constant extra space needed
"""
module Problem0053

"""
    count_combinations_exceeding(limit)

Count the number of combinations nCr where 1 ≤ n ≤ 100 and nCr > limit.
Uses the properties of binomial coefficients to optimize the calculation.

Takes advantage of two key properties:

 1. Symmetry: binomial(n,r) = binomial(n,n-r)
 2. Monotonicity: For fixed n, binomial(n,r) increases as r approaches n/2
"""
function count_combinations_exceeding(limit)
    count = 0

    for n in 1:100
        # Find the smallest r such that binomial(n,r) > limit
        r_min = 0
        while r_min <= n÷2 && binomial(n, r_min) <= limit
            r_min += 1
        end

        if r_min <= n÷2
            # Due to symmetry, the largest r with binomial(n, r) > limit is n - r_min
            r_max = n - r_min
            count += r_max - r_min + 1
        end
    end

    return count
end

function solve()
    result = count_combinations_exceeding(1_000_000)
    @info "Found $result combinations C(n,r) > 1,000,000 for 1 ≤ n ≤ 100"
    return result
end

end # module
