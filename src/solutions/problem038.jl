"""
Project Euler Problem 38: Pandigital Multiples

Take the number 192 and multiply it by each of 1, 2, and 3:
192 × 1 = 192
192 × 2 = 384
192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3).

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ..., n) where n > 1?
"""
module Problem038

"""
    is_pandigital(s)

Check if a string `s` contains all the digits 1-9 exactly once.
"""
function is_pandigital(s)
    length(s) == 9 && Set(s) == Set('1':'9')
end

"""
    find_largest_pandigital_multiple()

Find the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product
of an integer with (1,2, ..., n) where n > 1.

For each number x from 1 to 9999, calculate the concatenated product with consecutive integers
starting from 1 and check if it's pandigital.

We only need to check numbers up to 9999
A 5-digit number would already produce a concatenation > 9 digits with n ≥ 2
"""
function find_largest_pandigital_multiple()
    max_pandigital = 0

    for x in 1:9999
        concat_prod = ""
        for n in 1:9
            concat_prod *= string(x * n)

            # Break if the concatenated product exceeds 9 digits
            if length(concat_prod) > 9
                break
            end

            # Check if it's a 9-digit number, n > 1, and pandigital
            if n > 1 && length(concat_prod) == 9 && is_pandigital(concat_prod)
                prod_value = parse(Int, concat_prod)
                if prod_value > max_pandigital
                    max_pandigital = prod_value
                end
            end
        end
    end

    return max_pandigital
end

function solve()
    return find_largest_pandigital_multiple()
end

end # module
