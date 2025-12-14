"""
Project Euler Problem 1: Multiples of 3 or 5

Problem description: https://projecteuler.net/problem=1
Solution description: https://aliramadhan.me/blog/project-euler/problem-0001/
"""
module Problem0001

function sum_multiples(n, limit)
    if n >= limit
        return 0
    end
    k = div(limit - 1, n)  # Number of multiples of n below limit
    return n * k * (k + 1) ÷ 2
end

#####
##### Two factors
#####

function sum_multiples_two_generator(a, b, L)
    return sum(n for n in 1:L-1 if n % a == 0 || n % b == 0)
end

function sum_multiples_two_ie(a, b, limit)
        return sum_multiples(a, limit) +
               sum_multiples(b, limit) -
               sum_multiples(lcm(a, b), limit)
end

function solve()
    return sum_multiples_two_ie(3, 5, 1000)
end

#####
##### Three factors
#####

function sum_multiples_three_generator(a, b, c, L)
    return sum(n for n in 1:L-1 if n % a == 0 || n % b == 0 || n % c == 0)
end

function sum_multiples_three_ie(a, b, c, L)
    return sum_multiples(a, L) +
           sum_multiples(b, L) +
           sum_multiples(c, L) -
           sum_multiples(lcm(a, b), L) -
           sum_multiples(lcm(a, c), L) -
           sum_multiples(lcm(b, c), L) +
           sum_multiples(lcm(a, b, c), L)
end

end # module
