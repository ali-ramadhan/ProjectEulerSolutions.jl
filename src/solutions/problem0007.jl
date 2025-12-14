"""
Project Euler Problem 7: 10001st Prime

Problem description: https://projecteuler.net/problem=7
Solution description: https://aliramadhan.me/blog/project-euler/problem-0007/
"""
module Problem0007

using ProjectEulerSolutions.Utils.Primes: is_prime

function find_nth_prime(n)
    count = 0
    num = 1

    while count < n
        num += 1
        if is_prime(num)
            count += 1
        end
    end

    return num
end

function solve()
    result = find_nth_prime(10001)
    @info "The 10,001st prime is $result"
    return result
end

end # module
