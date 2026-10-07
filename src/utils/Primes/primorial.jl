"""
    primorial(n)

Compute the primorial n#, the product of all primes less than or equal to n.

This calls GMP's `mpz_primorial_ui` (Julia's `BigInt` is GMP's `mpz_t`), which sieves the primes
up to n, packs as many as fit into each machine word, and multiplies the words together by binary
splitting. That makes it close to linear in the size of the result, unlike multiplying the primes
into a running product one at a time, which is quadratic.

# Arguments
- `n`: Non-negative integer that fits in a `Culong`

# Returns
- n# as a `BigInt` (1 for n < 2)

# Examples
```julia
primorial(10)  # returns 210 (2 * 3 * 5 * 7)
primorial(20)  # returns 9699690
```
"""
function primorial(n::Integer)
    n < 0 && throw(DomainError(n, "primorial is only defined for non-negative n"))
    result = BigInt()
    ccall((:__gmpz_primorial_ui, :libgmp), Cvoid, (Ref{BigInt}, Culong), result, Culong(n))
    return result
end
