"""
Project Euler Problem 32: Pandigital Products

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n
exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand,
multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written
as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once
in your sum.

## Solution approach

We need to find all products where the concatenation of multiplicand, multiplier, and
product forms a 1-9 pandigital number (using digits 1-9 exactly once). Since we need exactly
9 digits total, we can determine the possible cases by analyzing digit distributions:

- Case 1: 1-digit × 4-digit = 4-digit (1 + 4 + 4 = 9 digits)
- Case 2: 2-digit × 3-digit = 4-digit (2 + 3 + 4 = 9 digits)

These are the only two cases that can produce exactly 9 digits. We iterate through all
possible combinations in these ranges and check if the concatenated string is pandigital. We
use a Set to store unique products since the same product can be obtained multiple ways.

## Complexity analysis

Time complexity: O(n × m)
- Where n ≈ 9,000 combinations for case 1 (9 × 1,000) and m ≈ 90,000 for case 2 (90 × 1,000)
- For each combination, we perform constant-time string operations and pandigital checking
- Total: O(100,000) operations approximately

Space complexity: O(k)
- Where k is the number of unique pandigital products (small constant)
- We store products in a Set and perform string concatenations of fixed length (9
  characters)
"""
module Problem032

"""
    is_pandigital_product(a, b, c)

Check if the concatenation of a, b, and c forms a 1-9 pandigital number.
"""
function is_pandigital_product(a, b, c)
    combined = string(a) * string(b) * string(c)
    return length(combined) == 9 && join(sort(collect(combined))) == "123456789"
end

"""
    find_pandigital_products()

Find all products whose multiplicand/multiplier/product identity can be written as a 1-9
pandigital. Returns the sum of all such unique products.
"""
function find_pandigital_products()
    products = Set{Int}()

    # Case 1: 1-digit × 4-digit = 4-digit
    for a in 1:9
        for b in 1000:9999
            c = a * b
            if 1000 <= c <= 9999 && is_pandigital_product(a, b, c)
                push!(products, c)
            end
        end
    end

    # Case 2: 2-digit × 3-digit = 4-digit
    for a in 10:99
        for b in 100:999
            c = a * b
            if 1000 <= c <= 9999 && is_pandigital_product(a, b, c)
                push!(products, c)
            end
        end
    end

    return sum(products)
end

function solve()
    return find_pandigital_products()
end

end # module
