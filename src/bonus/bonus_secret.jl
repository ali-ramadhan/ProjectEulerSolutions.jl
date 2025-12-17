"""
Project Euler Bonus Problem: Secret

Problem description: https://projecteuler.net/problem=secret
Solution description: https://aliramadhan.me/blog/project-euler/bonus-secret/
"""
module BonusSecret

using PNGFiles
using ColorTypes: Gray

function simulate_cellular_automaton(grid, total_steps, modulo)
    # Work strictly in Z_modulo
    grid = grid .% modulo

    current_steps = total_steps
    power = 0

    while current_steps > 0
        digit = current_steps % modulo
        current_steps = div(current_steps, modulo)

        shift = modulo^power

        # Apply operator 'digit' times at this scale
        for _ in 1:digit
            up = circshift(grid, (shift, 0))
            down = circshift(grid, (-shift, 0))
            left = circshift(grid, (0, shift))
            right = circshift(grid, (0, -shift))

            grid = (up .+ down .+ left .+ right) .% modulo
        end

        power += 1
    end

    return grid
end

function solve()
    # Load the problem image
    image_filepath = joinpath(@__DIR__, "..", "..", "data", "bonus_secret_statement.png")
    img = PNGFiles.load(image_filepath)

    # Convert to grayscale and extract pixel values as integers (0-255)
    gray_img = Gray.(img)
    grid = Int.(round.(Float64.(gray_img) .* 255))

    # Simulate!
    total_steps = 10^12
    modulo = 7
    result = simulate_cellular_automaton(grid, total_steps, modulo)

    # Scale to [0, 1]
    scaled_result = Gray.(result ./ modulo)

    # Save the result
    output_path = joinpath(@__DIR__, "..", "..", "data", "bonus_secret_result.png")
    PNGFiles.save(output_path, scaled_result)

    return nothing
end

end # module
