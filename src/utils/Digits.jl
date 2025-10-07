"""
Digit manipulation utilities for Project Euler solutions.

This module provides functions for working with digits of numbers,
including digit sums, palindromes, permutations, and other digit-based operations.
"""
module Digits

export digit_sum,
    get_digits,
    count_digits,
    is_palindrome,
    is_pandigital,
    digit_rotations,
    are_permutations,
    digits_to_number

"""
    digit_sum(n)

Calculate the sum of all digits in the number n.

Example: digit_sum(123) returns 6 (1 + 2 + 3)
"""
function digit_sum(n)
    sum = 0
    n = abs(n)  # Handle negative numbers
    while n > 0
        sum += n % 10
        n ÷= 10
    end
    return sum
end

"""
    get_digits(n)

Return an array of digits of n in order (most significant digit first).

Example: get_digits(123) returns [1, 2, 3]
"""
function get_digits(n)
    n = abs(n)  # Handle negative numbers
    if n == 0
        return [0]
    end

    digits = Int[]
    while n > 0
        pushfirst!(digits, n % 10)
        n ÷= 10
    end
    return digits
end

"""
    count_digits(n)

Count the number of digits in n.

Example: count_digits(123) returns 3
"""
function count_digits(n)
    n = abs(n)  # Handle negative numbers
    n == 0 && return 1

    count = 0
    while n > 0
        count += 1
        n ÷= 10
    end
    return count
end

"""
    is_palindrome(n)

Check if the number n is a palindrome (reads the same forward and backward).

Implementation uses mathematical digit reversal instead of string conversion
for zero allocations and better performance.
"""
function is_palindrome(n)
    n = abs(n)  # Handle negative numbers
    original = n
    reversed = 0

    while n > 0
        reversed = reversed * 10 + (n % 10)
        n ÷= 10
    end

    return reversed == original
end

"""
    is_pandigital(n, digits=1:9)

Check if n is pandigital using the specified range of digits.
A pandigital number uses each digit in the range exactly once.

Example: is_pandigital(123, 1:3) returns true
Example: is_pandigital(2143, 1:4) returns true
"""
function is_pandigital(n, digits = 1:9)
    n_digits = get_digits(n)
    digit_set = Set(digits)

    # Must have exactly the right number of digits
    length(n_digits) == length(digit_set) || return false

    # Must use each digit exactly once
    return Set(n_digits) == digit_set
end

"""
    digit_rotations(n)

Generate all rotations of the digits of n.
For example, if n=197, returns [197, 971, 719].
"""
function digit_rotations(n)
    n_str = string(n)
    len = length(n_str)
    rotations = Int[]

    for i in 1:len
        rotated = n_str[i:end] * n_str[1:(i - 1)]
        push!(rotations, parse(Int, rotated))
    end

    return rotations
end

"""
    are_permutations(a, b)

Check if two numbers are permutations of each other (have the same digits).

Example: are_permutations(123, 321) returns true
"""
function are_permutations(a, b)
    return sort(collect(string(abs(a)))) == sort(collect(string(abs(b))))
end

"""
    digits_to_number(digits)

Convert an array of digits to a number.

Example: digits_to_number([1, 2, 3]) returns 123
"""
function digits_to_number(digits)
    num = 0
    for d in digits
        num = num * 10 + d
    end
    return num
end

"""
    product_of_digits(str)

Calculate the product of all digits in the given string.
Used for problems involving digit products.

Example: product_of_digits("123") returns 6
"""
function product_of_digits(str)
    prod = 1
    for c in str
        digit = parse(Int, c)
        prod *= digit
    end
    return prod
end

"""
    has_even_digit(n)

Check if a number n has any even digits (0, 2, 4, 6, 8).
This is used to optimize certain checks since numbers containing
even digits can't satisfy certain mathematical properties.

Example: has_even_digit(135) returns false, has_even_digit(123) returns true
"""
function has_even_digit(n)
    n_str = string(n)
    return any(c -> c in "02468", n_str)
end

end # module Digits
