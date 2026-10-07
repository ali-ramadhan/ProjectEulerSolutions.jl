"""
Project Euler Problem 5: Smallest Multiple

Problem description: https://projecteuler.net/problem=5
Solution description: https://aliramadhan.me/blog/project-euler/problem-0005/
"""
module Problem0005

export smallest_multiple, smallest_multiple_primorial, solve

using ProjectEulerSolutions.Utils.Primes: primorial, sieve_of_eratosthenes

function smallest_multiple(n)
    result = 1
    for i in 2:n
        result = lcm(result, i)
    end
    return result
end

# n# has one copy of every prime p ≤ n. Primes with p² ≤ n need more copies: lcm(1, ..., n) has p^e
# with p^e ≤ n < p^(e+1), so p contributes an extra p^(e-1), the largest power of p that is ≤ n ÷ p.
# The extras are small, so multiply them together first and into the huge n# only once.
function smallest_multiple_primorial(n)
    extra = big(1)
    for p in sieve_of_eratosthenes(isqrt(n))
        q = 1
        while q <= n ÷ p ÷ p
            q *= p
        end
        extra *= q
    end
    return primorial(n) * extra
end

function solve()
    return smallest_multiple(20)
end

end # module
