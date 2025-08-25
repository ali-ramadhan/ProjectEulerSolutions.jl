"""
Project Euler Problem 92: Square digit chains

A number chain is created by continuously adding the square of the digits in a number to
form a new number until it has been seen before.

For example,

44 → 32 → 13 → 10 → 1 → 1

85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What
is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?
"""
module Problem092

"""
    sum_square_digits(n)

Calculate the sum of squares of digits in number n.
"""
function sum_square_digits(n)
    sum = 0
    while n > 0
        digit = n % 10
        sum += digit * digit
        n ÷= 10
    end
    return sum
end

"""
    chain_endpoint(n)

Follow the square digit chain until reaching 1 or 89.
"""
function chain_endpoint(n)
    while n != 1 && n != 89
        n = sum_square_digits(n)
    end
    return n
end

"""
    multinomial_coefficient(digits, total_digits)

Calculate the multinomial coefficient for a given digit array.
Returns n!/(n₁!×n₂!×...×n₁₀!) where nᵢ is count of digit i.
Optimized for this specific use case.
"""
function multinomial_coefficient(digits, total_digits)
    # Count occurrences of each digit
    digit_counts = zeros(Int, 10)
    for d in digits
        digit_counts[d + 1] += 1
    end

    # Calculate multinomial coefficient efficiently
    coefficient = 1
    remaining = total_digits

    for count in digit_counts
        if count > 0
            # Compute binomial coefficient C(remaining, count)
            for i in 1:count
                coefficient = coefficient * remaining ÷ i
                remaining -= 1
            end
        end
    end

    return coefficient
end

"""
    generate_digit_combinations(num_digits)

Generate all unique combinations of digits with replacement.
Returns iterator over digit combinations in sorted order.
"""
function generate_digit_combinations(num_digits)
    combinations = Vector{Vector{Int}}()

    function generate_recursive(current_combo, remaining_digits, min_digit)
        if remaining_digits == 0
            push!(combinations, copy(current_combo))
            return
        end

        for digit in min_digit:9
            push!(current_combo, digit)
            generate_recursive(current_combo, remaining_digits - 1, digit)
            pop!(current_combo)
        end
    end

    generate_recursive(Int[], num_digits, 0)
    return combinations
end

"""
    count_unhappy_numbers(num_digits)

Count numbers with `num_digits` digits that arrive at 89 (unhappy numbers).
Uses multinomial coefficient approach for efficiency.

Note: Numbers that arrive at 1 are called "happy numbers",
those that arrive at 89 are "unhappy numbers".

Algorithm:

 1. Generate all unique digit combinations (sorted to avoid duplicates)
 2. For each combination, calculate sum of digit squares
 3. Check if that sum leads to 89 in the chain
 4. If yes, add the multinomial coefficient (number of permutations)
"""
function count_unhappy_numbers(num_digits)
    # Pre-compute maximum possible sum and which sums lead to 89
    max_sum = num_digits * 9^2
    ends_at_89 = Set{Int}()

    for n in 1:max_sum
        if chain_endpoint(n) == 89
            push!(ends_at_89, n)
        end
    end

    count = 0

    # Generate all unique digit combinations
    for digit_combo in generate_digit_combinations(num_digits)
        # Calculate sum of squares for this combination
        digit_sum = sum(d^2 for d in digit_combo)

        # If this sum leads to 89, count all its permutations
        if digit_sum in ends_at_89
            count += multinomial_coefficient(digit_combo, num_digits)
        end
    end

    return count
end

function solve()
    return count_unhappy_numbers(7)
end

end # module
