"""
Project Euler Problem 90: Cube digit pairs

Each of the six faces on a cube has a different digit (0 to 9) written on it; the same is
done to a second cube. By placing the two cubes side-by-side in different positions we can
form a variety of 2-digit numbers.

For example, the square number 64 could be formed:

In fact, by carefully choosing the digits on both cubes it is possible to display all of the
square numbers below one-hundred: 01, 04, 09, 16, 25, 36, 49, 64, and 81.

For example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9} on one cube and
{1, 2, 3, 4, 8, 9} on the other cube.

However, for this problem we shall allow the 6 and 9 to be turned upside-down so that an
arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7} would be considered to be the
same as the set {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 9, 8}.

In determining a distinct arrangement, we are interested in the digits on each cube, not the
order.

How many distinct arrangements of the two cubes allow for all of the square numbers to be
displayed?

## Solution approach

This is a combinatorial search problem with special equivalence rules:

1. Generate all possible cube combinations: C(10,6) ways to choose 6 digits from 0-9
2. For each pair of cubes, check if they can display all required squares: 01, 04, 09, 16,
   25, 36, 49, 64, 81
3. Handle 6/9 equivalence: treat any cube containing 6 or 9 as containing both
4. For each square XY, check if we can form it with either cube arrangement

The key insight is that squares can be formed in either orientation: cube1-cube2 or
cube2-cube1.

## Complexity analysis

Time complexity: O(C(10,6)²)
- Generate all cube pairs: C(10,6) = 210, so 210² = 44,100 pairs to check
- For each pair, verify 9 required squares in constant time
- Total: roughly 44,100 × 9 = ~400,000 operations

Space complexity: O(1)
- Fixed storage for cube combinations and square requirements
- No additional data structures that grow with input size

## Key insights

The 6/9 equivalence rule significantly affects the solution space. Rather than tracking
distinct physical arrangements, we must consider logical equivalence classes. This
combinatorial constraint satisfaction problem demonstrates how equivalence relations can
complicate seemingly straightforward counting problems.
"""
module Problem090

using Combinatorics

function normalize_cube(cube)
    """Normalize a cube by treating 6 and 9 as equivalent"""
    normalized = Set{Int}()
    for digit in cube
        if digit == 6 || digit == 9
            push!(normalized, 6)
            push!(normalized, 9)
        else
            push!(normalized, digit)
        end
    end
    return normalized
end

function can_form_number(cube1, cube2, tens, ones)
    """Check if two cubes can form a specific 2-digit number"""
    norm_cube1 = normalize_cube(cube1)
    norm_cube2 = normalize_cube(cube2)

    # Try both orientations: cube1-cube2 and cube2-cube1
    can_form_1 = (tens in norm_cube1 && ones in norm_cube2)
    can_form_2 = (tens in norm_cube2 && ones in norm_cube1)

    return can_form_1 || can_form_2
end

function can_form_all_numbers(cube1, cube2, numbers)
    """Check if two cubes can form all required numbers"""
    for (tens, ones) in numbers
        if !can_form_number(cube1, cube2, tens, ones)
            return false
        end
    end
    return true
end

function count_valid_cube_arrangements(numbers)
    """Count distinct cube arrangements that can display all given numbers"""
    digits = 0:9
    count = 0

    # Generate all possible combinations of 6 digits from 0-9 for each cube
    all_cubes = collect(combinations(digits, 6))

    # Check all pairs of cubes
    for i in 1:length(all_cubes)
        for j in i:length(all_cubes)  # j starts from i to avoid duplicates
            cube1 = all_cubes[i]
            cube2 = all_cubes[j]

            if can_form_all_numbers(cube1, cube2, numbers)
                count += 1
            end
        end
    end

    return count
end

function solve()
    """Count distinct cube arrangements that can display all square numbers"""
    squares = [(0, 1), (0, 4), (0, 9), (1, 6), (2, 5), (3, 6), (4, 9), (6, 4), (8, 1)]
    return count_valid_cube_arrangements(squares)
end

end # module
