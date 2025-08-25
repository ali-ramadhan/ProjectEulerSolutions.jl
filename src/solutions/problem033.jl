"""
Project Euler Problem 33: Digit Cancelling Fractions

The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it
may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value,
and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
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

    product = prod(curious_fractions)
    return denominator(product)
end

end # module
