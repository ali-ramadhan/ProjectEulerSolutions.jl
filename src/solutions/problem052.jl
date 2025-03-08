"""
Project Euler Problem 52: Permuted Multiples

It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits,
but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
"""
module Problem052

"""
    has_same_digits(n, multipliers)

Check if a number n and its multiples (n * m for m in multipliers) all have the same set of digits.
Uses a frequency counting approach rather than sorting for efficiency.
"""
function has_same_digits(n, multipliers)
    n_str = string(n)

    base_counts = zeros(Int, 10)
    for c in n_str
        digit = parse(Int, c)
        base_counts[digit + 1] += 1
    end

    for m in multipliers
        product = m * n
        product_str = string(product)

        # If the product has a different number of digits, it can't be a permutation
        if length(product_str) != length(n_str)
            return false
        end

        # Count frequencies of digits in the product
        product_counts = zeros(Int, 10)
        for c in product_str
            digit = parse(Int, c)
            product_counts[digit + 1] += 1
        end

        if base_counts != product_counts
            return false
        end
    end

    return true
end

"""
    find_permuted_multiples()

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x all contain the same digits.
Uses mathematical constraints to optimize the search space.
"""
function find_permuted_multiples(multipliers)
    # Start checking from 2-digit numbers (no 1-digit solution is possible)
    n_digits = 2
    while true
        lower_bound = 10^(n_digits - 1)

        # Upper bound to ensure all multiples have n digits
        # For 6x to have the same number of digits as x, we need 6x < 10^n
        upper_bound = div(10^n_digits - 1, 6)

        for x in lower_bound:upper_bound
            if has_same_digits(x, multipliers)
                return x
            end
        end

        n_digits += 1
    end
end

function solve()
    return find_permuted_multiples(2:6)
end

end # module
