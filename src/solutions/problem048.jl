"""
Project Euler Problem 48: Self Powers

The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

## Solution approach

Use modular arithmetic to compute only the last ten digits. For each term n^n,
use modular exponentiation to compute n^n mod 10^10 efficiently.
Sum all terms modulo 10^10 to get the final answer.

## Complexity analysis

Time complexity: O(N log N)
- N terms in the sum
- Each modular exponentiation takes O(log N) time

Space complexity: O(1)
- Only store running sum and temporary values
"""
module Problem048

"""
    last_ten_digits_of_self_powers(limit)

Calculate the last ten digits of the sum of self powers from 1 to limit.
Uses modular arithmetic to prevent overflow when dealing with large numbers.
"""
function last_ten_digits_of_self_powers(limit, modulus)
    total = 0

    for n in 1:limit
        power = powermod(n, n, modulus)
        total = (total + power) % modulus
    end

    return total
end

function solve()
    return last_ten_digits_of_self_powers(1000, 10^10)
end

end # module
