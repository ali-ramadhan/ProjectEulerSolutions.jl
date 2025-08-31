"""
Project Euler Problem 112: Bouncy Numbers

Working from left-to-right if no digit is exceeded by the digit to its left it is called an
increasing number; for example, 134468.

Similarly if no digit is exceeded by the digit to its right it is called a decreasing
number; for example, 66420.

We shall call a positive integer that is neither increasing nor decreasing a "bouncy"
number; for example, 155349.

Clearly there cannot be any bouncy numbers below one-hundred, but just over half of the
numbers below one-thousand (525) are bouncy numbers.

In fact, the least number for which the proportion of bouncy numbers first reaches 50% is
538.

Surprisingly, bouncy numbers become more and more common and by the time we reach 21780 the
proportion of bouncy numbers is equal to 90%.

Find the least number for which the proportion of bouncy numbers is exactly 99%.

## Solution approach

We need to classify numbers as increasing, decreasing, or bouncy, then find when
bouncy numbers reach exactly 99% of all numbers up to that point.

For each number, we check consecutive digits:
- Increasing: no digit decreases from left to right
- Decreasing: no digit increases from left to right
- Bouncy: neither increasing nor decreasing

We iterate through numbers, maintaining a count of bouncy numbers, and check
when the proportion reaches exactly 99%.

## Complexity analysis

Time complexity: O(n × d) where n is the target number and d is average digits per number
- We check each number up to the result
- For each number, we examine its digits once

Space complexity: O(1)
- Only storing counters and temporary variables
"""
module Problem112

"""
Check if a number is increasing (digits non-decreasing from left to right).
"""
function is_increasing(n::Int)::Bool
    digits_arr = digits(n, base=10)
    reverse!(digits_arr)  # digits() returns in reverse order

    for i in 1:(length(digits_arr)-1)
        if digits_arr[i] > digits_arr[i+1]
            return false
        end
    end
    return true
end

"""
Check if a number is decreasing (digits non-increasing from left to right).
"""
function is_decreasing(n::Int)::Bool
    digits_arr = digits(n, base=10)
    reverse!(digits_arr)  # digits() returns in reverse order

    for i in 1:(length(digits_arr)-1)
        if digits_arr[i] < digits_arr[i+1]
            return false
        end
    end
    return true
end

"""
Check if a number is bouncy (neither increasing nor decreasing).
"""
function is_bouncy(n::Int)::Bool
    return !is_increasing(n) && !is_decreasing(n)
end

function solve()
    bouncy_count = 0
    n = 99  # Start from 99, since numbers below 100 cannot be bouncy

    while true
        n += 1

        if is_bouncy(n)
            bouncy_count += 1
        end

        # Check if proportion of bouncy numbers is exactly 99%
        # We want: bouncy_count / n == 0.99
        # Which is: bouncy_count * 100 == n * 99
        if bouncy_count * 100 == n * 99
            @info "Found target at n=$n with $bouncy_count bouncy numbers out of $n total"
            return n
        end
    end
end

end # module
