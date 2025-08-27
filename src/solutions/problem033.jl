"""
Project Euler Problem 33: Digit Cancelling Fractions

The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to
simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by
cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in
value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value
of the denominator.

## Solution approach

We systematically check all two-digit fractions where numerator < denominator to find
"curious" fractions. For each fraction, we extract the individual digits and try all four
possible digit cancellations:

1. Cancel matching last digits (AB/CD → A/C if B = D)
2. Cancel first digit of numerator with last of denominator (AB/CD → B/C if A = D)
3. Cancel last digit of numerator with first of denominator (AB/CD → A/D if B = C)
4. Cancel matching first digits (AB/CD → B/D if A = C)

We verify that the "incorrect" cancellation gives the same result as the original fraction.
We exclude trivial cases where both numbers end in 0.

## Complexity analysis

Time complexity: O(n²)
- Where n = 90 (two-digit numbers from 10-99)
- We check all pairs where numerator < denominator: roughly 90 × 45 = 4,050 combinations
- For each fraction, we perform constant-time digit extraction and rational arithmetic

Space complexity: O(k)
- Where k = 4 (the number of curious fractions as stated in the problem)
- We store the curious fractions in an array and compute their product
"""
module Problem033

"""
    is_curious_fraction(numerator, denominator)

Check if a fraction has the curious property where incorrectly cancelling
common digits results in the correct simplified fraction.
"""
function is_curious_fraction(numerator, denominator)
    if numerator < 10 || numerator > 99 || denominator < 10 || denominator > 99
        return false
    end

    # Ensure fraction is less than 1
    if numerator >= denominator
        return false
    end

    actual_fraction = numerator // denominator

    num_tens, num_ones = divrem(numerator, 10)
    den_tens, den_ones = divrem(denominator, 10)

    # Skip trivial cases where both numbers end in 0
    if num_ones == 0 && den_ones == 0
        return false
    end

    # Try all four possible digit cancellations
    digit_cancellations = [
        # Cancel matching last digits
        (num_ones == den_ones && num_ones != 0) ? (num_tens // den_tens) : nothing,

        # Cancel first digit of numerator with last digit of denominator
        (num_tens == den_ones && num_tens != 0) ? (num_ones // den_tens) : nothing,

        # Cancel last digit of numerator with first digit of denominator
        (num_ones == den_tens && num_ones != 0) ? (num_tens // den_ones) : nothing,

        # Cancel matching first digits
        (num_tens == den_tens && num_tens != 0) ? (num_ones // den_ones) : nothing,
    ]

    for cancelled_fraction in digit_cancellations
        if cancelled_fraction !== nothing && cancelled_fraction == actual_fraction
            return true
        end
    end

    return false
end

"""
    find_curious_fractions()

Find all curious fractions where incorrectly cancelling digits gives the correct result.
"""
function find_curious_fractions()
    result = Rational{Int}[]

    for numerator in 10:99
        for denominator in (numerator + 1):99
            if is_curious_fraction(numerator, denominator)
                push!(result, numerator // denominator)
            end
        end
    end

    return result
end

"""
    solve()

Find the denominator of the product of all curious fractions, expressed in lowest terms.
"""
function solve()
    curious_fractions = find_curious_fractions()

    # Verify there are exactly 4 as stated in the problem
    @assert length(curious_fractions) == 4

    @info "Found the 4 curious fractions: " *
          "$(join([string(f) for f in curious_fractions], ", "))"

    product = prod(curious_fractions)

    @info "Product of curious fractions: $product = " *
          "$(numerator(product))/$(denominator(product))"

    return denominator(product)
end

end # module
