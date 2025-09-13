"""
Project Euler Problem 64: Odd Period Square Roots

All square roots are periodic when written as continued fractions and can be written in the
form:
√N = a₀ + 1/(a₁ + 1/(a₂ + 1/(a₃ + ...)))

For example, let us consider √23:
√23 = 4 + √23 - 4 = 4 + 1/(1/(√23 - 4)) = 4 + 1/(1 + (√23 - 3)/7)

If we continue we would get the following expansion:
√23 = 4 + 1/(1 + 1/(3 + 1/(1 + 1/(8 + ...))))

It can be seen that the sequence is repeating. For conciseness, we use the notation
√23 = [4; (1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.

Exactly four continued fractions, for N ≤ 13, have an odd period. How many continued
fractions for N ≤ 10,000 have an odd period?

## Solution approach

This solution computes the period of continued fraction expansions for square roots:
1. For each N from 1 to 10,000, skip perfect squares (they have no periodic part)
2. Use the standard algorithm for continued fractions of quadratic irrationals:
   - Start with √N = a₀ + (√N - a₀) where a₀ = floor(√N)
   - Iterate: (√N - mᵢ)/dᵢ = aᵢ + ((√N - mᵢ₊₁)/dᵢ₊₁)
   - Track states (m,d) until we detect a cycle
3. Count numbers where the period length is odd

## Complexity analysis

Time complexity: O(N * P) where N = 10,000 and P is average period length
- For each non-square N ≤ 10,000, we compute its period
- Period lengths are typically small (O(√N) on average)
- Total complexity approximately O(N^1.5)

Space complexity: O(1)
- Only stores the current state (m, d) and initial state
- No need to store the entire period

## Mathematical background

Continued fractions for quadratic irrationals √N are always eventually periodic. The period
detection algorithm uses the recurrence relations:
- aᵢ = floor((a₀ + mᵢ)/dᵢ)
- mᵢ₊₁ = aᵢ * dᵢ - mᵢ
- dᵢ₊₁ = (N - mᵢ₊₁²)/dᵢ

The period ends when we return to the initial state (m₁, d₁).
"""
module Problem0064

"""
    period_of_continued_fraction_sqrt(N)

Calculate the period of the continued fraction expansion of √N. Returns 0 if N is a perfect
square (as there is no period in that case).

The algorithm detects the period by tracking the sequence of states (m, d) until a cycle is
detected. This implementation follows the standard approach for computing continued
fractions of quadratic irrationals.
"""
function period_of_continued_fraction_sqrt(N)
    a0 = isqrt(N)

    # If N is a perfect square, it has no periodic continued fraction
    if a0^2 == N
        return 0
    end

    # Initialize
    m, d = 0, 1

    # Compute the first iteration
    a = a0
    m = a * d - m
    d = div(N - m^2, d)

    # Record the initial state and count the period
    initial_state = (m, d)
    period = 0

    while true
        # Compute the next iteration
        a = div(a0 + m, d)
        m = a * d - m
        d = div(N - m^2, d)

        period += 1

        # Check if we've returned to the initial state
        if (m, d) == initial_state
            return period
        end
    end
end

function count_continued_fraction_sqrt_with_odd_period(limit)
    count = 0
    for N in 1:limit
        if isqrt(N)^2 != N
            period = period_of_continued_fraction_sqrt(N)
            if period % 2 == 1
                count += 1
            end
        end
    end
    return count
end

function solve()
    return count_continued_fraction_sqrt_with_odd_period(10_000)
end

end # module
