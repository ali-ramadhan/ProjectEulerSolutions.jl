"""
Project Euler Problem 36: Double-base Palindromes

The decimal number, 585 = 1001001001_2 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and
base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)

## Solution approach

We need to find numbers that are palindromic in both decimal (base 10) and binary (base 2).
A palindrome reads the same forwards and backwards.

Key optimization: We only check odd numbers because even numbers cannot be palindromic in
binary. This is because even numbers end with 0 in binary, and to be palindromic, they would
need to start with 0 as well, which violates the no-leading-zeros rule.

For each odd number from 1 to 999,999, we:
1. Check if it's palindromic in base 10 (convert to string and compare with reverse)
2. If yes, check if it's palindromic in base 2 (convert to binary string and compare with
   reverse)
3. If both conditions are met, add it to our sum

## Complexity analysis

Time complexity: O(n × d)
- Where n = 500,000 (roughly half of 1,000,000 since we only check odd numbers)
- d is the average number of digits in decimal and binary representations (≈ log₁₀(n) +
  log₂(n))
- String operations for palindrome checking are O(d) for each number

Space complexity: O(d)
- We create temporary strings for decimal and binary representations
- Space usage is proportional to the number of digits, which is logarithmic in the input
- No data structures that grow with the search range
"""
module Problem036

"""
    is_palindromic_base10(n)

Check if the number n is palindromic in base 10 (decimal).
"""
function is_palindromic_base10(n)
    str = string(n)
    return str == reverse(str)
end

"""
    is_palindromic_base2(n)

Check if the number n is palindromic in base 2 (binary).
"""
function is_palindromic_base2(n)
    binary = string(n; base = 2)
    return binary == reverse(binary)
end

"""
    sum_double_base_palindromes(limit)

Find the sum of all numbers less than the given limit which are palindromic
in both base 10 and base 2.
"""
function sum_double_base_palindromes(limit)
    total_sum = 0

    for n in 1:2:(limit - 1)
        if is_palindromic_base10(n) && is_palindromic_base2(n)
            total_sum += n
        end
    end

    return total_sum
end

function solve()
    return sum_double_base_palindromes(1_000_000)
end

end # module
