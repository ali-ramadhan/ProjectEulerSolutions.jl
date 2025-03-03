"""
Project Euler Problem 10: Summation of Primes

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.
"""
module Problem010

"""
    sum_of_primes_below(limit)

Calculate the sum of all prime numbers below limit using the Sieve of Eratosthenes.
This algorithm efficiently identifies primes by eliminating multiples in O(n log log n) time.
"""
function sum_of_primes_below(limit)
    is_prime = fill(true, limit)
    is_prime[1] = false
    
    # Apply the Sieve of Eratosthenes
    for i in 2:isqrt(limit)
        if is_prime[i]
            # Mark all multiples of i as non-prime
            for j in i^2:i:limit
                is_prime[j] = false
            end
        end
    end
    
    # Sum up all prime numbers
    sum = 0
    for i in 1:limit-1
        if is_prime[i]
            sum += i
        end
    end
    
    return sum
end

function solve()
    return sum_of_primes_below(2_000_000)
end

end # module
