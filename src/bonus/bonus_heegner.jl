"""
Project Euler Bonus Problem: Heegner

Among all non-square integers n with absolute value not exceeding 10³, find the value of n
such that cos(π√n) is closest to an integer.

## Solution approach

For each non-square integer n with |n| ≤ 1000:
- If n > 0: compute cos(π√n), which is bounded by [-1, 1]
- If n < 0: compute cosh(π√|n|), which grows exponentially

We use BigFloat with dynamically calculated precision because:
- cosh(π√n) ≈ e^(π√n)/2 grows exponentially, requiring many digits for large |n|
- Float64 only has ~16 significant digits, completely inadequate
- Precision is calculated as: ceil(π√limit / ln(10)) + 32 fractional digits, converted to bits
- For limit=1000: ~43 integer digits + 32 fractional = 250 bits

## Complexity analysis

Time complexity: O(n)
- Single pass through all integers from -1000 to 1000
- Constant time BigFloat operations for each integer

Space complexity: O(n)
- Storing all (n, value, distance) tuples to find and display the top 10

## Mathematical background

For negative integers n, we use the identity cos(iθ) = cosh(θ), so:
cos(π√n) = cos(iπ√|n|) = cosh(π√|n|)

Heegner numbers are the negative square-free integers d such that the imaginary quadratic
field Q(√d) has class number 1. The complete list is: -1, -2, -3, -7, -11, -19, -43, -67,
-163.

The largest Heegner number is -163, which is famous for Ramanujan's near-integer:
e^(π√163) ≈ 262537412640768743.99999999999925...

This makes cosh(π√163) ≈ e^(π√163)/2 ≈ 1.3127×10¹⁷ extremely close to an integer,
with distance ≈ 3.75×10⁻¹³.

## Key insights

Negative integers dominate because cosh(π√|n|) can achieve near-integer values through
the special arithmetic properties of quadratic fields. For positive n, cos(π√n) is
bounded by [-1, 1], limiting how close it can get to an integer.
"""
module BonusHeegner

using Printf

"""
    distance_to_nearest_integer(x)

Compute the distance from x to the nearest integer.
"""
function distance_to_nearest_integer(x)
    return abs(x - round(x))
end

"""
    required_precision_bits(limit; fractional_digits=32)

Calculate the BigFloat precision needed to accurately measure distance to nearest
integer for cosh(π√limit). We need enough bits for the integer part plus extra
for the fractional part.

cosh(π√n) ≈ e^(π√n)/2, so log₁₀(cosh(π√n)) ≈ π√n / ln(10)
"""
function required_precision_bits(limit; fractional_digits=32)
    val = cosh(big(π) * sqrt(big(limit)))
    integer_digits = ceil(Int, log10(val))
    total_digits = integer_digits + fractional_digits
    return ceil(Int, total_digits * log2(10))
end

"""
    find_closest_cos_to_integer(limit)

Search all non-square integers n with |n| ≤ limit and find which n makes
cos(π√n) closest to an integer. Automatically calculates required BigFloat precision.

Returns the best n and logs the top 10 closest values.
"""
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
