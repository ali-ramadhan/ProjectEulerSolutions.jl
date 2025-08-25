"""
Project Euler Problem 71: Ordered Fractions

Consider the fraction, n/d, where n and d are positive integers. If n < d and HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that 2/5 is the fraction immediately to the left of 3/7.

By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.
"""
module Problem071

"""
    find_numerator_left_of_target(target_num, target_den, max_denominator)

Find the numerator of the reduced proper fraction immediately to the left of target_num/target_den
when listing all reduced proper fractions with denominator ≤ max_denominator in ascending order.

Uses properties of the Farey sequence: if a/b and c/d are adjacent fractions in the sequence,
then bc - ad = 1. For our problem, if n/d is immediately to the left of 3/7, then 3d - 7n = 1.

From the property of adjacent fractions in the Farey sequence,
if n/d is immediately to the left of 3/7, then 3d - 7n = 1
Solving for n: n = (3d - 1) / 7

For n to be an integer, 3d - 1 must be divisible by 7
This means d must be of the form 7k + 5 (since 3*(7k+5) - 1 = 21k + 15 - 1 = 21k + 14 = 7*(3k+2))
"""
function find_numerator_left_of_target(target_num, target_den, max_denominator)
    # Find the largest denominator d ≤ max_denominator such that d ≡ 5 (mod 7)
    max_k = (max_denominator - 5) ÷ 7
    max_d = 7 * max_k + 5

    # Calculate the corresponding numerator
    n = (3 * max_d - 1) ÷ 7

    # Verify our solution satisfies the property
    @assert target_num * max_d - target_den * n == 1

    return n
end

function solve()
    return find_numerator_left_of_target(3, 7, 1_000_000)
end

end # module
