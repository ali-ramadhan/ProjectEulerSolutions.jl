"""
Project Euler Bonus Problem: Secret

Find the secret word by following the instructions below.

The statement of this problem is contained in an image.

Starting with this image, at each step, simultaneously replace each pixel with the sum of its four neighbours in orthogonal directions.

Note that, although the original pixels are represented by 8-bit integers, in later steps they can be arbitrarily large without any integer overflow.

The edges of the image are considered "glued" in such a way that pixels on the top edge are neighbours to those on the bottom edge; and similarly for left and right edges.

After 10^12 steps, the secret word will be revealed by taking each pixel modulo 7.

## Solution approach

Phase 1: Basic simulation for steps 1-10
- Parse the initial grid from the problem diagram
- Implement direct simulation of the neighbor-sum transformation
- Apply toroidal topology (wraparound edges)
- Display intermediate results to verify correctness

Phase 2: Matrix exponentiation for 10^12 steps
- Model the transformation as matrix multiplication
- Use binary exponentiation to compute M^(10^12) mod 7 efficiently
- Time complexity: O(n³ log k) where n is grid size, k = 10^12

## Complexity analysis

Time complexity (naive): O(k × n) for k steps on n pixels
Time complexity (optimized): O(n³ × log k) using matrix exponentiation

Space complexity: O(n) for storing the grid
"""
module BonusSecret

using FileIO, PNGFiles
using ColorTypes: Gray, RGB, N0f8
using SparseArrays
using LinearAlgebra
using FFTW

"""
    parse_initial_grid()

Parse the initial grid from the actual PNG image file.
Converts the image to grayscale and extracts 8-bit integer values (0-255).
"""
function parse_initial_grid()
    # Load the actual image from the data directory
    image_path = joinpath(@__DIR__, "..", "..", "data", "bonus_secret_statement.png")
    img = load(image_path)

    # Convert to grayscale and extract intensity values as 8-bit integers
    # Images are RGB, so we convert to grayscale using standard formula
    rows, cols = size(img)
    grid = zeros(Int, rows, cols)

    for i in 1:rows
        for j in 1:cols
            pixel = img[i, j]
            # Convert RGB to grayscale using standard luminance formula
            # Y = 0.299*R + 0.587*G + 0.114*B
            gray_value = 0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b
            # Convert to 0-255 range (N0f8 is normalized to 0-1)
            grid[i, j] = round(Int, gray_value * 255)
        end
    end

    return grid
end

"""
    apply_step(grid)

Apply one step of the transformation: replace each pixel with the sum of its
four orthogonal neighbors, using toroidal topology (wraparound edges).
"""
function apply_step(grid)
    rows, cols = size(grid)
    new_grid = similar(grid)

    for i in 1:rows
        for j in 1:cols
            # Get the 4 orthogonal neighbors with wraparound
            up = grid[i == 1 ? rows : i-1, j]
            down = grid[i == rows ? 1 : i+1, j]
            left = grid[i, j == 1 ? cols : j-1]
            right = grid[i, j == cols ? 1 : j+1]

            new_grid[i, j] = up + down + left + right
        end
    end

    return new_grid
end

"""
    apply_steps(grid, n)

Apply n steps of the transformation and return the final grid.
"""
function apply_steps(grid, n)
    current = grid
    for step in 1:n
        current = apply_step(current)
    end
    return current
end

"""
    decode_grid(grid)

Decode the grid by taking each value modulo 7.
Values 0-6 might map to letters or spaces.
"""
function decode_grid(grid)
    return mod.(grid, 7)
end

"""
    display_grid(grid, title="Grid")

Display a grid in a readable format.
"""
function display_grid(grid, title="Grid")
    println("\n$title:")
    rows, cols = size(grid)
    for i in 1:rows
        for j in 1:cols
            print(lpad(grid[i,j], 8), " ")
        end
        println()
    end
end

"""
    decode_to_chars(mod7_grid)

Try to decode mod7 values to characters.
This may require experimentation to find the right mapping.
"""
function decode_to_chars(mod7_grid)
    # Possible mappings to try:
    # 0-6 could map to different letters or the pattern itself shows letters
    println("\nMod 7 grid:")
    rows, cols = size(mod7_grid)
    for i in 1:rows
        for j in 1:cols
            print(mod7_grid[i,j], " ")
        end
        println()
    end
end

"""
    grid_to_image_normalized(grid)

Convert a grid with arbitrary integer values to a grayscale image.
Normalizes values to 0-255 range for visualization.
"""
function grid_to_image_normalized(grid)
    # Normalize to 0-255 range
    min_val = minimum(grid)
    max_val = maximum(grid)

    if max_val == min_val
        # All values are the same
        normalized = zeros(Float64, size(grid))
    else
        normalized = (grid .- min_val) ./ (max_val - min_val)
    end

    # Convert to Gray image (0.0 = black, 1.0 = white)
    img = Gray{N0f8}.(normalized)
    return img
end

"""
    grid_to_image_mod7(grid)

Convert a mod 7 grid (values 0-6) to a color image with distinct colors.
Uses a colormap where each value 0-6 gets a unique color.
"""
function grid_to_image_mod7(grid)
    # Colormap for values 0-6 (7 distinct colors)
    colormap = [
        RGB{N0f8}(0.0, 0.0, 0.0),      # 0: Black
        RGB{N0f8}(1.0, 0.0, 0.0),      # 1: Red
        RGB{N0f8}(0.0, 1.0, 0.0),      # 2: Green
        RGB{N0f8}(0.0, 0.0, 1.0),      # 3: Blue
        RGB{N0f8}(1.0, 1.0, 0.0),      # 4: Yellow
        RGB{N0f8}(1.0, 0.0, 1.0),      # 5: Magenta
        RGB{N0f8}(0.0, 1.0, 1.0),      # 6: Cyan
    ]

    rows, cols = size(grid)
    img = Matrix{RGB{N0f8}}(undef, rows, cols)

    for i in 1:rows
        for j in 1:cols
            val = mod(grid[i, j], 7) + 1  # +1 because Julia is 1-indexed
            img[i, j] = colormap[val]
        end
    end

    return img
end

"""
    save_grid_as_png(grid, filename; use_mod7=false)

Save a grid as a PNG image.
If use_mod7=true, uses a colormap for mod 7 values.
Otherwise, normalizes values to grayscale.
"""
function save_grid_as_png(grid, filename; use_mod7=false)
    img = if use_mod7
        grid_to_image_mod7(grid)
    else
        grid_to_image_normalized(grid)
    end

    save(filename, img)
    println("Saved: $filename")
end

"""
    build_transition_matrix(rows, cols)

Build the sparse transition matrix for the toroidal grid transformation.
Each pixel's value becomes the sum of its 4 orthogonal neighbors.

Returns a sparse matrix M where M[i,j] = 1 if pixel j contributes to pixel i.
"""
function build_transition_matrix(rows, cols)
    n = rows * cols
    I_indices = Int[]
    J_indices = Int[]

    # For each pixel (i, j), we need to find its 4 neighbors
    # and add entries to the matrix
    for i in 1:rows
        for j in 1:cols
            # Current pixel index in flattened array
            current_idx = (i-1) * cols + j

            # Four neighbors with toroidal wraparound
            up_i = i == 1 ? rows : i-1
            down_i = i == rows ? 1 : i+1
            left_j = j == 1 ? cols : j-1
            right_j = j == cols ? 1 : j+1

            # Indices of neighbors
            up_idx = (up_i-1) * cols + j
            down_idx = (down_i-1) * cols + j
            left_idx = (i-1) * cols + left_j
            right_idx = (i-1) * cols + right_j

            # Add entries: current pixel gets value from its 4 neighbors
            push!(I_indices, current_idx)
            push!(J_indices, up_idx)

            push!(I_indices, current_idx)
            push!(J_indices, down_idx)

            push!(I_indices, current_idx)
            push!(J_indices, left_idx)

            push!(I_indices, current_idx)
            push!(J_indices, right_idx)
        end
    end

    # Create sparse matrix with all values = 1
    values = ones(Int, length(I_indices))
    M = sparse(I_indices, J_indices, values, n, n)

    return M
end

"""
    matpow_mod(M, k, p)

Compute M^k mod p using binary exponentiation.
All intermediate computations are done modulo p.
Uses Int8 for memory efficiency.
"""
function matpow_mod(M, k, p)
    n = size(M, 1)

    # Convert to Int8 for memory efficiency
    M_int8 = SparseMatrixCSC{Int8, Int64}(M)

    # Start with identity matrix (Int8)
    result = sparse(Int8(1) * I, n, n)

    # Base for exponentiation
    base = M_int8

    # Binary exponentiation
    iterations = 0
    while k > 0
        iterations += 1
        if k & 1 == 1
            result = sparse(Int8.(mod.(result * base, p)))
            dropzeros!(result)
            nnz_result = nnz(result)
            if iterations <= 10 || iterations % 5 == 0
                println("  Iter $iterations: result has $nnz_result non-zeros, k=$k")
            end
        end
        base = sparse(Int8.(mod.(base * base, p)))
        dropzeros!(base)
        k >>= 1

        # Force garbage collection periodically to free memory
        if iterations % 3 == 0
            GC.gc()
        end
    end

    return result
end

"""
    solve_large_steps(num_steps::Integer)

Solve for the grid state after num_steps iterations using matrix exponentiation.
All operations are performed modulo 7.
"""
function solve_large_steps(num_steps::Integer; save_result=true)
    println("Loading initial grid...")
    grid = parse_initial_grid()
    rows, cols = size(grid)
    n = rows * cols

    println("Grid size: $rows × $cols = $n pixels")
    println("\nBuilding transition matrix...")
    M = build_transition_matrix(rows, cols)
    println("Transition matrix built: $(nnz(M)) non-zero entries")

    println("\nComputing M^$num_steps mod 7 using binary exponentiation...")
    M_pow = matpow_mod(M, num_steps, 7)
    println("Matrix exponentiation complete!")

    println("\nApplying transformation to initial grid...")
    # Flatten grid to vector, apply transformation, reshape back
    v0 = vec(mod.(grid, 7))  # Start with initial values mod 7
    v_final = mod.(M_pow * v0, 7)
    result_grid = reshape(v_final, rows, cols)

    println("Transformation complete!")

    if save_result
        output_file = "bonus/problem_secret_step_$(num_steps)_mod7.png"
        save_grid_as_png(result_grid, output_file; use_mod7=true)
        println("\n✓ Result saved to: $output_file")
    end

    return result_grid
end

"""
    generate_step_images(num_steps=10; output_dir="bonus")

Generate and save PNG images for each step of the simulation.
Saves both raw (normalized) and mod 7 versions.
"""
function generate_step_images(num_steps=10; output_dir="bonus")
    grid = parse_initial_grid()

    # Create output directory if it doesn't exist
    if !isdir(output_dir)
        mkdir(output_dir)
    end

    # Save initial state (step 0)
    save_grid_as_png(grid, joinpath(output_dir, "problem_secret_step_00.png"); use_mod7=false)
    save_grid_as_png(grid, joinpath(output_dir, "problem_secret_step_00_mod7.png"); use_mod7=true)

    println("\nGenerating images for $num_steps steps...")
    println("Initial grid (Step 0):")
    display_grid(grid, "Step 0")

    # Generate and save images for each step
    for step in 1:num_steps
        grid = apply_step(grid)

        # Format step number with leading zeros
        step_str = lpad(step, 2, '0')

        # Save raw values (normalized to grayscale)
        raw_filename = joinpath(output_dir, "problem_secret_step_$(step_str).png")
        save_grid_as_png(grid, raw_filename; use_mod7=false)

        # Save mod 7 values (as colormap)
        mod7_filename = joinpath(output_dir, "problem_secret_step_$(step_str)_mod7.png")
        mod7_grid = decode_grid(grid)
        save_grid_as_png(mod7_grid, mod7_filename; use_mod7=true)

        # Display progress
        println("\nStep $step:")
        display_grid(grid, "Raw values")
        decode_to_chars(mod7_grid)
    end

    println("\n✓ Generated $(2 * (num_steps + 1)) images in $output_dir/")
    println("  - $(num_steps + 1) raw (normalized) images: problem_secret_step_XX.png")
    println("  - $(num_steps + 1) mod 7 images: problem_secret_step_XX_mod7.png")

    return output_dir
end

"""
    solve_fft(num_steps::Integer)

Solve using FFT approach - much more memory efficient!

The key insight: the neighbor-sum operation is a discrete convolution with kernel:
    [0  1  0]
    [1  0  1]
    [0  1  0]

In Fourier space, convolution becomes multiplication. For a toroidal grid,
the eigenvalues of this operation are: λ(kx, ky) = 2*(cos(2πkx/rows) + cos(2πky/cols))

Then: grid_after_n = IFFT( λ^n * FFT(grid_initial) )
"""
function solve_fft(num_steps::Integer; save_result=true)
    println("Loading initial grid...")
    grid = parse_initial_grid()
    rows, cols = size(grid)

    println("Grid size: $rows × $cols = $(rows*cols) pixels")
    println("\nComputing eigenvalues in Fourier space...")

    # Compute eigenvalues for the neighbor-sum operator
    # For each frequency (kx, ky), the eigenvalue is:
    # λ(kx, ky) = 2 * (cos(2π*kx/rows) + cos(2π*ky/cols))
    kx = fftfreq(rows, rows)
    ky = fftfreq(cols, cols)

    eigenvalues = zeros(ComplexF64, rows, cols)
    for i in 1:rows
        for j in 1:cols
            eigenvalues[i, j] = 2 * (cos(2π * kx[i]) + cos(2π * ky[j]))
        end
    end

    println("\nTaking FFT of initial grid...")
    grid_fft = fft(Float64.(mod.(grid, 7)))

    println("\nApplying λ^$num_steps in frequency domain...")
    # Raise eigenvalues to the power num_steps
    # Handle numerical stability: if |λ| < 1, λ^n → 0 for large n
    eigenvalues_power = similar(eigenvalues)
    for i in eachindex(eigenvalues)
        λ = eigenvalues[i]
        if abs(λ) < 0.999
            # For |λ| < 1, λ^n approaches 0 for large n
            eigenvalues_power[i] = 0.0
        elseif abs(λ) > 1.001
            # For |λ| > 1, λ^n explodes - this means the operation is unstable
            # But in practice, eigenvalues should be in [-4, 4] for this operator
            eigenvalues_power[i] = λ ^ num_steps
        else
            # For |λ| ≈ 1, compute carefully
            eigenvalues_power[i] = λ ^ num_steps
        end
    end

    result_fft = grid_fft .* eigenvalues_power

    println("\nTaking inverse FFT...")
    result_real = real.(ifft(result_fft))

    # Round and take mod 7, handling any remaining NaN/Inf
    result_grid = zeros(Int, size(result_real))
    for i in eachindex(result_real)
        if isnan(result_real[i]) || isinf(result_real[i])
            result_grid[i] = 0
        else
            result_grid[i] = mod(round(Int, result_real[i]), 7)
        end
    end

    println("Transformation complete!")

    if save_result
        output_file = "bonus/problem_secret_step_$(num_steps)_mod7.png"
        save_grid_as_png(result_grid, output_file; use_mod7=true)
        println("\n✓ Result saved to: $output_file")
    end

    return result_grid
end

function solve()
    return solve_fft(10^12)
end

end # module
