"""
Project Euler Problem 95: Amicable chains

The proper divisors of a number are all the divisors excluding the number itself.
For example, the proper divisors of 28 are 1, 2, 4, 7, and 14. As the sum of
these divisors is equal to 28, we call it a perfect number.

Interestingly the sum of the proper divisors of 220 is 284 and the sum of the
proper divisors of 284 is 220, forming a chain of two numbers. For this reason,
220 and 284 are called an amicable pair.

Perhaps less well known are longer chains. For example, starting with 12496, we form
a chain of five numbers:

12496 → 14288 → 15472 → 14536 → 14264 (→ 12496, ...)

Since this chain returns to its starting point, it is called an amicable chain.

Find the smallest member of the longest amicable chain with no element exceeding
one million.
"""
module Problem095

"""
Compute sum of proper divisors for a single number.
More memory efficient than precomputing all divisors.
"""
function sum_proper_divisors(n::Int)
    n <= 1 && return 0

    divisor_sum = 1  # 1 is always a proper divisor
    sqrt_n = isqrt(n)

    for i in 2:sqrt_n
        if n % i == 0
            divisor_sum += i
            if i != n ÷ i  # Avoid double counting perfect squares
                divisor_sum += n ÷ i
            end
        end
    end

    return divisor_sum
end

"""
Find amicable chain starting from a number using Floyd's cycle detection.
Returns (chain_length, minimum_element) if valid chain found, (0, 0) otherwise.
"""
function find_amicable_chain(start_num::Int, limit::Int)
    # Use Floyd's cycle detection (tortoise and hare)
    slow = start_num
    fast = start_num

    # Phase 1: Detect if there's a cycle
    while true
        slow = sum_proper_divisors(slow)
        if slow > limit || slow <= 1
            return (0, 0)
        end

        fast = sum_proper_divisors(fast)
        if fast > limit || fast <= 1
            return (0, 0)
        end
        fast = sum_proper_divisors(fast)
        if fast > limit || fast <= 1
            return (0, 0)
        end

        if slow == fast
            break
        end
    end

    # Phase 2: Find the start of the cycle
    cycle_start = start_num
    while cycle_start != slow
        cycle_start = sum_proper_divisors(cycle_start)
        slow = sum_proper_divisors(slow)
    end

    # Phase 3: Measure cycle length and find minimum
    cycle_length = 1
    min_element = cycle_start
    current = sum_proper_divisors(cycle_start)

    while current != cycle_start
        cycle_length += 1
        if current < min_element
            min_element = current
        end
        current = sum_proper_divisors(current)
    end

    # Verify start_num is actually in the cycle
    current = cycle_start
    found_start = (current == start_num)

    for _ in 1:(cycle_length - 1)
        current = sum_proper_divisors(current)
        if current == start_num
            found_start = true
            break
        end
    end

    return found_start ? (cycle_length, min_element) : (0, 0)
end

function find_longest_amicable_chain(limit)
    longest_length = 0
    smallest_in_longest = 0
    checked = Set{Int}()

    for num in 2:limit
        if num in checked
            continue
        end

        chain_length, min_element = find_amicable_chain(num, limit)

        if chain_length > 0
            # Mark all numbers in this chain as checked
            current = num
            for _ in 1:chain_length
                push!(checked, current)
                current = sum_proper_divisors(current)
            end

            if chain_length > longest_length
                longest_length = chain_length
                smallest_in_longest = min_element
            end
        end
    end

    return (longest_length, smallest_in_longest)
end

function solve()
    _, smallest = find_longest_amicable_chain(1_000_000)
    return smallest
end

end # module
