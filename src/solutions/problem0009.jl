"""
Project Euler Problem 9: Special Pythagorean Triplet

Problem description: https://projecteuler.net/problem=9
Solution description: https://aliramadhan.me/blog/project-euler/problem-0009/
"""
module Problem0009

function find_pythagorean_triplets(P)
    triplets = Tuple{Int,Int,Int}[]

    for a in 1:(P÷3)
        numerator = P * (P - 2a)
        denominator = 2 * (P - a)

        # Check if b is an integer
        if numerator % denominator == 0
            b = numerator ÷ denominator

            if b > 0 && b > a
                c = P - a - b

                if a < b < c && a^2 + b^2 == c^2
                    push!(triplets, (a, b, c))
                end
            end
        end
    end

    return triplets
end

function find_pythagorean_triplets_euclid(P)
    triplets = Set{Tuple{Int,Int,Int}}()

    isodd(P) && return triplets

    half_P = P ÷ 2

    for m in 2:isqrt(half_P)
        half_P % m == 0 || continue
        R = half_P ÷ m

        for d in 1:isqrt(R)
            R % d == 0 || continue

            for m_plus_n in (d, R ÷ d)
                n = m_plus_n - m

                if n < 1 || n >= m || gcd(m, n) != 1 || iseven(m + n)
                    continue
                end

                k = R ÷ m_plus_n
                a, b = minmax(k * (m^2 - n^2), 2k * m * n)
                c = k * (m^2 + n^2)
                push!(triplets, (a, b, c))
            end
        end
    end

    return sort!(collect(triplets))
end

function solve(solve_func=find_pythagorean_triplets_euclid)
    triplets = solve_func(1000)
    @info "Found $(length(triplets)) Pythagorean triplet(s) for n=1000: $triplets"
    a, b, c = first(triplets)
    return a * b * c
end

end # module
