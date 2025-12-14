"""
Project Euler Problem 9: Special Pythagorean Triplet

Problem description: https://projecteuler.net/problem=9
Solution description: https://aliramadhan.me/blog/project-euler/problem-0009/
"""
module Problem0009

function find_pythagorean_triplets(n)
    triplets = Tuple{Int,Int,Int}[]

    for a in 1:(n÷3)
        numerator = n * (n - 2a)
        denominator = 2 * (n - a)

        # Check if b is an integer
        if numerator % denominator == 0
            b = numerator ÷ denominator

            if b > 0 && b > a
                c = n - a - b

                if a < b < c && a^2 + b^2 == c^2
                    push!(triplets, (a, b, c))
                end
            end
        end
    end

    return triplets
end


function solve()
    triplets = find_pythagorean_triplets(1000)
    @info "Found $(length(triplets)) Pythagorean triplet(s) for n=1000: $triplets"
    a, b, c = first(triplets)
    return a * b * c
end

end # module
