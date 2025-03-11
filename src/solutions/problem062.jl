"""
Project Euler Problem 62: Cubic Permutations

The cube, 41063625 (345³), can be permuted to produce two other cubes:
56623104 (384³) and 66430125 (405³). In fact, 41063625 is the smallest cube
which has exactly three permutations of its digits which are also cube.

Find the smallest cube for which exactly five permutations of its digits are cube.
"""
module Problem062

"""
    find_cube_permutations(count)

Find the smallest cube for which exactly `count` permutations of its digits
are also cubes.

The key insight is that permutations of the same digits will have the same sorted
representation. We group cubes by digit signature, and when we find a group with
exactly `count` members, we return the smallest one.
"""
function find_cube_permutations(count)
    n = 1
    current_digit_count = 1
    cube_groups = Dict{String, Vector{Int}}()

    while true
        cube = n^3
        cube_str = string(cube)
        cube_digits = length(cube_str)

        if cube_digits > current_digit_count
            for (_, bases) in cube_groups
                if length(bases) == count
                    smallest_base = minimum(bases)
                    return smallest_base^3
                end
            end

            cube_groups = Dict{String, Vector{Int}}()
            current_digit_count = cube_digits
        end

        signature = join(sort(collect(cube_str)))

        if !haskey(cube_groups, signature)
            cube_groups[signature] = [n]
        else
            push!(cube_groups[signature], n)
        end

        n += 1
    end
end

function solve()
    return find_cube_permutations(5)
end

end # module
