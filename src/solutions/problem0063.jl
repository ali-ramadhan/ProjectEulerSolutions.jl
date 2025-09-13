"""
Project Euler Problem 63: Powerful Digit Counts

The 5-digit number, 16807 = 7^5, is also a fifth power. Similarly, the 9-digit number,
134217728 = 8^9, is a ninth power.

How many n-digit positive integers exist which are also an nth power?

## Solution approach

This solution uses mathematical analysis to avoid brute force enumeration:
1. For x^n to have exactly n digits, we need: 10^(n-1) ≤ x^n < 10^n
2. Taking logarithms: (n-1) ≤ n*log10(x) < n, which gives: (n-1)/n ≤ log10(x) < 1
3. Since log10(x) < 1, we need x < 10, so x ∈ {1,2,3,4,5,6,7,8,9}
4. For each valid x, the maximum n is: n ≤ 1/(1-log10(x))
5. Count all valid combinations by summing max_n for each x

## Complexity analysis

Time complexity: O(1)
- Fixed loop over x ∈ {1,2,3,4,5,6,7,8,9}
- Simple arithmetic operations for each x

Space complexity: O(1)
- Only stores a few variables

## Mathematical background

The constraint 10^(n-1) ≤ x^n < 10^n ensures exactly n digits. Taking log base 10:
- Lower bound: n-1 ≤ n*log10(x), so log10(x) ≥ (n-1)/n
- Upper bound: n*log10(x) < n, so log10(x) < 1

Since log10(x) < 1, we have x < 10. For each x ∈ {1,...,9}, we solve: n ≤ 1/(1-log10(x))

This gives the maximum valid n for each base x.
"""
module Problem0063

"""
    count_powerful_digit_numbers()

Count the number of n-digit positive integers that are also an nth power. For a number x^n
to have exactly n digits, it must satisfy: 10^(n-1) ≤ x^n < 10^n This constrains x to be
less than 10 and n to be at most 1 / (1 - log10(x)).
"""
function count_powerful_digit_numbers()
    count = 0
    for x in 1:9  # x must be less than 10
        # For x^n to have exactly n digits, we need:
        # n ≤ 1 / (1 - log10(x))
        max_n = floor(Int, 1 / (1 - log10(x)))
        count += max_n
        @info "Base $x contributes $max_n powerful digit numbers (up to $(x)^$(max_n))"
    end
    return count
end

function solve()
    return count_powerful_digit_numbers()
end

end # module
