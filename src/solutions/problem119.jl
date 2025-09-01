"""
Project Euler Problem 119: Digit Power Sum

The number 512 is interesting because it is equal to the sum of its digits raised to some
power: 5 + 1 + 2 = 8, and 8³ = 512. Another example of a number with this property is 614656
= 28⁴.

We shall define aₙ to be the nth term of this sequence and insist that a number must contain
at least two digits to have a sum.

You are given that a₂ = 512 and a₁₀ = 614656.

Find a₃₀.

## Solution approach

Instead of checking every number to see if it equals (sum of its digits)^k for some k, we
generate candidates by iterating over possible bases (digit sums) and powers.

For each base b from 2 to some reasonable upper bound (~200), and for each power p starting
from 2, we compute n = b^p and check if the sum of digits of n equals b. If so, n is part of
our sequence.

This approach is much more efficient because:
1. We only check numbers that could potentially be valid
2. We can stop early when b^p grows too large
3. We avoid expensive digit sum calculations on every integer

## Complexity analysis

Time complexity: O(B × P × log(n))
- B ≈ 200 possible bases (digit sums)
- P ≈ 50 reasonable powers to check
- log(n) for digit sum calculation of the result

Space complexity: O(k)
- k is the number of valid digit power sum numbers found (≈ 30 in this case)

## Key insights

- The digit sum of a number is bounded, so we only need to check bases up to ~200
- For large powers, b^p grows exponentially, so we can stop early
- By generating candidates systematically, we ensure we find all numbers in order
"""
module Problem119

using ProjectEulerSolutions.Utils.Digits: digit_sum

"""
    find_digit_power_sum_numbers(limit)

Find all numbers up to position `limit` in the digit power sum sequence. Returns a sorted
array of numbers where each number equals (sum of its digits)^k for some power k ≥ 2, and
the number has at least 2 digits.
"""
function find_digit_power_sum_numbers(limit)
    candidates = Int[]

    # Check bases (digit sums) from 2 to reasonable upper bound
    for base in 2:200
        power = 2

        while true
            # Calculate base^power
            if power > 60  # Prevent overflow for large powers
                break
            end

            candidate = big(base)^power

            # If candidate is too large, stop checking higher powers for this base
            if candidate > 10^20  # Reasonable upper bound
                break
            end

            # Convert back to Int if small enough
            if candidate > typemax(Int)
                break
            end
            candidate_int = Int(candidate)

            # Must have at least 2 digits
            if candidate_int < 10
                power += 1
                continue
            end

            # Check if digit sum equals our base
            if digit_sum(candidate_int) == base
                push!(candidates, candidate_int)
                @info "Found digit power sum number: $candidate_int = $base^$power"
            end

            power += 1
        end
    end

    # Sort candidates and return first `limit` numbers
    sort!(candidates)
    return candidates
end

function solve()
    # Find enough numbers to get the 30th term
    numbers = find_digit_power_sum_numbers(35)  # Get a few extra to be safe

    return numbers[30]
end

end # module
