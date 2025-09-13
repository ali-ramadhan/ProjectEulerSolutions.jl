"""
Project Euler Problem 43: Sub-string Divisibility

The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the
digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility
property.

Let d₁ be the 1st digit, d₂ be the 2nd digit, and so on. In this way, we note the following:

  - d₂d₃d₄=406 is divisible by 2
  - d₃d₄d₅=063 is divisible by 3
  - d₄d₅d₆=635 is divisible by 5
  - d₅d₆d₇=357 is divisible by 7
  - d₆d₇d₈=572 is divisible by 11
  - d₇d₈d₉=728 is divisible by 13
  - d₈d₉d₁₀=289 is divisible by 17

Find the sum of all 0 to 9 pandigital numbers with this property.

## Solution approach

Use backtracking to build valid 10-digit pandigital numbers digit by digit.
At each position, try all unused digits and check the substring divisibility
constraint for positions 4-10. This pruning eliminates invalid partial solutions early.

The constraints are checked as we build: for position p ≥ 4, the 3-digit substring
ending at position p must be divisible by the (p-3)th prime.

## Complexity analysis

Time complexity: O(10! × C)
- In worst case, explore all 10! permutations
- C is the average cost of divisibility checks during backtracking
- Early pruning significantly reduces the actual search space

Space complexity: O(10)
- Recursive call stack depth is at most 10
- Track used digits with boolean array of size 10
"""
module Problem0043

const DIVISORS = [2, 3, 5, 7, 11, 13, 17]

"""
    build_divisible_pandigitals(digits, used, position, result)

Recursively build 0-9 pandigital numbers that satisfy the substring divisibility properties.

Parameters:

  - digits: Current array of digits being built (length = position-1)
  - used: Boolean array tracking which digits (0-9) have been used
  - position: Current digit position being filled (1-10)
  - result: Array to collect valid pandigital numbers
"""
function build_divisible_pandigitals(digits, used, position, result)
    # Base case: if we've placed all 10 digits, we have a complete number
    if position > 10
        # Convert digit array to a single number
        number = 0
        for d in digits
            number = number * 10 + d
        end
        push!(result, number)
        return
    end

    # Try each unused digit at the current position
    for d in 0:9
        if used[d + 1]
            continue
        end

        # First digit can't be 0 for a 10-digit number
        if position == 1 && d == 0
            continue
        end

        # Check divisibility constraints for positions 4-10
        if position >= 4
            div_index = position - 3
            three_digit = 100 * digits[position - 2] + 10 * digits[position - 1] + d

            if three_digit % DIVISORS[div_index] != 0
                continue
            end
        end

        push!(digits, d)
        used[d + 1] = true

        build_divisible_pandigitals(digits, used, position + 1, result)

        pop!(digits)
        used[d + 1] = false
    end
end

"""
    find_special_pandigitals()

Find all 0-9 pandigital numbers that satisfy the substring divisibility property.
Returns a vector of such numbers.
"""
function find_special_pandigitals()
    result = Int[]
    digits = Int[]
    used = falses(10)

    build_divisible_pandigitals(digits, used, 1, result)

    return result
end

function solve()
    special_pandigitals = find_special_pandigitals()
    result = sum(special_pandigitals)
    @info "Found $(length(special_pandigitals)) pandigital numbers with substring " *
          "divisibility property"
    return result
end

end # module
