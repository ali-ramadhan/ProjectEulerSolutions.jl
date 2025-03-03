"""
Project Euler Problem 7: 10001st Prime

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.

What is the 10,001st prime number?
"""
module Problem007

"""
    is_prime(n)

Check if n is prime using trial division with 6k±1 optimization.
Only checks divisors up to sqrt(n) and filters common cases.
"""
function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true
    
    if n % 2 == 0 || n % 3 == 0
        return false
    end
    
    # Check divisibility by numbers of form 6k±1 up to sqrt(n)
    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end
    
    return true
end

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
