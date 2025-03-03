"""
Project Euler Problem 3: Largest Prime Factor

The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143?
"""
module Problem003

"""
    largest_prime_factor(n)

Find the largest prime factor of the integer n.
"""
function largest_prime_factor(n)
    largest_factor = 1
    
    factor = 2
    while factor^2 <= n
        if n % factor == 0
            largest_factor = factor
            n = n ÷ factor
        else
            factor += 1
        end
    end
    
    # If n > 1, it's a prime factor
    if n > 1
        largest_factor = n
    end
    
    return largest_factor
end

function solve()
    return largest_prime_factor(600851475143)
end

end # module
