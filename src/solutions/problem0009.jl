"""
Project Euler Problem 9: Special Pythagorean Triplet

Problem description: https://projecteuler.net/problem=9
Solution description: https://aliramadhan.me/blog/project-euler/problem-0009/
"""
module Problem0009

export find_pythagorean_triplets_search, find_pythagorean_triplets_euclid, find_pythagorean_triplets_divisors, solve

using ProjectEulerSolutions.Utils.Primes: prime_factors

function find_pythagorean_triplets_search(P)
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

function find_pythagorean_triplets_divisors(P)
    triplets = Tuple{Int,Int,Int}[]

    # Perimeters are even and the smallest one is 12 = 3 + 4 + 5
    (P < 12 || isodd(P)) && return triplets

    # Build the divisors of P²/2 below P.
    factors = prime_factors(P)
    xs = [1]
    for p in unique(factors)
        e = 2 * count(==(p), factors) - (p == 2)  # exponent of p in P²/2
        for i in eachindex(xs)
            x = xs[i]
            for _ in 1:e
                x > (P - 1) ÷ p && break
                x *= p
                push!(xs, x)
            end
        end
    end

    N = widemul(P, P) ÷ 2
    for x in xs
        if widemul(x, x) > N
            y = Int(N ÷ x)
            a = P - x
            b = P - y
            c = x + y - P
            push!(triplets, (a, b, c))
        end
    end

    return sort!(triplets)
end

function solve(solve_func=find_pythagorean_triplets_divisors)
    triplets = solve_func(1000)
    @info "Found $(length(triplets)) Pythagorean triplet(s) for n=1000: $triplets"
    a, b, c = first(triplets)
    return a * b * c
end

end # module
