"""
Project Euler Problem 26: Reciprocal Cycles

A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

1/2 = 0.5
1/3 = 0.(3)
1/4 = 0.25
1/5 = 0.2
1/6 = 0.1(6)
1/7 = 0.(142857)
1/8 = 0.125
1/9 = 0.(1)
1/10 = 0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.
"""
module Problem026

"""
    cycle_length(d)

Calculate the length of the recurring cycle in the decimal expansion of 1/d.
Returns 0 for terminating decimals.

A decimal expansion terminates only when the denominator's prime factorization contains just 2s and 5s (factors of 10).
For other denominators, the decimal expansion will have a recurring cycle.
Factors of 2 and 5 in the denominator don't affect the cycle length, but may push the recurring portion further right.

First, we remove all factors of 2 and 5 from the denominator, as they don't contribute to the cycle.
Then we simulate long division and track the remainders we encounter.
When we see a remainder we've seen before, we've found a cycle.
The cycle length is the difference between the current position and the position where we first saw that remainder.

By tracking the position of each remainder in a dictionary, we can efficiently detect cycles.
This approach is much faster than actually generating the decimal expansion.
"""
function cycle_length(d)
    d_reduced = d

    while d_reduced % 2 == 0
        d_reduced ÷= 2
    end

    while d_reduced % 5 == 0
        d_reduced ÷= 5
    end

    # There's no recurring cycle
    if d_reduced == 1
        return 0
    end

    # Find the cycle length by simulating long division
    # and tracking remainders
    remainder = 1
    remainder_position = Dict{Int, Int}()
    position = 0

    while true
        remainder = (remainder * 10) % d_reduced
        position += 1

        if remainder == 0
            # The decimal expansion terminates
            return 0
        elseif haskey(remainder_position, remainder)
            # Cycle detected
            return position - remainder_position[remainder]
        else
            remainder_position[remainder] = position
        end
    end
end

"""
    find_longest_cycle(limit)

Find the value of d < limit for which 1/d has the longest recurring cycle.
Returns the denominator with the longest cycle.
"""
function find_longest_cycle(limit)
    max_length = 0
    max_d = 0

    for d in 2:(limit-1)
        length = cycle_length(d)
        if length > max_length
            max_length = length
            max_d = d
        end
    end

    return max_d
end

function solve()
    return find_longest_cycle(1000)
end

end # module
