"""
Project Euler Problem 70: Totient Permutation

Euler's totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers 
less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine 
and relatively prime to nine, φ(9)=6.
The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.

Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.

Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.
"""
module Problem070

"""
    sieve_of_eratosthenes(limit)

Generate all prime numbers up to the given limit using the Sieve of Eratosthenes algorithm.

Returns:
    Array{Int}: An array containing all primes less than or equal to the limit.
"""
function sieve_of_eratosthenes(limit)
    is_prime = fill(true, limit)
    is_prime[1] = false
    
    for i in 2:isqrt(limit)
        if is_prime[i]
            for j in i^2:i:limit
                is_prime[j] = false
            end
        end
    end
    
    return [i for i in 2:limit if is_prime[i]]
end

"""
    are_permutations(a, b)

Check if two numbers are permutations of each other (have the same digits).
"""
function are_permutations(a, b)
    return sort(collect(string(a))) == sort(collect(string(b)))
end

"""
    find_totient_permutation(limit)

Find the value of n, 1 < n < limit, for which φ(n) is a permutation of n 
and the ratio n/φ(n) produces a minimum.

Strategy: Focus on semiprimes (products of two primes) since they tend to have high 
totient values relative to n, which helps minimize n/φ(n).

For a semiprime n = p*q where p and q are distinct primes:
φ(n) = (p-1)*(q-1)

The ratio n/φ(n) = pq/((p-1)(q-1)) approaches 1 as p and q get larger.
"""
function find_totient_permutation(limit)
    min_ratio = Inf
    min_n = 0
    
    # Generate primes up to a suitable upper bound
    # We need primes such that their product is < limit
    sqrt_limit = isqrt(limit)
    prime_upper_bound = 2 * sqrt_limit
    
    primes = sieve_of_eratosthenes(prime_upper_bound)
    
    # Search for suitable pairs of primes
    for i in 1:length(primes)
        p = primes[i]
        max_q = limit ÷ p  # Ensure p*q < limit
        
        for j in i:length(primes)  # Start from i to avoid duplicates
            q = primes[j]
            
            if q > max_q
                break  # Skip remaining primes if they exceed max_q
            end
            
            n = p * q
            phi_n = (p - 1) * (q - 1)  # φ(n) for semiprime n = p*q
            
            if are_permutations(n, phi_n)
                ratio = n / phi_n
                
                if ratio < min_ratio
                    min_ratio = ratio
                    min_n = n
                end
            end
        end
    end
    
    return min_n
end

function solve()
    return find_totient_permutation(10^7)
end

end # module
