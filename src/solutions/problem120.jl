"""
Project Euler Problem 120: Square remainders

Let r be the remainder when (a-1)^n + (a+1)^n is divided by a^2.

For example, if a = 7 and n = 3, then r = 42: 6^3 + 8^3 = 728 ≡ 42 (mod 49). And as n
varies, so too will r, but for a = 7 it turns out that rmax = 42.

For 3 ≤ a ≤ 1000, find ∑ rmax.

## Solution approach

Using the binomial theorem, we can expand (a-1)^n + (a+1)^n:
- (a-1)^n = ∑(k=0 to n) C(n,k) * a^k * (-1)^(n-k)
- (a+1)^n = ∑(k=0 to n) C(n,k) * a^k * 1^(n-k)

Adding these expressions: (a-1)^n + (a+1)^n = ∑(k=0 to n) C(n,k) * a^k * [(-1)^(n-k) + 1]

The term [(-1)^(n-k) + 1] equals:
- 0 when n-k is odd (k and n have different parity)
- 2 when n-k is even (k and n have same parity)

When taken modulo a^2, only terms with k < 2 survive:
- For odd n: only k=1 contributes → r = 2na mod a^2
- For even n: only k=0 contributes → r = 2

To maximize r for odd n, we need the largest 2na < a^2, so n < a/2. The largest odd n < a/2
gives us the maximum remainder.

## Mathematical background

For odd a: The largest odd n < a/2 is (a-1)/2, giving rmax = 2 * (a-1)/2 * a = a(a-1) For
even a: The largest odd n < a/2 is (a-2)/2, giving rmax = 2 * (a-2)/2 * a = a(a-2)

Since even n always gives r = 2, and for reasonable values of a we have a(a-1) > 2 and
a(a-2) > 2, the maximum is always achieved with odd n.

## Complexity analysis

Time complexity: O(n) where n is the range of a values (1000-3+1 = 998)
- Single pass through all values of a from 3 to 1000

Space complexity: O(1)
- Only using constant extra space for calculations
"""
module Problem120

function calculate_max_remainder(a)
    if a % 2 == 1
        return a * (a - 1)
    else
        return a * (a - 2)
    end
end

function solve()
    total = 0
    for a in 3:1000
        total += calculate_max_remainder(a)
    end
    return total
end

end # module
