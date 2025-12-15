"""
Project Euler Problem 12: Highly Divisible Triangular Number

Problem description: https://projecteuler.net/problem=12
Solution description: https://aliramadhan.me/blog/project-euler/problem-0012/
"""
module Problem0012

using ProjectEulerSolutions.Utils.Divisors: divisors
using ProjectEulerSolutions.Utils.Sequences: triangle_number

function find_first_triangle_with_divisors(min_divisors)
    n = 1

    while true
        if n % 2 == 0
            # n is even, T(n) = (n/2)*(n+1)
            a = n ÷ 2
            b = n + 1
        else
            # n is odd, T(n) = n*(n+1)/2
            a = n
            b = (n + 1) ÷ 2
        end

        num_divisors = length(divisors(a)) * length(divisors(b))

        if num_divisors > min_divisors
            return n, triangle_number(n)
        end

        n += 1
    end
end

function solve()
    _, triangle_number = find_first_triangle_with_divisors(500)
    return triangle_number
end

end # module
