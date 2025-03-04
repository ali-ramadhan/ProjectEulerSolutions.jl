"""
Project Euler Problem 32: Pandigital Products

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once;
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand,
multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written
as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
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

Find all products whose multiplicand/multiplier/product identity can be written as a 1-9 pandigital.
This function checks two cases:
1. 1-digit × 4-digit = 4-digit
2. 2-digit × 3-digit = 4-digit

These are the only cases where the combined digits can sum to 9, which is required for a 1-9 pandigital.
Returns the sum of all such unique products.
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
