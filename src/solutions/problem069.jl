"""
Project Euler Problem 69: Totient Maximum

Euler's totient function, φ(n), is defined as the number of positive integers not exceeding n 
which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than or 
equal to nine and relatively prime to nine, φ(9) = 6.

It can be seen that n = 6 produces a maximum n/φ(n) for n ≤ 10.

Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.
"""
module Problem069

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    find_max_totient_ratio(limit)

Find the value of n ≤ limit for which n/φ(n) is a maximum, where φ(n) is Euler's totient function.

Mathematical insight:
1. For any number n with prime factorization n = p₁×p₂×...×pₖ, the totient function is:
   φ(n) = n × ∏(1-1/p) for each distinct prime p dividing n

2. The ratio n/φ(n) can be rewritten as:
   n/φ(n) = 1 / ∏(1-1/p) = ∏(p/(p-1))

3. Each prime factor p contributes a factor of p/(p-1) to this ratio:
   - p=2 contributes 2/1 = 2.0
   - p=3 contributes 3/2 = 1.5
   - p=5 contributes 5/4 = 1.25
   - p=7 contributes 7/6 ≈ 1.167
   - ...and so on (getting closer to 1 as p increases)

4. To maximize this ratio while keeping n ≤ limit:
   - We want to include as many distinct prime factors as possible
   - Smaller primes contribute larger factors to the product
   - The optimal strategy is to multiply consecutive primes (2×3×5×7×...) 
     until we reach the limit
"""
function find_max_totient_ratio(limit)
    n = 1
    p = 2
    
    # Keep multiplying by consecutive primes until we exceed the limit
    while true
        next_n = n * p
        if next_n > limit
            break
        end
        
        n = next_n
        
        p += 1
        while !is_prime(p)
            p += 1
        end
    end
    
    return n
end

function solve()
    return find_max_totient_ratio(1_000_000)
end

end # module
