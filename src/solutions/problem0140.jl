"""
Project Euler Problem 140: Modified Fibonacci Golden Nuggets

Consider the infinite polynomial series A_G(x) = xG₁ + x²G₂ + x³G₃ + ⋯, where Gₖ
is the kth term of the second order recurrence relation Gₖ = Gₖ₋₁ + Gₖ₋₂, G₁ = 1
and G₂ = 4; that is, 1, 4, 5, 9, 14, 23, ...

For this problem we shall be concerned with values of x for which A_G(x) is a
positive integer.

The corresponding values of x for the first five natural numbers are shown below:

x = (√5-1)/4,        A_G(x) = 1
x = 2/5,             A_G(x) = 2
x = (√22-2)/6,       A_G(x) = 3
x = (√137-5)/14,     A_G(x) = 4
x = 1/2,             A_G(x) = 5

We shall call A_G(x) a golden nugget if x is rational, because they become
increasingly rarer; for example, the 20th golden nugget is 211345365.

Find the sum of the first thirty golden nuggets.

## Solution approach

First, derive a closed form for A_G(x):
- Using the recurrence relation and algebraic manipulation:
  A_G(x) = x(1 + 3x)/(1 - x - x²)

For A_G(x) = n (a positive integer) with rational x:
- Set up equation: (n+3)x² + (n+1)x - n = 0
- For rational x, discriminant must be a perfect square: 5n² + 14n + 1 = k²

This transforms to the generalized Pell equation:
- Let y = 5n + 7: y² - 5k² = 44

The fundamental solution to y² - 5k² = 1 is (9, 4), which generates new solutions
from existing ones via: (y, k) → (9y + 20k, 4y + 9k)

We find fundamental solutions to y² - 5k² = 44 by checking small values, then
generate infinite sequences from each. For n to be an integer, we need y ≡ 2 (mod 5).

The fundamental solutions are: (7,1), (8,2), (13,5), (17,7), each generating a
sequence where every other term (or every second term) has y ≡ 2 (mod 5).

## Complexity analysis

Time complexity: O(1)
- We only need to generate about 10-15 terms from each of 4 fundamental solutions
- Each generation is O(1) arithmetic

Space complexity: O(1)
- We only store the golden nuggets we find (30 values)

## Key insights

- The problem reduces to solving a generalized Pell equation y² - 5k² = 44
- There are exactly 4 fundamental solution classes (up to sign)
- Within each sequence, solutions alternate between y ≡ 2 (mod 5) and y ≡ 3 (mod 5)
- The golden nuggets from all sequences need to be merged and sorted
"""
module Problem0140

function generate_pell_solutions(y0::Int, k0::Int, num_terms::Int)
    """Generate solutions to y² - 5k² = 44 using the recurrence."""
    solutions = [(y0, k0)]

    # Generate forward
    y, k = y0, k0
    for _ in 1:num_terms
        y_new = 9y + 20k
        k_new = 4y + 9k
        push!(solutions, (y_new, k_new))
        y, k = y_new, k_new
    end

    # Generate backward (and take absolute value of k)
    y, k = y0, k0
    for _ in 1:num_terms
        y_new = 9y - 20k
        k_new = abs(9k - 4y)  # Take absolute value
        if y_new > 0 && k_new > 0
            push!(solutions, (y_new, k_new))
            y, k = y_new, k_new
        else
            break  # Stop if we go negative
        end
    end

    return solutions
end

function solution_to_n(y::Int, k::Int)
    """Convert a Pell equation solution (y, k) to n, if valid."""
    if (y - 7) % 5 == 0
        return (y - 7) ÷ 5
    else
        return nothing
    end
end

function generate_from_conjugate(y0::Int, k0::Int, num_terms::Int)
    """Generate solutions starting from conjugate of (y0, k0), then using forward transformations."""
    solutions = []

    # First apply conjugate transformation to get starting point
    y = 9*y0 - 20*k0
    k = abs(4*y0 - 9*k0)

    if y <= 0
        return solutions
    end

    push!(solutions, (y, k))

    # Then apply forward transformations
    for _ in 1:num_terms-1
        y_new = 9y + 20k
        k_new = 4y + 9k
        push!(solutions, (y_new, k_new))
        y, k = y_new, k_new
    end

    return solutions
end

function find_golden_nuggets(target_count::Int)
    """Find the first target_count golden nuggets."""
    # Fundamental solutions to y² - 5k² = 44
    fundamental_solutions = [(7, 1), (8, 2), (13, 5), (17, 7)]

    golden_nuggets = Set{Int}()

    # Generate enough terms from each fundamental solution
    # We need to generate from both direct and conjugate families
    num_terms = 20

    for (y0, k0) in fundamental_solutions
        # Direct family
        solutions = generate_pell_solutions(y0, k0, num_terms)
        for (y, k) in solutions
            n = solution_to_n(y, k)
            if !isnothing(n) && n > 0
                push!(golden_nuggets, n)
            end
        end

        # Conjugate family
        conjugate_solutions = generate_from_conjugate(y0, k0, num_terms)
        for (y, k) in conjugate_solutions
            n = solution_to_n(y, k)
            if !isnothing(n) && n > 0
                push!(golden_nuggets, n)
            end
        end
    end

    # Sort and return first target_count
    sorted_nuggets = sort(collect(golden_nuggets))
    return sorted_nuggets[1:min(target_count, length(sorted_nuggets))]
end

function solve()
    nuggets = find_golden_nuggets(30)

    @info "Found 30 golden nuggets from Pell equation y² - 5k² = 44"
    @info "First few: $(nuggets[1:5])"
    @info "20th nugget: $(nuggets[20]) (as stated in problem)"
    @info "30th nugget: $(nuggets[30])"

    return sum(nuggets)
end

end # module
