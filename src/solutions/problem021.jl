"""
Project Euler Problem 21: Amicable Numbers

Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide
evenly into n). If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and
each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110;
therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.

## Solution approach

We iterate through all numbers from 2 to the limit-1 and for each number a:
1. Calculate b = sum of proper divisors of a
2. Check if a ≠ b and b < limit and sum of proper divisors of b equals a
3. If so, a is an amicable number
4. Sum all amicable numbers found

## Complexity analysis

Time complexity: O(n × √d)
- We iterate through n numbers up to the limit
- For each number, we find its divisors which takes O(√d) time
- We also need to find divisors of the computed sum, adding another O(√d) operation

Space complexity: O(k)
- We store the amicable numbers in an array, where k is the number of amicable numbers found
"""
module Problem021

using ProjectEulerSolutions.Utils.Divisors: get_divisors

"""
    find_amicable_numbers(limit)

Find all amicable numbers under the given limit.
An amicable number a forms a pair with b where the sum of proper divisors of a equals b
and the sum of proper divisors of b equals a, with a ≠ b.
"""
function find_amicable_numbers(limit)
    amicable_numbers = Int[]

    for a in 2:(limit - 1)
        b = sum(get_divisors(a)) - a
        if a != b && b < limit && sum(get_divisors(b)) - b == a
            push!(amicable_numbers, a)
        end
    end

    return amicable_numbers
end

"""
    sum_of_amicable_numbers(limit)

Calculate the sum of all amicable numbers under the given limit.
"""
function sum_of_amicable_numbers(limit)
    return sum(find_amicable_numbers(limit))
end

function solve()
    return sum_of_amicable_numbers(10000)
end

end # module
