"""
Project Euler Bonus Problem 18i: Matrix Solution (Optimized)

Optimization:
We use `StaticArrays.SMatrix` instead of standard `Matrix`.
Standard Julia arrays are heap-allocated. Creating millions of them (one per multiplication
per prime) causes massive Garbage Collection overhead. `SMatrix` is stack-allocated and
immutable, making matrix operations essentially zero-cost abstractions over 9 registers.
"""
module Bonus18i

using StaticArrays
using ProjectEulerSolutions.Utils.Primes

# -------------------------------
# 3x3 Modular Matrix Operations (Stack Allocated)
# -------------------------------

# Perform A * B mod p
# The compiler will fully unroll these loops.
# We use MMatrix (Mutable Static Array) for accumulation, then convert to SMatrix.
@inline function mat_mul_mod(A::SMatrix{3,3,Int}, B::SMatrix{3,3,Int}, p::Int)
    C = MMatrix{3,3,Int}(undef)
    @inbounds for j in 1:3
        for i in 1:3
            s = 0
            for k in 1:3
                s += A[i,k] * B[k,j]
            end
            C[i,j] = s % p
        end
    end
    return SMatrix(C)
end

# Binary exponentiation
function mat_pow_mod(A::SMatrix{3,3,Int}, exp::Int, p::Int)
    # Identity matrix
    result = @SMatrix [1 0 0; 0 1 0; 0 0 1]
    base = A

    while exp > 0
        if (exp & 1) == 1
            result = mat_mul_mod(result, base, p)
        end
        exp >>= 1
        if exp > 0
            base = mat_mul_mod(base, base, p)
        end
    end
    return result
end

# Determinant of 3x3 matrix modulo p
@inline function det3_mod(M::SMatrix{3,3,Int}, p::Int)::Int
    # Rule of Sarrus
    @inbounds begin
        a, b, c = M[1,1], M[1,2], M[1,3]
        d, e, f = M[2,1], M[2,2], M[2,3]
        g, h, i = M[3,1], M[3,2], M[3,3]
    end

    term1 = (a * (mod(e*i - f*h, p))) % p
    term2 = (b * (mod(d*i - f*g, p))) % p
    term3 = (c * (mod(d*h - e*g, p))) % p

    return mod(term1 - term2 + term3, p)
end

# -------------------------------
# Core Logic
# -------------------------------

function R_mod_p(p::Int)::Int
    if p <= 3
        return 0
    end

    # Companion Matrix M for t^3 - 3t + 4
    # Constructed using the @SMatrix macro for stack allocation
    M = @SMatrix [0  0 -4;
                  1  0  3;
                  0  1  0]

    # Compute M^p
    Mp = mat_pow_mod(M, p, p)

    # Compute Y = M^p - M
    # SMatrix supports element-wise subtraction naturally, but we need modulo.
    # Since Mp and M are small positive integers < p, simple subtraction is safe
    # if we fix the modulo afterwards, or we can just broadcast.
    # However, (Mp - M) might produce negatives, so we use a loop or map for safety.
    Y = map((a, b) -> mod(a - b, p), Mp, M)

    # R(p) is -det(Y)
    D = det3_mod(Y, p)
    return mod(-D, p)
end

function sum_R_mod_p(low, high)
    primality_test = MillerRabin(high)
    return _sum_R_mod_p_inner(low, high, primality_test)
end

# Function barrier: Julia specializes this on the concrete type of primality_test
function _sum_R_mod_p_inner(low, high, primality_test::MillerRabin{W}) where W
    total_sum = 0
    for n in low:high
        if is_prime(n, primality_test)
            total_sum += R_mod_p(n)
        end
    end
    return total_sum
end


function solve()
    lo = 1_000_000_000
    hi = 1_100_000_000
    return sum_R_mod_p(lo, hi)
end

end # module
