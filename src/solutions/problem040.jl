"""
Project Euler Problem 40: Champernowne's Constant

An irrational decimal fraction is created by concatenating the positive integers:
0.123456789101112131415...

It can be seen that the 12th digit of the fractional part is 1.

If d_n represents the nth digit of the fractional part, find the value of the following expression:
d₁ × d₁₀ × d₁₀₀ × d₁₀₀₀ × d₁₀₀₀₀ × d₁₀₀₀₀₀ × d₁₀₀₀₀₀₀
"""
module Problem040

"""
    champernowne_digit(n)

Find the nth digit of Champernowne's constant (the decimal fraction created by
concatenating positive integers 0.123456789101112...).

Algorithm:
1. Determine which category of numbers (1-digit, 2-digit, etc.) contains the nth digit.
2. Calculate the specific number within that category.
3. Extract the correct digit from that number.
"""
function champernowne_digit(n)
    position = 0
    digits = 1

    # Calculate the range of positions for each number of digits
    # until we find the range that includes n
    while true
        # How many numbers have `digits` digits?
        count = digits == 1 ? 9 : 9 * 10^(digits-1)

        # Total positions for all these numbers
        total = count * digits

        # If n is within this range, we're done
        if position + total >= n
            break
        end

        # Otherwise, update position and digits
        position += total
        digits += 1
    end

    # Now, position is the last position before the start of the range containing n
    # Calculate the offset within this range
    offset = n - position - 1

    # Calculate which number contains the target digit
    number = 10^(digits-1) + offset ÷ digits

    # Calculate which digit of that number to return
    digit_position = offset % digits

    # Extract and return the digit
    return parse(Int, string(number)[digit_position+1])
end

function solve()
    return champernowne_digit(1) *
           champernowne_digit(10) *
           champernowne_digit(100) *
           champernowne_digit(1000) *
           champernowne_digit(10000) *
           champernowne_digit(100000) *
           champernowne_digit(1000000)
end

end # module
