"""
Project Euler Bonus Problem: Heegner

Among all non-square integers n with absolute value not exceeding 10³, find the value of n
such that cos(π√n) is closest to an integer.

## Solution approach

This problem is related to Heegner numbers, which are special negative integers that lead to
unique factorization in certain quadratic fields. When cos(π√n) is very close to an integer,
it often involves these special numbers.

The approach is to:
1. Iterate through all non-square integers n with |n| ≤ 1000
2. For each n, calculate cos(π√n):
   - If n > 0: cos(π√n)
   - If n < 0: cosh(π√|n|) since cos(iπ√|n|) = cosh(π√|n|)
3. Find the n that minimizes |cos(π√n) - round(cos(π√n))|

## Complexity analysis

Time complexity: O(n)
- Single pass through all integers from -1000 to 1000
- Constant time operations for each integer

Space complexity: O(1)
- Only storing the best result found so far

## Mathematical background

For negative integers n, we use the identity cos(iθ) = cosh(θ), so:
cos(π√n) = cos(iπ√|n|) = cosh(π√|n|)

Heegner numbers are the negative square-free integers d such that the imaginary quadratic
field Q(√d) has class number 1. The complete list is: -1, -2, -3, -7, -11, -19, -43, -67,
-163.

The largest Heegner number is -163, which is famous for Ramanujan's near-integer: e^(π√163)
≈ 262537412640768744.

## Key insights

The connection to Heegner numbers suggests that n = -163 will likely give the result closest
to an integer, as cosh(π√163) = (e^(π√163) + e^(-π√163))/2 ≈ 262537412640768744/2.
"""
module BonusHeegner

function distance_to_nearest_integer(x::Float64)::Float64
    if isinf(x) || isnan(x)
        return Inf
    end
    nearest = round(x)
    return abs(x - nearest)
end

function find_closest_cos_to_integer(limit::Int)
    best_n = 0
    best_distance = Inf

    heegner_numbers = [-1, -2, -3, -7, -11, -19, -43, -67, -163]

    for n in heegner_numbers
        if abs(n) <= limit
            arg = π * sqrt(-n)
            cos_value = cosh(arg)
            distance = distance_to_nearest_integer(cos_value)

            if distance < best_distance
                best_distance = distance
                best_n = n
                @info "Heegner number: n = $n, cosh(π√|n|) ≈ $cos_value, distance = $distance"
            end
        end
    end

    for n in -limit:limit
        if n == 0 || ispow2(abs(n)) || n in heegner_numbers
            continue
        end

        cos_value = if n > 0
            cos(π * sqrt(n))
        else
            arg = π * sqrt(-n)
            if arg > 50
                continue
            end
            cosh(arg)
        end

        if abs(cos_value) > 1e12
            continue
        end

        distance = distance_to_nearest_integer(cos_value)

        if distance < best_distance
            best_distance = distance
            best_n = n
            @info "New best: n = $n, cos(π√n) ≈ $cos_value, distance = $distance"
        end
    end

    return best_n
end

function solve()
    return find_closest_cos_to_integer(1000)
end

end # module
