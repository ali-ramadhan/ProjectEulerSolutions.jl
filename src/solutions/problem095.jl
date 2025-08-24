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

using ProjectEulerSolutions.Utils.Divisors: get_divisors

function sum_proper_divisors(n)
    divisors = get_divisors(n)
    return sum(divisors) - n
end

function find_chain(start_num, limit)
    chain = Int[]
    current = start_num
    seen = Set{Int}()

    while current <= limit && !(current in seen)
        push!(chain, current)
        push!(seen, current)
        current = sum_proper_divisors(current)
    end

    # Check if we found a cycle that returns to the start
    if current == start_num && length(chain) > 1
        return chain
    else
        return Int[]  # No valid amicable chain
    end
end

function find_longest_amicable_chain(limit)
    longest_chain = Int[]
    checked = Set{Int}()

    for num in 2:limit
        if num in checked
            continue
        end

        chain = find_chain(num, limit)

        # Mark all numbers in this chain as checked
        for n in chain
            push!(checked, n)
        end

        if length(chain) > length(longest_chain)
            longest_chain = chain
        end
    end

    return longest_chain
end

function solve()
    longest_chain = find_longest_amicable_chain(1_000_000)
    return minimum(longest_chain)
end

end # module
