"""
Project Euler Problem 113: Non-bouncy numbers

Working from left-to-right if no digit is exceeded by the digit to its left it is called an
increasing number; for example, 134468.

Similarly if no digit is exceeded by the digit to its right it is called a decreasing
number; for example, 66420.

We shall call a positive integer that is neither increasing nor decreasing a "bouncy"
number; for example, 155349.

As n increases, the proportion of bouncy numbers below n increases such that there are only
12951 numbers below one-million that are not bouncy and only 277032 non-bouncy numbers below
10^10.

How many numbers below a googol (10^100) are not bouncy?

## Solution approach

Use combinatorics with stars and bars instead of iterating through 10^100 numbers.

Key insight: Count digit frequency distributions rather than individual numbers. For
example, 112334 = "two 1s, one 2, two 3s, one 4".

Increasing numbers: Distribute up to 100 slots among digits {1,2,...,9} → C(109, 9) - 1
Decreasing numbers: Distribute up to 100 slots among digits {0,1,...,9} → C(110, 10) - 1
Overlap adjustment: Numbers counted twice (111, 222, etc.) → subtract 1000

Final formula: C(109, 9) + C(110, 10) - 1000 - 2

## Complexity analysis

Time complexity: O(1)
- We compute exactly 3 binomial coefficients regardless of input size
- Each binomial coefficient computation is O(min(k, n-k)) using Julia's optimized
  implementation

Space complexity: O(1)
- Only constant extra space needed for the computation

## Mathematical background

Stars and bars: Distributes n identical objects into k bins → C(n+k-1, k-1) ways. Here we
distribute digit slots among digit types to count valid number patterns.

Overlap formula: The 10×max_digits adjustment emerges from inclusion-exclusion applied to
the stars and bars formulation, elegantly handling constant numbers (111, 222, etc.).
"""
module Problem0113

"""
    count_increasing_numbers(max_digits)

Count increasing numbers with up to max_digits digits using stars and bars.

Distributes up to max_digits slots among digits {1,2,...,9} (excluding 0 since numbers can't
start with 0). Formula: C(max_digits + 9, 9) - 1 (subtract 1 for empty case)
"""
function count_increasing_numbers(max_digits)
    return binomial(BigInt(max_digits + 9), BigInt(9)) - BigInt(1)
end

"""
    count_decreasing_numbers(max_digits)

Count decreasing numbers with up to max_digits digits using stars and bars.

Distributes up to max_digits slots among digits {0,1,2,...,9} (including 0 since it can
appear at the end). Formula: C(max_digits + 10, 10) - 1 (subtract 1 for empty case)
"""
function count_decreasing_numbers(max_digits)
    return binomial(BigInt(max_digits + 10), BigInt(10)) - BigInt(1)
end

"""
    count_overlap_adjustment(max_digits)

Calculate overlap adjustment for numbers counted as both increasing and decreasing.

These are constant-digit numbers (111, 222, etc.). The formula 10 × max_digits emerges from
the inclusion-exclusion principle applied to the stars and bars counts.
"""
function count_overlap_adjustment(max_digits)
    return BigInt(10 * max_digits)
end

"""
    count_non_bouncy_numbers(max_digits)

Count non-bouncy numbers using inclusion-exclusion: increasing + decreasing - overlap.

A non-bouncy number is either increasing, decreasing, or both (like constant-digit numbers).
Formula: [C(max_digits+9, 9) - 1] + [C(max_digits+10, 10) - 1] - [10 × max_digits]
"""
function count_non_bouncy_numbers(max_digits)
    increasing = count_increasing_numbers(max_digits)
    decreasing = count_decreasing_numbers(max_digits)
    overlap = count_overlap_adjustment(max_digits)

    # Formula from research: increasing + decreasing - 10 * max_digits
    non_bouncy = increasing + decreasing - overlap

    @info "Increasing numbers with $max_digits digits: $increasing"
    @info "Decreasing numbers with $max_digits digits: $decreasing"
    @info "Overlap adjustment: $overlap"
    @info "Non-bouncy numbers with $max_digits digits: $non_bouncy"

    return non_bouncy
end

function solve()
    return count_non_bouncy_numbers(100)
end

end # module
