"""
Project Euler Problem 55: Lychrel Numbers

If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.

Not all numbers produce palindromes so quickly. For example,
349 + 943 = 1292
1292 + 2921 = 4213
4213 + 3124 = 7337

That is, 349 took three iterations to arrive at a palindrome.

Although no one has proved it yet, it is thought that some numbers, like 196, never produce
a palindrome. A number that never forms a palindrome through the reverse and add process is
called a Lychrel number. Due to the theoretical nature of these numbers, and for the purpose
of this problem, we shall assume that a number is Lychrel until proven otherwise. In
addition you are given that for every number below ten-thousand, it will either (i) become a
palindrome in less than fifty iterations, or, (ii) no one, with all the computing power that
exists, has managed so far to map it to a palindrome. In fact, 10677 is the first number to
be shown to require over fifty iterations before producing a palindrome:
4668731596684224866951378664 (53 iterations, 28-digits).

Surprisingly, there are palindromic numbers that are themselves Lychrel numbers;
the first example is 4994.

How many Lychrel numbers are there below ten-thousand?

## Solution approach

For each number below 10,000, we perform the reverse-and-add process up to 50 iterations. If
a palindrome is found within 50 iterations, the number is not Lychrel. Otherwise, we assume
it's Lychrel. We use BigInt arithmetic to handle the potentially large numbers that arise
during the process.

## Complexity analysis

Time complexity: O(n × k × d)
- n numbers to check (10,000)
- Up to k iterations per number (50)
- Each iteration processes d digits

Space complexity: O(d)
- Space for storing intermediate BigInt values during computation
"""
module Problem055

using ProjectEulerSolutions.Utils.Digits: is_palindrome

"""
    reverse_digits(n)

Reverse the digits of a number.
"""
function reverse_digits(n)
    return parse(BigInt, reverse(string(n)))
end

"""
    is_lychrel(n, max_iterations=50)

Check if a number is a Lychrel number by performing the reverse-and-add
process for up to max_iterations. Returns true if no palindrome is found
within the specified iterations.
"""
function is_lychrel(n, max_iterations = 50)
    num = BigInt(n)

    for _ in 1:max_iterations
        rev = reverse_digits(num)
        num += rev

        if is_palindrome(num)
            return false
        end
    end

    return true  # Assumed to be a Lychrel number after max_iterations
end

"""
    count_lychrel_numbers(limit)

Count how many Lychrel numbers are below the given limit.
"""
function count_lychrel_numbers(limit)
    count = 0

    for n in 1:(limit - 1)
        if is_lychrel(n)
            count += 1
        end
    end

    return count
end

function solve()
    result = count_lychrel_numbers(10_000)
    @info "Found $result Lychrel numbers below 10,000"
    return result
end

end # module
