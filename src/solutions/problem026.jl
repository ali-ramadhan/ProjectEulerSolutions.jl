"""
Project Euler Problem 26: Reciprocal Cycles

A unit fraction contains 1 in the numerator. The decimal representation of the unit
fractions with denominators 2 to 10 are given:

1/2 = 0.5
1/3 = 0.(3)
1/4 = 0.25
1/5 = 0.2
1/6 = 0.1(6)
1/7 = 0.(142857)
1/8 = 0.125
1/9 = 0.(1)
1/10 = 0.1

Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7
has a 6-digit recurring cycle.

Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal
fraction part.

## Solution approach

We simulate long division to find the cycle length in the decimal expansion of 1/d:
1. Remove factors of 2 and 5 from d (these only affect termination, not cycle length)
2. Track remainders during long division using a dictionary
3. When we encounter a remainder we've seen before, we've found the cycle
4. The cycle length is the difference between current and previous positions of that
   remainder

This method is much more efficient than generating the actual decimal expansion.

## Complexity analysis

Time complexity: O(n × d)
- We check each denominator d from 2 to n-1 (n ≈ 1000)
- For each d, finding the cycle length takes at most O(d) time (bounded by the number of
  possible remainders)

Space complexity: O(d)
- We store a dictionary of remainders and their positions, with at most d entries
"""
module Problem026

"""
    cycle_length(d)

Calculate the length of the recurring cycle in the decimal expansion of 1/d.
Returns 0 for terminating decimals.
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
"""
function find_longest_cycle(limit)
    max_length = 0
    max_d = 0

    for d in 2:(limit - 1)
        length = cycle_length(d)
        if length > max_length
            max_length = length
            max_d = d
        end
    end

    return max_d
end

function solve()
    result = find_longest_cycle(1000)
    max_length = cycle_length(result)
    @info "1/$result has the longest recurring cycle with $max_length digits"
    return result
end

end # module
