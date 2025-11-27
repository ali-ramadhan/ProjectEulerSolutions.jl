"""
Project Euler Bonus Problem: Secret

Find the secret word by following the instructions below.

The statement of this problem is contained in an image.

Starting with this image, at each step, simultaneously replace each pixel with the sum of
its four neighbours in orthogonal directions. Note that, although the original pixels are
represented by 8-bit integers, in later steps they can be arbitrarily large without any
integer overflow.

The edges of the image are considered "glued" in such a way that pixels on the top edge are
neighbours to those on the bottom edge; and similarly for left and right edges.

After 10^12 steps, the secret word will be revealed by taking each pixel modulo 7.

## Solution approach

This is a linear cellular automaton on a toroidal grid. Direct simulation of 10^12 steps is
computationally infeasible, but we can exploit the Frobenius Endomorphism in Z_7.

The key insight is that in the field Z_7, the identity (A + B)^7 == A^7 + B^7 (mod 7) holds.
This means that applying the neighbor-sum operator 7^k times is equivalent to summing
neighbors at a distance of 7^k instead of 1.

We decompose 10^12 into its base-7 representation: 10^12 = sum(c_k * 7^k), where c_k in {0,
    1, ..., 6}

For each digit c_k, we apply c_k sparse operations where neighbors are collected at distance
7^k (with toroidal wrapping).

## Complexity analysis

Time complexity: O(log_7(N) * W * H)
- Instead of O(10^12 * W * H), we only need ~15 iterations (since 7^14 > 10^12)
- Each iteration involves a constant number of array operations

Space complexity: O(W * H)
- We only store the current grid state plus temporary arrays for shifted versions

## Mathematical background

The Frobenius Endomorphism states that for any prime p and elements in Z_p: (a + b)^p == a^p
    + b^p (mod p)

Applied to our operator kernel K = x + x^(-1) + y + y^(-1), we get: K^(7^k) == x^(7^k) +
    x^(-7^k) + y^(7^k) + y^(-7^k) (mod 7)

This allows us to "fast-forward" groups of 7^k steps by simply shifting the neighbor
distance from 1 to 7^k.
"""
module BonusSecret

using PNGFiles
using ColorTypes: Gray

export solve, simulate_cellular_automaton

"""
    simulate_cellular_automaton(grid::Matrix{Int}, total_steps::Int, modulo::Int)

Simulate a cellular automaton where each cell is replaced by the sum of its four
orthogonal neighbors, using base-`modulo` decomposition for efficiency.

Uses the Frobenius Endomorphism to reduce O(N) steps to O(log_modulo(N)) operations.

# Arguments
- `grid`: Initial 2D grid of integer values
- `total_steps`: Number of steps to simulate
- `modulo`: Prime modulus for arithmetic (enables Frobenius optimization)

# Returns
- Final grid state after `total_steps`, with all values in Z_modulo
"""
function simulate_cellular_automaton(grid::Matrix{Int}, total_steps::Int, modulo::Int)
    # Work strictly in Z_modulo
    grid = grid .% modulo

    current_steps = total_steps
    power = 0

    while current_steps > 0
        digit = current_steps % modulo
        current_steps = div(current_steps, modulo)

        shift_dist = modulo^power

        # Apply operator 'digit' times at this scale
        # Since digit is small (0 to modulo-1), a simple loop is efficient
        for _ in 1:digit
            # Calculate neighbors using circshift (handles toroidal boundary)
            # Dimension 1 = Vertical (Up/Down), Dimension 2 = Horizontal (Left/Right)
            up = circshift(grid, (shift_dist, 0))
            down = circshift(grid, (-shift_dist, 0))
            left = circshift(grid, (0, shift_dist))
            right = circshift(grid, (0, -shift_dist))

            grid = (up .+ down .+ left .+ right) .% modulo
        end

        power += 1
    end

    return grid
end

"""
    solve()

Solve the secret bonus problem by simulating 10^12 steps of the cellular automaton
and saving the result as a PNG image.

The result is saved to `data/bonus_secret_result.png`.
"""
function solve()
    # Load the problem image
    input_path = joinpath(@__DIR__, "..", "..", "data", "bonus_secret_statement.png")
    img = PNGFiles.load(input_path)

    # Convert to grayscale and extract pixel values as integers (0-255)
    gray_img = Gray.(img)
    # Gray values are in [0, 1], scale to [0, 255]
    grid = Int.(round.(Float64.(gray_img) .* 255))

    @info "Loaded image" size = size(grid)

    # Simulate 10^12 steps with modulo 7
    total_steps = 10^12
    modulo = 7

    @info "Starting simulation" total_steps modulo
    result = simulate_cellular_automaton(grid, total_steps, modulo)
    @info "Simulation complete"

    # Create binary image: non-zero residues become white (1), zeros become black (0)
    binary_result = Gray.(Float64.(result .!= 0))

    # Save the result
    output_path = joinpath(@__DIR__, "..", "..", "data", "bonus_secret_result.png")
    PNGFiles.save(output_path, binary_result)
    @info "Result saved" path = output_path

    return nothing
end

end # module
