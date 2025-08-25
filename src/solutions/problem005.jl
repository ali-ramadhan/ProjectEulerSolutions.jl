"""
Project Euler Problem 5: Smallest Multiple

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without
any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from
1 to 20?

## Solution approach

The smallest positive number divisible by all numbers from 1 to n is the least common
multiple (LCM) of those numbers. We can use Julia's built-in `lcm` function iteratively
to compute the LCM of all numbers from 1 to n.

## Complexity analysis

Time complexity: O(n log(max_value))
- We perform n-1 LCM computations, each requiring GCD calculation which is O(log(max_value))
  where max_value is the largest number involved.

Space complexity: O(1)
- Only uses a constant amount of extra space for the result variable.
"""
module Problem005

function smallest_multiple(n)
    result = 1
    for i in 2:n
        result = lcm(result, i)
    end
    return result
end

function solve()
    return smallest_multiple(20)
end

end # module
