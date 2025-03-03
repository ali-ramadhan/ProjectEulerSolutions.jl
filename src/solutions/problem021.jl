"""
Project Euler Problem 21: Amicable Numbers

Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284.
The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
"""
module Problem021

"""
    sum_of_proper_divisors(n)

Calculate the sum of all proper divisors of n (numbers less than n which divide evenly into n).
Uses an optimized approach by only checking up to the square root.
"""
function sum_of_proper_divisors(n)
    # Special case: 1 has no proper divisors
    n == 1 && return 0

    # Start with 1 as it's always a proper divisor for n > 1
    sum = 1

    for i in 2:isqrt(n)
        if n % i == 0
            sum += i
            if i^2 != n
                sum += n ÷ i
            end
        end
    end

    return sum
end

"""
    find_amicable_numbers(limit)

Find all amicable numbers under the given limit.
An amicable number a forms a pair with b where the sum of proper divisors of a equals b
and the sum of proper divisors of b equals a, with a ≠ b.
"""
function find_amicable_numbers(limit)
    amicable_numbers = Int[]

    for a in 2:limit-1
        b = sum_of_proper_divisors(a)
        if a != b && b < limit && sum_of_proper_divisors(b) == a
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
