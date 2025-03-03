"""
Project Euler Problem 5: Smallest Multiple

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
"""
module Problem005

"""
    smallest_multiple(n)

Find the smallest positive number that is evenly divisible by all numbers from 1 to n.
"""
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
