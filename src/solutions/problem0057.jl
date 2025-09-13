"""
Project Euler Problem 57: Square Root Convergents

It is possible to show that the square root of two can be expressed as an infinite continued
fraction.

√2 = 1 + 1/(2 + 1/(2 + 1/(2 + ...)))

By expanding this for the first four iterations, we get:
1 + 1/2 = 3/2 = 1.5
1 + 1/(2 + 1/2) = 7/5 = 1.4
1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
1 + 1/(2 + 1/(2 + 1/(2 + 1/2)))) = 41/29 = 1.41379...

The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion,
1393/985, is the first example where the number of digits in the numerator exceeds the
number of digits in the denominator.

In the first one-thousand expansions, how many fractions contain a numerator with more
digits than the denominator?

## Solution approach

We use the well-known recurrence relation for continued fraction convergents:
p_n = 2*p_{n-1} + p_{n-2}, q_n = 2*q_{n-1} + q_{n-2}
starting with p_1 = 3, q_1 = 2. We generate each convergent iteratively and compare the
digit counts of numerator and denominator using BigInt arithmetic.

## Complexity analysis

Time complexity: O(n × d)
- n convergents to compute (1000)
- Each convergent arithmetic and digit counting takes O(d) time where d is digits

Space complexity: O(d)
- Space for BigInt numerator and denominator values

## Mathematical background

The convergents of √2 follow the recurrence relation derived from the continued fraction
expansion [1; 2, 2, 2, ...]. This gives the classical Pell-like sequence where each
convergent provides increasingly accurate rational approximations to √2.
"""
module Problem0057

"""
    count_numerator_exceeds_denominator(limit)

Count how many of the first 'limit' expansions of √2 have more digits
in the numerator than in the denominator.

Uses the recurrence relation for computing continued fraction convergents:
p₁ = 3, q₁ = 2
p_n = 2 * p_{n-1} + p_{n-2},
q_n = 2 * q_{n-1} + q_{n-2}
for n ≥ 2

See: https://en.wikipedia.org/wiki/Continued_fraction#Formulation
"""
function count_numerator_exceeds_denominator(limit)
    count = 0

    num_prev, den_prev = BigInt(1), BigInt(1)  # 0th convergent
    num_curr, den_curr = BigInt(3), BigInt(2)  # 1st convergent

    # Check first expansion
    if ndigits(num_curr) > ndigits(den_curr)
        count += 1
    end

    for n in 2:limit
        num_next = 2*num_curr + num_prev
        den_next = 2*den_curr + den_prev

        if ndigits(num_next) > ndigits(den_next)
            count += 1
        end

        num_prev, den_prev = num_curr, den_curr
        num_curr, den_curr = num_next, den_next
    end

    return count
end

function solve()
    result = count_numerator_exceeds_denominator(1000)
    @info "Found $result convergents of √2 where numerator has more digits than denominator"
    return result
end

end # module
