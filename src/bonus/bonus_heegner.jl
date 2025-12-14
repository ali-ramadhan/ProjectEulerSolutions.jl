"""
Project Euler Bonus Problem: Heegner

Problem description: https://projecteuler.net/problem=heegner
Solution description: https://aliramadhan.me/blog/project-euler/bonus-heegner/
"""
module BonusHeegner

using Printf

function distance_to_nearest_integer(x)
    return abs(x - round(x))
end

function required_precision_bits(limit; fractional_digits=32)
    val = cosh(big(π) * sqrt(big(limit)))
    integer_digits = ceil(Int, log10(val))
    total_digits = integer_digits + fractional_digits
    return ceil(Int, total_digits * log2(10))
end

function find_closest_cos_to_integer(limit)
    precision_bits = required_precision_bits(limit)
    @info "Using $precision_bits bits of precision for limit=$limit"

    setprecision(BigFloat, precision_bits) do
        results = Vector{Tuple{Int,BigFloat,BigFloat}}()  # (n, value, distance)

        for n in -limit:limit
            n == 0 && continue
            isqrt(abs(n))^2 == abs(n) && continue

            if n > 0
                val = cos(big(π) * sqrt(big(n)))
            else
                val = cosh(big(π) * sqrt(big(-n)))
            end

            dist = distance_to_nearest_integer(val)

            push!(results, (n, val, dist))
        end

        # Sort by distance
        sort!(results, by=x -> x[3])

        # Log the top 10
        @info "Top 10 values of n where cos(π√n) is closest to an integer:"
        for i in 1:min(10, length(results))
            n, val, dist = results[i]
            @info @sprintf("%d: n = %d, value ≈ %.10e, distance ≈ %.10e", i, n, val, dist)
        end

        return results[1][1]
    end
end

function solve()
    return find_closest_cos_to_integer(1000)
end

end # module
