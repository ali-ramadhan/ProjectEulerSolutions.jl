"""
Project Euler Problem 38: Pandigital Multiples

Take the number 192 and multiply it by each of 1, 2, and 3:
192 × 1 = 192
192 × 2 = 384
192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call
192384576 the concatenated product of 192 and (1,2,3).

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the
pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated
product of an integer with (1,2, ..., n) where n > 1?

## Solution approach

We need to find the largest 9-digit pandigital number formed by concatenating products of an
integer with consecutive integers starting from 1, where we use at least 2 multipliers (n >
1).

Key insight: Since we need exactly 9 digits and n > 1, we can determine the search bounds:
- If we start with a 5-digit number, multiplying by 1 and 2 gives us 5 + 5 = 10 digits (too
  many)
- Therefore, we only need to check numbers up to 9999

For each integer x from 1 to 9999:
1. Multiply x by 1, 2, 3, ... and concatenate the results
2. Stop when the concatenation exceeds 9 digits
3. Check if we have exactly 9 digits with n > 1 and the string is pandigital (uses digits
   1-9 exactly once)
4. Track the maximum such number found

## Complexity analysis

Time complexity: O(n × k)
- Where n = 9999 (our search range) and k is the average number of multipliers needed (small
  constant ≤ 9)
- For each number, we perform at most 9 multiplications and concatenations
- Pandigital checking is O(9) = O(1) for each valid concatenation
- Total: approximately O(9999 × 9) = O(90,000) operations

Space complexity: O(d)
- Where d = 9 (maximum digits in our concatenated strings)
- We store temporary string concatenations and the maximum pandigital found
- Space usage is constant regardless of search range
"""
module Problem038

"""
    is_pandigital(s)

Check if a string `s` contains all the digits 1-9 exactly once.
"""
function is_pandigital(s)
    return length(s) == 9 && Set(s) == Set('1':'9')
end

"""
    find_largest_pandigital_multiple()

Find the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product
of an integer with (1,2, ..., n) where n > 1.
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
    result = find_largest_pandigital_multiple()
    @info "Largest pandigital multiple found: $result"
    return result
end

end # module
