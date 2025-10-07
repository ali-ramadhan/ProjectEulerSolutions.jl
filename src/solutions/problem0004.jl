"""
Project Euler Problem 4: Largest Palindrome Product

A palindromic number reads the same both ways.
The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 * 99.

Find the largest palindrome made from the product of two 3-digit numbers.

## Solution approach

Search through all products of n-digit numbers in descending order to find the largest
palindrome. Two key optimizations:
  1. Iterate from largest to smallest values to find the maximum quickly, and
  2. Use early termination when remaining products cannot exceed the current maximum.

## Complexity analysis

Time complexity: O(R²) where R = upper_limit - lower_limit + 1
- The outer loop iterates through R numbers from upper_limit down to lower_limit
- The inner loop iterates from upper_limit down to i, averaging R/2 iterations
- Total iterations: approximately R²/2 in the worst case
- Early termination conditions significantly reduce actual work in practice:
  * Break when i × upper_limit < max_palindrome (outer loop)
  * Break when i × j < max_palindrome (inner loop)
  * Continue when product ≥ max_product (if constraint is provided)
- For the original problem (100 to 999), R = 900, giving ~405,000 maximum iterations

Space complexity: O(1)
- Uses constant space for variables: max_palindrome, best_i, best_j, loop counters
- The `is_palindrome` helper uses O(1) space with mathematical digit reversal
- No data structures that grow with input size
"""
module Problem0004

using ProjectEulerSolutions.Utils.Digits: is_palindrome

function largest_palindrome_product(lower_limit, upper_limit; max_product=nothing)
    T = typeof(upper_limit)
    max_palindrome = zero(T)
    best_i, best_j = zero(T), zero(T)

    for i in upper_limit:-1:lower_limit
        # break early if we can't find a larger palindrome
        if i * upper_limit < max_palindrome
            break
        end

        # Start from j=i to avoid duplicate combinations
        for j in upper_limit:-1:i
            product = i * j

            # Skip if product exceeds max_product constraint
            if !isnothing(max_product) && product >= max_product
                continue
            end

            if product < max_palindrome
                break
            end

            if is_palindrome(product) && product > max_palindrome
                max_palindrome = product
                best_i, best_j = i, j
            end
        end
    end

    return (palindrome=max_palindrome, factors=(best_i, best_j))
end

function solve()
    result = largest_palindrome_product(100, 999)
    @info "Found largest palindrome from 3-digit products: $(result.palindrome) = " *
          "$(result.factors[1]) × $(result.factors[2])"
    return result.palindrome
end

end # module
