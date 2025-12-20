"""
    MillerRabin()
    MillerRabin(max_n::Integer)

Deterministic Miller-Rabin primality test algorithm.

# Usage modes

**Auto-select witnesses** (default): Automatically selects the minimal witness set
based on `n` at each call. Tiny overhead from threshold lookup.

```julia
is_prime(1_000_000_007, MillerRabin())  # auto-selects witnesses
```

**Pre-specified maximum**: When you know the maximum `n` you'll test, pass it to
the constructor to precompute the witness set. This provides type stability and
avoids threshold lookup in hot loops.

```julia
mr = MillerRabin(10^12)  # precomputes witnesses for n < 10^12
for n in candidates
    is_prime(n, mr)  # no lookup, type-stable
end
```

# Deterministic bounds

Uses proven minimal witness sets from Pomerance, Selfridge, Wagstaff (1980),
Jaeschke (1993), and Feitsma & Galway (2010). The test is 100% accurate (not
probabilistic) for all n < 2^64.
"""
struct MillerRabin{W} <: PrimalityTest
    witnesses::W
end

MillerRabin() = MillerRabin(nothing)

function MillerRabin(max_n::Integer)
    MillerRabin(get_witnesses(max_n))
end

# Deterministic witness sets for Miller-Rabin primality test.
# Each entry is (threshold, witnesses) where witnesses are sufficient for n < threshold.
# Sources: Pomerance, Selfridge, Wagstaff (1980); Jaeschke (1993); Feitsma & Galway (2010)
const MR_WITNESS_TABLE = (
    (2_047,                         (2,)),
    (1_373_653,                     (2, 3)),
    (9_080_191,                     (31, 73)),
    (25_326_001,                    (2, 3, 5)),
    (3_215_031_751,                 (2, 3, 5, 7)),
    (4_759_123_141,                 (2, 7, 61)),
    (1_122_004_669_633,             (2, 13, 23, 1662803)),
    (2_152_302_898_747,             (2, 3, 5, 7, 11)),
    (3_474_749_660_383,             (2, 3, 5, 7, 11, 13)),
    (341_550_071_728_321,           (2, 3, 5, 7, 11, 13, 17)),
    (3_825_123_056_546_413_051,     (2, 3, 5, 7, 11, 13, 17, 19, 23)),
    (typemax(UInt64),               (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37)),
)

"""
    get_witnesses(n)

Return the minimal deterministic witness set for Miller-Rabin testing of values up to `n`.
"""
function get_witnesses(n)
    for (threshold, witnesses) in MR_WITNESS_TABLE
        n < threshold && return witnesses
    end
    return MR_WITNESS_TABLE[end][2]
end

"""
    is_prime(n, ::MillerRabin{Nothing})

Determines if `n` is prime using the deterministic Miller-Rabin test with
auto-selected witnesses. Automatically selects the minimal witness set based on `n`.
"""
function is_prime(n, ::MillerRabin{Nothing})
    witnesses = get_witnesses(n)
    return _miller_rabin_test(n, witnesses)
end

"""
    is_prime(n, mr::MillerRabin{W})

Determines if `n` is prime using the deterministic Miller-Rabin test with
precomputed witnesses. Use `MillerRabin(max_n)` to create an instance with
optimal witnesses for values up to `max_n`.
"""
@inline function is_prime(n, mr::MillerRabin{W}) where W <: Tuple
    return _miller_rabin_test(n, mr.witnesses)
end

"""
    _miller_rabin_test(n, witnesses)

Core Miller-Rabin primality test. Returns true if `n` is prime.
This function is 100% accurate when using the appropriate witness set for `n`.
"""
@inline function _miller_rabin_test(n, witnesses::W) where W <: Tuple
    # Handle small edge cases efficiently
    if n < 2
        return false
    elseif n == 2 || n == 3
        return true
    elseif iseven(n)
        return false
    end

    # Decompose n - 1 into d * 2^s
    # We want to find odd d and integer s such that n-1 = d * 2^s
    d = n - 1
    s = trailing_zeros(d)  # Built-in fast bit counting
    d >>= s

    for a in witnesses
        # If the base is >= n, skip it (handles small n with large witnesses)
        a >= n && continue

        if _is_composite_witness(n, a, d, s)
            return false
        end
    end

    return true
end

"""
    _is_composite_witness(n, a, d, s)

Checks if 'a' is a witness to the compositeness of 'n'.
Returns true if 'n' is definitely composite.
Returns false if 'n' is probably prime (to base 'a').
"""
@inline function _is_composite_witness(n, a, d, s)
    # Compute x = a^d mod n
    # We use built-in powermod which handles Int128 promotion internally
    # to avoid overflow during intermediate calculations.
    x = powermod(a, d, n)

    # If x = 1 or x = n-1, then 'n' passes the test for this base 'a'
    if x == 1 || x == n - 1
        return false
    end

    # Square x repeatedly up to s-1 times
    for _ in 1:(s - 1)
        # x = x^2 mod n
        # We manually promote to Int128 to ensure (x*x) doesn't overflow Int64
        x = (Int128(x) * x) % n

        # If we hit n-1, 'n' passes the test for this base
        if x == n - 1
            return false
        end
    end

    # If we finished the loop and never saw n-1 (and didn't start at 1),
    # then 'a' is a witness that 'n' is composite.
    return true
end
