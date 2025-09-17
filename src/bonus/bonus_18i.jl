"""
Project Euler Bonus Problem 18i: Remainder product over a cubic

Let R(p) be the remainder when the product ∏_{x=0}^{p-1} (x^3 − 3x + 4) is divided by p.
For example, R(11) = 0 and R(29) = 13.

Find the sum of R(p) over all primes p between 1,000,000,000 and 1,100,000,000.

## Solution approach

We reduce the whole product to the determinant of a tiny 3×3 matrix using two simple facts
about finite fields and basic linear algebra (no Galois theory needed):

- Over 𝔽_p we have the identity X^p − X = ∏_{x∈𝔽_p} (X − x). Evaluating at any element α gives
  ∏_{x∈𝔽_p} (α − x) = α^p − α.
- If f(t) = t^3 − 3t + 4 has roots α₁, α₂, α₃ (in some extension field), then
  f(x) = ∏_{i=1}^3 (x − αᵢ), hence
  ∏_{x∈𝔽_p} f(x) = ∏_{i=1}^3 ∏_{x∈𝔽_p} (x − αᵢ) = (−1)^p ∏_{i=1}^3 (αᵢ^p − αᵢ).

Now view expressions a + bt + ct² modulo f(t)=0 (i.e., using t³ = 3t − 4). This forms a
3‑dimensional vector space over 𝔽_p with basis {1, t, t²}. The element y := t^p − t acts on
this space by multiplication, which is a 3×3 linear map. Its eigenvalues are exactly the
three numbers (αᵢ^p − αᵢ), so their product equals det(M_y). Therefore, for odd p,

R(p) ≡ ∏_{x∈𝔽_p} f(x) ≡ − det(M_{t^p − t}) (mod p).

Practical computation:
1) Represent any element as (c₀, c₁, c₂) for c₀ + c₁ t + c₂ t².
2) Multiply two such triples and reduce using t³ = 3t − 4 (constant work).
3) Compute t^p via binary exponentiation (O(log p)).
4) Form y = t^p − t and build the columns y·1, y·t, y·t² to get a 3×3 matrix.
5) R(p) is the negative of its determinant modulo p. If y=0, then R(p)=0.

Useful check: the discriminant of f is Δ = −324, and whenever R(p) ≠ 0 we have
R(p)^2 ≡ Δ (mod p).

Finally, iterate over the primes p in the range using a deterministic Miller–Rabin test
for 32‑bit integers, and sum R(p). Each prime costs only O(log p) time.

## Complexity analysis

Time complexity: about O(π(N) · log p)
- Per prime: O(log p) algebra multiplications on 3-term polynomials (constant-time ops)
- π(1.1e9) − π(1e9) ≈ 4.3 million primes; practically completes in seconds to minutes

Space complexity: O(1)
- Only a handful of integers per prime are stored
"""
module Bonus18i

export R_mod_p, sum_R_in_range, solve

# -------------------------------
# Finite-field cubic algebra ops
# -------------------------------

@inline function poly_mul_mod(a0::Int, a1::Int, a2::Int,
                              b0::Int, b1::Int, b2::Int, p::Int)
    # Multiply (a0 + a1 t + a2 t^2)*(b0 + b1 t + b2 t^2) in 𝔽_p[t]/(t^3 − 3t + 4)
    # First multiply in the polynomial ring up to degree 4
    c0 = (a0*b0) % p
    c1 = (a0*b1 + a1*b0) % p
    c2 = (a0*b2 + a1*b1 + a2*b0) % p
    c3 = (a1*b2 + a2*b1) % p
    c4 = (a2*b2) % p
    # Reduce using t^3 ≡ 3t − 4 and hence t^4 ≡ 3t^2 − 4t
    c0 = (c0 - 4*c3) % p
    c1 = (c1 + 3*c3) % p
    c1 = (c1 - 4*c4) % p
    c2 = (c2 + 3*c4) % p
    return (c0 % p, c1 % p, c2 % p)
end

@inline function poly_pow_t_mod_p(p::Int)
    # Compute t^p in K = 𝔽_p[t]/(t^3 − 3t + 4) via binary exponentiation
    r0, r1, r2 = 1 % p, 0 % p, 0 % p    # result = 1
    b0, b1, b2 = 0 % p, 1 % p, 0 % p    # base = t
    e = p
    while e > 0
        if (e & 1) == 1
            r0, r1, r2 = poly_mul_mod(r0, r1, r2, b0, b1, b2, p)
        end
        e >>= 1
        if e > 0
            b0, b1, b2 = poly_mul_mod(b0, b1, b2, b0, b1, b2, p)
        end
    end
    return (r0, r1, r2)
end

@inline function det3_mod(a::Int, b::Int, c::Int,
                          d::Int, e::Int, f::Int,
                          g::Int, h::Int, i::Int, p::Int)::Int
    D = (a % p) * ((e*i - f*h) % p) - (b % p) * ((d*i - f*g) % p) + (c % p) * ((d*h - e*g) % p)
    return Int(mod(D, p))
end

function R_mod_p(p::Int)::Int
    # Handle tiny primes explicitly
    if p <= 3
        return 0
    end
    # Compute y = t^p − t in K
    t0, t1, t2 = poly_pow_t_mod_p(p)
    y0 = t0 % p
    y1 = (t1 - 1) % p
    y2 = t2 % p
    # If y == 0 in K, then the norm is 0
    if y0 == 0 && y1 == 0 && y2 == 0
        return 0
    end
    # Build multiplication-by-y matrix columns: y*1, y*t, y*t^2
    c10, c11, c12 = y0, y1, y2
    c20, c21, c22 = poly_mul_mod(y0, y1, y2, 0, 1, 0, p)  # y*t
    c30, c31, c32 = poly_mul_mod(y0, y1, y2, 0, 0, 1, p)  # y*t^2
    # Norm = det of this matrix; product = (−1)^p * Norm = −Norm (p odd)
    N = det3_mod(c10, c20, c30, c11, c21, c31, c12, c22, c32, p)
    return mod(-N, p)
end

# ---------------------------------
# Deterministic 32-bit primality
# ---------------------------------

@inline function is_probable_prime_32(n::Int)::Bool
    if n < 2
        return false
    end
    if (n % 2) == 0
        return n == 2
    end
    # write n−1 = d·2^r with d odd
    d = n - 1
    r = 0
    while (d & 1) == 0
        d >>= 1
        r += 1
    end
    # Deterministic for 32-bit with bases {2,3,5,7,11}
    for a in (2, 3, 5, 7, 11)
        if a % n == 0
            continue
        end
        x = powermod(a % n, d, n)
        if x == 1 || x == n - 1
            continue
        end
        witness = true
        for _ in 1:(r - 1)
            x = (x * x) % n
            if x == n - 1
                witness = false
                break
            end
        end
        if witness
            return false
        end
    end
    return true
end

# ---------------------------------
# Range summation and solve()
# ---------------------------------

function sum_R_in_range(lo::Int, hi::Int)::Int128
    s = Int128(0)
    # Wheel-30 step pattern skips multiples of 2,3,5
    wheel = (1, 7, 11, 13, 17, 19, 23, 29)
    # Align start to nearest number ≡ 1 (mod 30)
    n = lo
    base = n - (n % 30)
    # iterate over 30-blocks
    while base <= hi
        for w in wheel
            x = base + w
            if x < lo || x > hi
                continue
            end
            if is_probable_prime_32(x)
                s += R_mod_p(x)
            end
        end
        base += 30
    end
    return s
end

function solve()
    # IMPORTANT: Keep this minimal – delegate to helper
    return sum_R_in_range(1_000_000_000, 1_100_000_000)
end

end # module
