"""
Project Euler Bonus Problem: Secret

Problem description: https://projecteuler.net/problem=secret
Solution description: https://aliramadhan.me/blog/project-euler/bonus-secret/
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
