"""
Digit manipulation utilities for Project Euler solutions.

This module provides functions for working with digits of numbers,
including digit sums, palindromes, permutations, and other digit-based operations.
"""
module Digits

export digit_sum,
    digit_factorial_sum,
    get_digits,
    count_digits,
    is_palindrome,
    make_palindrome,
    is_pandigital,
    rotate_digits,
    digit_rotations,
    are_permutations,
    digits_to_number

"""
    digit_sum(n)

Calculate the sum of all digits in the number n.

Example: digit_sum(123) returns 6 (1 + 2 + 3)
"""
function digit_sum(n)
    n == 0 && return 0
    return sum(digits(abs(n)))
end

"""
    digit_factorial_sum(n)

Calculate the sum of the factorials of the digits of n efficiently without
allocating a digit array.

Example: digit_factorial_sum(145) returns 145 (1! + 4! + 5! = 1 + 24 + 120)
"""
function digit_factorial_sum(n)
    n == 0 && return 1  # 0! = 1
    n = abs(n)
    s = 0

    while n > 0
        n, d = divrem(n, 10)
        s += factorial(d)
    end

    return s
end

"""
    get_digits(n)

Return an array of digits of n in order (most significant digit first).

Example: get_digits(123) returns [1, 2, 3]
"""
function get_digits(n)
    return reverse(digits(abs(n)))
end

"""
    count_digits(n)

Count the number of digits in n.

Example: count_digits(123) returns 3
"""
function count_digits(n)
    return ndigits(abs(n))
end

"""
    is_palindrome(n; base=10)

Check if the number n is a palindrome (reads the same forward and backward) when
written in the given base.

Implementation uses mathematical digit reversal instead of string conversion
for zero allocations and better performance.

Example: is_palindrome(585; base=2) returns true as 585 is 1001001001 in binary
"""
function is_palindrome(n; base=10)
    n = abs(n)  # Handle negative numbers
    base = oftype(n, base)
    original = n
    reversed = zero(typeof(n))

    while n > 0
        n, digit = divrem(n, base)
        reversed = reversed * base + digit
    end

    return reversed == original
end

"""
    make_palindrome(h; odd=false)

Build the palindrome that starts with the digits of h by appending them in reverse.
With `odd=true` the last digit of h becomes the middle digit and is not repeated,
so the palindrome has an odd number of digits.

Example: make_palindrome(123) returns 123321 and make_palindrome(123; odd=true) returns 12321
"""
function make_palindrome(h; odd=false)
    ten = oftype(h, 10)
    p = h
    odd && (h ÷= ten)  # Don't repeat the middle digit

    while h > 0
        h, digit = divrem(h, ten)
        p = p * ten + digit
    end

    return p
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
    rotate_digits(n, d=ndigits(n))

Rotate the digits of n one place to the left, moving the leading digit to the end.
`d` is the number of digit positions, so a leading zero left by an earlier rotation
still counts as a digit: rotate_digits(11, 3) treats 11 as 011 and returns 110.

Example: rotate_digits(197) returns 971
"""
function rotate_digits(n, d=ndigits(n))
    ten = oftype(n, 10)
    leading, rest = divrem(n, ten^(d - 1))
    return rest * ten + leading
end

"""
    digit_rotations(n)

Generate all rotations of the digits of n, each obtained from the previous one
with `rotate_digits`.

Example: digit_rotations(197) returns [197, 971, 719]
"""
function digit_rotations(n)
    d = ndigits(n)
    rotations = Vector{typeof(n)}(undef, d)

    for i in 1:d
        rotations[i] = n
        n = rotate_digits(n, d)
    end

    return rotations
end

"""
    are_permutations(a, b)

Check if two numbers are permutations of each other (have the same digits).

Example: are_permutations(123, 321) returns true
"""
function are_permutations(a, b)
    return sort(digits(abs(a))) == sort(digits(abs(b)))
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
    return any(iseven, digits(n))
end

end # module Digits
