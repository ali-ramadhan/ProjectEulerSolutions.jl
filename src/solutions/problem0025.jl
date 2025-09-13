"""
Project Euler Problem 25: 1000-digit Fibonacci Number

The Fibonacci sequence is defined by the recurrence relation:
F_n = F_{n-1} + F_{n-2}, where F_1 = 1 and F_2 = 1.

Hence the first 12 terms will be:
F_1 = 1
F_2 = 1
F_3 = 2
F_4 = 3
F_5 = 5
F_6 = 8
F_7 = 13
F_8 = 21
F_9 = 34
F_10 = 55
F_11 = 89
F_12 = 144

The 12th term, F_12, is the first term to contain three digits.

What is the index of the first term in the Fibonacci sequence to contain 1000 digits?

## Solution approach

We generate Fibonacci numbers iteratively using BigInt for arbitrary precision arithmetic:
1. Start with F_1 = 1, F_2 = 1 and index i = 2
2. Generate the next Fibonacci number by adding the previous two
3. Check if the current number has reached 1000 digits using ndigits()
4. Continue until we find the first number with 1000 digits

Using BigInt ensures we can handle very large numbers without overflow.

## Complexity analysis

Time complexity: O(n × d)
- We generate approximately n ≈ 4782 Fibonacci numbers
- Each BigInt addition takes O(d) time where d is the number of digits
- For the final numbers, d ≈ 1000

Space complexity: O(d)
- We only store the current two Fibonacci numbers, each with up to d digits
"""
module Problem0025

"""
    first_fibonacci_with_n_digits(n)

Find the index of the first Fibonacci number that contains n digits.
Uses an iterative approach with BigInt to handle large numbers efficiently.
"""
function first_fibonacci_with_n_digits(n)
    a, b = BigInt(1), BigInt(1)
    i = 2

    while ndigits(b) < n
        a, b = b, a + b
        i += 1
    end

    return i
end

function solve()
    result = first_fibonacci_with_n_digits(1000)
    @info "F_$result is the first Fibonacci number with 1000 digits"
    return result
end

end # module
