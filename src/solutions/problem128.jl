"""
Project Euler Problem 128: Hexagonal Tile Differences

A hexagonal tile with number 1 is surrounded by a ring of six hexagonal tiles, starting at
"12 o'clock" and numbering the tiles 2 to 7 in an anti-clockwise direction.

New rings are added in the same fashion, with the next rings being numbered 8 to 19, 20 to
37, 38 to 61, and so on.

By finding the difference between tile n and each of its six neighbours we shall define
PD(n) to be the number of those differences which are prime.

For example, working clockwise around tile 8 the differences are 12, 29, 11, 6, 1, and 13.
So PD(8) = 3.

In the same way, the differences around tile 17 are 1, 17, 16, 1, 11, and 10, hence PD(17) =
2.

It can be shown that the maximum value of PD(n) is 3.

If all of the tiles for which PD(n) = 3 are listed in ascending order to form a sequence,
the 10th tile would be 271.

Find the 2000th tile in this sequence.

## Solution approach

Based on mathematical analysis of the hexagonal lattice, only very specific positions can
have PD(n) = 3:

1. **Tiles 1 and 2**: Special cases from the initial rings
2. **First tile of ring k (k ≥ 2)**: Position n = 3k(k-1) + 2, requires 6k-1, 6k+1, 12k+5
   all prime
3. **Last tile of ring k (k ≥ 2)**: Position n = 3k(k+1) + 1, requires 6k-1, 6k+5, 12k-7 all
   prime

This dramatically reduces the search space from checking all tiles to checking only 2
positions per ring.

## Complexity analysis

Time complexity: O(k√p) where k is the number of rings searched and p is the largest prime
tested
- Only checking 2 positions per ring
- Each position requires 3 primality tests
- Primality testing uses trial division in O(√n)

Space complexity: O(1)
- Constant space for calculations

## Key insights

The hexagonal lattice structure ensures that only corner positions can achieve 3 prime
differences due to parity constraints and neighbor proximity in the geometric arrangement.
"""
module Problem128

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    find_tiles_with_pd3(target_count)

Find tiles with exactly 3 prime differences using the mathematical characterization.
Returns the target_count-th tile in the sequence.
"""
function find_tiles_with_pd3(target_count)
    tiles = [1, 2]  # Special cases: tiles 1 and 2 both have PD = 3

    k = 2  # Start checking from ring 2
    while length(tiles) < target_count
        # Common condition: 6k-1 must be prime for both positions
        if is_prime(6k - 1)
            # Check first tile of ring k: n = 3k(k-1) + 2
            # Requires: 6k-1, 6k+1, 12k+5 all prime
            if is_prime(6k + 1) && is_prime(12k + 5)
                first_tile = 3k*(k-1) + 2
                push!(tiles, first_tile)
            end

            # Check last tile of ring k: n = 3k(k+1) + 1
            # Requires: 6k-1, 6k+5, 12k-7 all prime
            if length(tiles) < target_count && is_prime(6k + 5) && is_prime(12k - 7)
                last_tile = 3k*(k+1) + 1
                push!(tiles, last_tile)
            end
        end

        k += 1

        # Progress reporting
        if k % 10000 == 0
            @info "Searched $(k-2) rings, found $(length(tiles))/$target_count tiles"
        end
    end

    sort!(tiles)
    return length(tiles) >= target_count ? tiles[target_count] : -1
end

function solve()
    return find_tiles_with_pd3(2000)
end

end # module
