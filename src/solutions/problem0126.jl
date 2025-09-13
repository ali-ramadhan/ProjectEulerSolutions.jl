"""
Project Euler Problem 126: Cuboid layers

The minimum number of cubes to cover every visible face on a cuboid measuring 3 × 2 × 1 is
twenty-two.

If we then add a second layer to this solid it would require forty-six cubes to cover every
visible face, the third layer would require seventy-eight cubes, and the fourth layer would
require one-hundred and eighteen cubes to cover every visible face.

However, the first layer on a cuboid measuring 5 × 1 × 1 also requires twenty-two cubes;
similarly the first layer on cuboids measuring 5 × 3 × 1, 7 × 2 × 1, and 11 × 1 × 1 all
contain forty-six cubes.

We shall define C(n) to represent the number of cuboids that contain n cubes in one of its
layers. So C(22) = 2, C(46) = 4, C(78) = 5, and C(118) = 8.

It turns out that 154 is the least value of n for which C(n) = 10.

Find the least value of n for which C(n) = 1000.

## Solution approach

The key insight is deriving the formula for the number of cubes in layer n around a cuboid
(a,b,c):

L(a,b,c,n) = 2(ab + bc + ca) + 4(n-1)(a + b + c) + 4(n-1)(n-2)

This formula accounts for:
- Base surface area: 2(ab + bc + ca)
- Linear growth with layer thickness: 4(n-1)(a + b + c)
- Quadratic growth from corners and edges: 4(n-1)(n-2)

The algorithm systematically generates all cuboids (a ≤ b ≤ c) and calculates layer sizes
for each, counting how many cuboids produce each layer size value.

## Complexity analysis

Time complexity: O(N³ × L) where N is the upper bound for cuboid dimensions and L is the
maximum layer number
- We iterate through all combinations of (a,b,c) with a ≤ b ≤ c ≤ N
- For each cuboid, we calculate layers until the size exceeds our limit

Space complexity: O(M) where M is the maximum layer size we track
- We maintain a counter array indexed by layer size
"""
module Problem0126

function layer_cubes(a, b, c, n)
    # Correct formula after careful analysis
    return 2 * (a*b + b*c + c*a) + 4 * (n-1) * (a + b + c) + 4 * (n-1) * (n-2)
end

function find_layer_with_count(target_count, max_layer_size, max_bound)
    # Count how many cuboids produce each layer size
    count = zeros(Int, max_layer_size)

    # Generate all cuboids systematically (a ≤ b ≤ c)

    for a in 1:max_bound
        # Early termination based on cube bounds
        if 2 * 3 * a * a > max_layer_size
            break
        end

        for b in a:max_bound
            # Early termination: if minimum c = b gives first layer > limit
            if 2 * (a*b + 2*b*b) > max_layer_size
                break
            end

            for c in b:max_bound
                # Check if first layer exceeds limit
                first_layer = 2 * (a*b + b*c + c*a)
                if first_layer > max_layer_size
                    break
                end

                # Calculate all layers for this cuboid until size exceeds limit
                n = 1
                while true
                    layer_size = layer_cubes(a, b, c, n)
                    if layer_size > max_layer_size
                        break
                    end
                    count[layer_size] += 1
                    n += 1
                end
            end
        end
    end

    # Find the smallest n where C(n) = target_count
    for n in 1:max_layer_size
        if count[n] == target_count
            @info "Found first layer size with exactly $target_count cuboids: $n"
            return n
        end
    end

    return -1  # Not found
end

function solve()
    return find_layer_with_count(1000, 40000, 5000)
end

end # module
