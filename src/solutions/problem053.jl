"""
Project Euler Problem 53: Combinatoric Selections

There are exactly ten ways of selecting three from five, 12345:
123, 124, 125, 134, 135, 145, 234, 235, 245, and 345.
In combinatorics, we use the notation, 5C3 = 10.

In general, nCr = n! / r!(n-r)!, where r <= n, n! = n * (n-1) * ... * 3 * 2 * 1, and 0! = 1.

It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

How many, not necessarily distinct, values of nCr for 1 <= n <= 100, are greater than one-million?
"""
module Problem053

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
    return count_combinations_exceeding(1_000_000)
end

end # module
