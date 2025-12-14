"""
Project Euler Problem 21: Amicable Numbers

Problem description: https://projecteuler.net/problem=21
Solution description: https://aliramadhan.me/blog/project-euler/problem-0021/
"""
module Problem0021

using ProjectEulerSolutions.Utils.Divisors: get_divisors

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

function sum_of_amicable_numbers(limit)
    return sum(find_amicable_numbers(limit))
end

function solve()
    return sum_of_amicable_numbers(10000)
end

end # module
