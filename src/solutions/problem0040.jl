"""
Project Euler Problem 40: Champernowne's Constant

An irrational decimal fraction is created by concatenating the positive integers:
0.123456789101112131415...

It can be seen that the 12th digit of the fractional part is 1.

If d_n represents the nth digit of the fractional part, find the value of the following expression:
d₁ × d₁₀ × d₁₀₀ × d₁₀₀₀ × d₁₀₀₀₀ × d₁₀₀₀₀₀ × d₁₀₀₀₀₀₀

## Solution approach

To find the nth digit in Champernowne's constant efficiently, we need to determine which number
contains that digit and which position within that number.

The pattern is:
- 1-digit numbers (1-9): 9 numbers × 1 digit = 9 positions
- 2-digit numbers (10-99): 90 numbers × 2 digits = 180 positions
- 3-digit numbers (100-999): 900 numbers × 3 digits = 2700 positions
- And so on...

Algorithm:
1. Determine which "category" (1-digit, 2-digit, etc.) contains the nth position
2. Calculate how far into that category we are
3. Find the specific number within that category
4. Extract the correct digit from that number

This avoids having to generate the entire string up to position n.

## Complexity analysis

Time complexity: O(log n)
- We iterate through digit categories (1-digit, 2-digit, etc.) until we find the one containing position n
- The number of categories is O(log₁₀ n) since we're dealing with digit lengths
- Within each category, calculations are O(1)

Space complexity: O(log n)
- We only store the target number and perform arithmetic to extract its digits
- String conversion of the target number requires O(log n) space for its digit representation
- No data structures that grow with n
"""
module Problem0040

"""
    champernowne_digit(n)

Find the nth digit of Champernowne's constant.
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
    return parse(Int, string(number)[digit_position + 1])
end

function solve()
    positions = [1, 10, 100, 1000, 10000, 100000, 1000000]
    digits = [champernowne_digit(pos) for pos in positions]
    return prod(digits)
end

end # module
