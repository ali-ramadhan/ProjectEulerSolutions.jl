"""
Project Euler Bonus Problem 18i

Problem description: https://projecteuler.net/problem=18i
Solution description: https://aliramadhan.me/blog/project-euler/bonus-18i/
"""
module Bonus18i

using StaticArrays
using ProjectEulerSolutions.Utils.Primes

export sum_R_mod_p, solve

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

function mat_pow_mod(A::SMatrix{3,3,Int}, exp::Int, p::Int)
    result = @SMatrix [1 0 0; 0 1 0; 0 0 1] # Identity matrix
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


@inline function det3_mod(M::SMatrix{3,3,Int}, p::Int)
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

function R_mod_p(p)
    if p <= 3
        return 0
    end

    M = @SMatrix [0  0 -4;
                  1  0  3;
                  0  1  0]

    Mp = mat_pow_mod(M, p, p)

    # Compute Y = M^p - M by applying mod(a - b, p) to every pair of elements.
    Y = map((a, b) -> mod(a - b, p), Mp, M)

    D = det3_mod(Y, p)
    return mod(-D, p)
end


function sum_R_mod_p(low, high)
    primality_test = MillerRabin(high)
    return _sum_R_mod_p_inner(low, high, primality_test)
end

function _sum_R_mod_p_inner(low, high, primality_test::MillerRabin{W}) where W
    num_chunks = Threads.nthreads()

    if num_chunks == 1
        total_sum = 0
        for n in low:high
            if is_prime(n, primality_test)
                total_sum += R_mod_p(n)
            end
        end
        return total_sum
    end

    chunk_size = cld(high - low + 1, num_chunks)

    tasks = map(1:num_chunks) do i
        chunk_start = low + (i - 1) * chunk_size
        chunk_end = min(chunk_start + chunk_size - 1, high)
        Threads.@spawn begin
            local_sum = 0
            for n in chunk_start:chunk_end
                if is_prime(n, primality_test)
                    local_sum += R_mod_p(n)
                end
            end
            return local_sum
        end
    end

    return sum(fetch, tasks)
end

function solve()
    lo = 1_000_000_000
    hi = 1_100_000_000
    return sum_R_mod_p(lo, hi)
end

end # module
