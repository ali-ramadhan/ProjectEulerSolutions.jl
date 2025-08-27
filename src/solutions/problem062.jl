"""
Project Euler Problem 62: Cubic Permutations

The cube, 41063625 (345³), can be permuted to produce two other cubes: 56623104 (384³) and
66430125 (405³). In fact, 41063625 is the smallest cube which has exactly three permutations
of its digits which are also cube.

Find the smallest cube for which exactly five permutations of its digits are cube.

## Solution approach

This solution uses a digit signature approach to group cubes by their digit permutations:
1. Process cubes in increasing order of their base number
2. For each cube, create a "signature" by sorting its digits - permutations will have
   identical signatures
3. Group cubes by signature and track when we find exactly 5 cubes with the same signature
4. Process one digit length at a time to ensure we find the smallest solution
5. Return the cube with the smallest base among the group of 5

## Complexity analysis

Time complexity: O(N log N) where N is the base of the solution cube
- We examine cubes from 1^3 up to the solution
- For each cube, sorting digits takes O(d log d) where d is number of digits (typically
  ≤ 10)
- Dictionary operations are O(1) average case

Space complexity: O(M) where M is the number of distinct digit signatures
- We store at most one digit-length worth of cubes at a time
- Each signature maps to a small list of base numbers

## Key insights

Processing cubes one digit length at a time ensures we find the smallest solution without
having to check all possible cubes. The digit signature approach efficiently groups
permutations without explicitly computing all permutations.
"""
module Problem062

"""
    find_cube_permutations(count)

Find the smallest cube for which exactly `count` permutations of its digits are also cubes.

The key insight is that permutations of the same digits will have the same sorted
representation. We group cubes by digit signature, and when we find a group with exactly
`count` members, we return the smallest one.
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
                    @info "Found $(count) cube permutations with bases $(bases) and " *
                          "cubes $([base^3 for base in bases])"
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
