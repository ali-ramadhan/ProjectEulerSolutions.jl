"""
Project Euler Problem 7: 10001st Prime

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10,001st prime number?
"""
module Problem007

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    find_nth_prime(n)

Find the nth prime number.
"""
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
    return find_nth_prime(10001)
end

end # module
