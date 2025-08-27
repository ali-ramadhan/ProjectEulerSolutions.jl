"""
Project Euler Problem 89: Roman Numerals

For a number written in Roman numerals to be considered valid there are basic rules which
must be followed. Even though the rules allow some numbers to be expressed in more than one
way there is always a "best" way of writing a particular number.

For example, it would appear that there are at least six ways of writing the number sixteen:

IIIIIIIIIIIIIIII
VIIIIIIIIIII
VVIIIIII
XIIIIII
VVVI
XVI

However, according to the rules only XIIIIII and XVI are valid, and the last example is
considered to be the most efficient, as it uses the least number of numerals.

The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one
thousand randomly generated Roman numerals in a valid form. Find the number of characters
saved by writing each of these in their minimal form.

Note: You can assume that no more than four consecutive identical units are used.

## Solution approach

We solve this by implementing bidirectional conversion between Roman numerals and integers:

1. Parse each Roman numeral to its integer value using subtraction rules
2. Convert the integer back to minimal Roman form using greedy selection
3. Count the character savings: original_length - minimal_length

For parsing, we scan right-to-left, subtracting smaller values that precede larger ones. For
generation, we greedily use the largest possible Roman values including subtractive pairs.

## Complexity analysis

Time complexity: O(n × m)
- Where n is the number of Roman numerals and m is the average length
- Each conversion involves scanning the string once and generating the minimal form

Space complexity: O(m)
- Storage for the converted strings and lookup tables
- The Roman numeral value and symbol arrays are constant size

## Key insights

The problem illustrates the importance of canonical forms in numeral systems. The
subtractive notation (IV, IX, XL, XC, CD, CM) creates a more compact representation but
requires careful parsing logic to handle precedence correctly.
"""
module Problem089

values = Dict('I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000)

function roman_to_int(roman)
    total = 0
    prev = 0

    for char in reverse(roman)
        value = values[char]
        if value < prev
            total -= value
        else
            total += value
        end
        prev = value
    end

    return total
end

function int_to_minimal_roman(n)
    values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]

    result = ""

    for (i, value) in enumerate(values)
        count = div(n, value)
        if count > 0
            result *= symbols[i]^count
            n -= value * count
        end
    end

    return result
end

function solve()
    data_file = joinpath(@__DIR__, "..", "..", "data", "0089_roman.txt")

    total_saved = 0

    for line in eachline(data_file)
        roman = strip(line)
        if !isempty(roman)
            original_length = length(roman)
            number = roman_to_int(roman)
            minimal_roman = int_to_minimal_roman(number)
            minimal_length = length(minimal_roman)
            total_saved += original_length - minimal_length
        end
    end

    return total_saved
end

end # module
