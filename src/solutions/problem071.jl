"""
Project Euler Problem 71: Ordered Fractions

Consider the fraction, n/d, where n and d are positive integers. If n < d and HCF(n,d)=1, it
is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5,
5/6, 6/7, 7/8

It can be seen that 2/5 is the fraction immediately to the left of 3/7.

By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size,
find the numerator of the fraction immediately to the left of 3/7.

## Solution approach

This problem leverages properties of the Farey sequence. In the Farey sequence F_n, if two
fractions a/b and c/d are adjacent, then bc - ad = 1.

For any target fraction target_num/target_den, if n/d is the fraction immediately to its
left:
target_num × d - target_den × n = 1

Solving for n: n = (target_num × d - 1) / target_den

For n to be an integer, we need target_num × d ≡ 1 (mod target_den). This means d must be
congruent to the modular inverse of target_num modulo target_den. We find the largest such
d ≤ max_denominator using modular arithmetic.

## Complexity analysis

Time complexity: O(1)
- Direct calculation using modular arithmetic properties

Space complexity: O(1)
- Only stores a few variables
"""
module Problem071

"""
    find_numerator_left_of_target(target_num, target_den, max_denominator)

Find the numerator of the reduced proper fraction immediately to the left of
target_num/target_den when listing all reduced proper fractions with denominator ≤
max_denominator in ascending order.

Returns (numerator, denominator) of the adjacent fraction.
"""
function find_numerator_left_of_target(target_num, target_den, max_denominator)
    # Find modular inverse to determine the congruence class for valid denominators
    inv = invmod(target_num, target_den)

    # Find the largest denominator in the correct congruence class
    max_k = (max_denominator - inv) ÷ target_den
    max_d = target_den * max_k + inv

    # Calculate corresponding numerator
    n = (target_num * max_d - 1) ÷ target_den

    return n, max_d
end

function solve()
    numerator, denominator = find_numerator_left_of_target(3, 7, 1_000_000)
    @info "Found fraction $numerator/$denominator immediately to the left of 3/7 in " *
          "the Farey sequence"
    return numerator
end

end # module
