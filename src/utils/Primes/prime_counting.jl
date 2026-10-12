"""
    logarithmic_integral(x)

Compute the logarithmic integral li(x), Gauss's estimate of the number of primes up to x,

    li(x) = ∫₀ˣ dt / ln t

where the integral passes through the singularity at t = 1 as a Cauchy principal value. It is summed
from the series li(x) = γ + ln ln x + Σₖ (ln x)ᵏ / (k ⋅ k!), with γ the Euler–Mascheroni constant.
For x > 1 every term is positive, so there is no cancellation to lose precision to.

# Arguments
- `x`: Real number greater than 1

# Returns
- li(x) as a `Float64`

# Examples
```julia
logarithmic_integral(10)     # returns 6.16559950478729...
logarithmic_integral(10^6)   # returns 78627.5491594621... (there are 78498 primes up to 10⁶)
```
"""
function logarithmic_integral(x)
    x > 1 || throw(DomainError(x, "the series for li(x) needs x > 1"))
    L = log(Float64(x))
    total = Base.MathConstants.eulergamma + log(L)
    term = 1.0  # (ln x)ᵏ / k!
    k = 0
    while true
        k += 1
        term *= L / k
        total += term / k
        term / k < eps(total) && return total
    end
end

"""
    inverse_logarithmic_integral(y)

Solve li(x) = y for x with Newton's method. Since li(x) estimates the number of primes up to x,
li⁻¹(n) estimates the nth prime.

li is concave, so after its first step Newton's method climbs to the root from below, each step
smaller than the last, until rounding errors take over.

# Arguments
- `y`: Positive real number

# Returns
- li⁻¹(y) as a `Float64`

# Examples
```julia
inverse_logarithmic_integral(10_001)  # returns 104281.324506436... (the 10,001st prime is 104,743)
```
"""
function inverse_logarithmic_integral(y)
    y > 0 || throw(DomainError(y, "li⁻¹(y) is only computed for y > 0"))
    x = max(2.0, y * log(y))
    previous_step = Inf
    while true
        step = (y - logarithmic_integral(x)) * log(x)  # li′(x) = 1 / ln x
        abs(step) < abs(previous_step) || return x
        x += step
        previous_step = step
    end
end

"""
    prime_pi(x)

Count the primes less than or equal to x, the prime-counting function π(x), using Lucy_Hedgehog's
algorithm (https://projecteuler.net/thread=10;page=5#111677) in O(x^(3/4)) time and O(√x) memory.

It runs the sieve of Eratosthenes on counts instead of on numbers. S(v) starts as v - 1, the count
of 2, 3, ..., v. Sieving by a prime p removes the S(v ÷ p) - π(p - 1) numbers up to v whose
smallest prime factor is p, and once every prime up to √x has been sieved out, S(x) = π(x). The
sieve only ever needs S(v) at v = x ÷ k, which takes at most 2√x distinct values.

# Arguments
- `x`: Integer

# Returns
- The number of primes less than or equal to `x`

# Examples
```julia
prime_pi(10)     # returns 4 (2, 3, 5, 7)
prime_pi(10^9)   # returns 50847534
```
"""
function prime_pi(x::Integer)
    x < 2 && return 0
    r = isqrt(x)

    # S(v) for the small values v ≤ r is small[v] and for the large values v = x ÷ k it's large[k]
    small = [v - 1 for v in 1:r]
    large = [x ÷ k - 1 for k in 1:r]

    for p in 2:r
        small[p] == small[p - 1] && continue  # p isn't prime
        primes_below_p = small[p - 1]

        # Only v ≥ p² change. v ÷ p = x ÷ kp is a large value while kp ≤ r and a small one after.
        k_max = min(r, x ÷ (p * p))
        k_split = min(k_max, r ÷ p)
        for k in 1:k_split
            large[k] -= large[k * p] - primes_below_p
        end
        for k in (k_split + 1):k_max
            large[k] -= small[x ÷ (k * p)] - primes_below_p
        end
        for v in r:-1:(p * p)
            small[v] -= small[v ÷ p] - primes_below_p
        end
    end

    return large[1]
end
