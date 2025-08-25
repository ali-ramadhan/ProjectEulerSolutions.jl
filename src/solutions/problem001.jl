"""
Project Euler Problem 1: Multiples of 3 or 5

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6
and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.

## Solution approach

This solution uses arithmetic series formulas with inclusion-exclusion principle.
For multiples of a number `n` below limit `L`:
- Number of multiples: k = floor((L-1)/n)
- Sum = n × (1 + 2 + ... + k) = n × k × (k+1) / 2

For a single factor, we apply the arithmetic series formula directly.
For two factors (3 and 5), we apply inclusion-exclusion:
sum(multiples of 3 or 5) = sum(multiples of 3) + sum(multiples of 5) - sum(multiples of 15),
where 15 = lcm(3,5) accounts for numbers counted twice.

## Complexity analysis

Time complexity: O(1)
- Single factor: One arithmetic series calculation
- Two factors: Three constant-time arithmetic series calculations
- No iteration over the range of numbers

Space complexity: O(1)
- Only stores a few integer variables
- No data structures that grow with input size

## Mathematical background

The solution relies on the arithmetic series sum formula: 1 + 2 + ... + k = k(k+1)/2.
The inclusion-exclusion principle states: |A ∪ B| = |A| + |B| - |A ∩ B|.
Since 3 and 5 are coprime, lcm(3,5) = 3 × 5 = 15.
"""
module Problem001

"""
    sum_arithmetic_series(n, limit)

Calculate the sum of multiples of `n` below `limit` using arithmetic series formula.
"""
function sum_arithmetic_series(n, limit)
    if n >= limit
        return 0
    end
    k = div(limit - 1, n)  # Number of multiples of n below limit
    return n * k * (k + 1) ÷ 2
end

"""
    sum_multiples(factors, limit)

Calculate the sum of all numbers below `limit` that are multiples of the given factors
using inclusion-exclusion principle. Supports 1 or 2 factors only.
"""
function sum_multiples(factors, limit)
    if length(factors) == 1
        return sum_arithmetic_series(factors[1], limit)
    elseif length(factors) == 2
        a, b = factors[1], factors[2]
        return sum_arithmetic_series(a, limit) +
               sum_arithmetic_series(b, limit) -
               sum_arithmetic_series(lcm(a, b), limit)
    else
        error("Only supports 1 or 2 factors")
    end
end

function solve()
    return sum_multiples([3, 5], 1000)
end

end # module
