"""
Project Euler Problem 21: Amicable Numbers

Problem description: https://projecteuler.net/problem=21
Solution description: https://aliramadhan.me/blog/project-euler/problem-0021/
"""
module Problem0021

using ProjectEulerSolutions.Utils.Divisors: is_amicable

function sum_of_amicable_numbers(limit)
    total = 0
    for a in 2:(limit - 1)
        if is_amicable(a)
            total += a
        end
    end
    return total
end

function solve()
    return sum_of_amicable_numbers(10000)
end

end # module
