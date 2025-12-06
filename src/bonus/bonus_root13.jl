"""
Project Euler Bonus Problem: Root13

The decimal expansion of the square root of two is 1.4142135623730...

If we define S(n, d) to be the sum of the first d digits in the fractional part of the
decimal expansion of sqrt(n), it can be seen that S(2, 10) = 4 + 1 + 4 + ... + 3 = 31.

It can be confirmed that S(2, 100) = 481.

Find S(13, 1000).

Note: Instead of just using arbitrary precision floats, try to be creative with your method.

## The uncreative solution

We could use arbitrary precision floats to compute sqrt(n) with enough precision to get the
first d digits correct, then convert the fractional part to a string and sum the digits. We
need log2(10) bits to represent a base-10 digit, so adding an extra digit to be safe we need
(d + 1) * log2(10) bits of precision:

    function S_not_creative(n, d)
        precision_bits = ceil(Int, (d + 1) * log2(10))
        setprecision(BigFloat, precision_bits) do
            val = sqrt(big(n))
            frac_digits_str = split(string(val), '.')[2][1:d]
            return sum(parse(Int, c) for c in frac_digits_str)
        end
    end

But the problem wants us to be more creative...

## Going digit-by-digit

We can compute the integer square root of n using Julia's `isqrt` function. For n = 13 we
get 3, so sqrt(13) = 3.something.

To find the first decimal digit we look for the largest digit d1 such that (3.d1)^2 <= 13:

    (3 + d1/10)^2 <= 13  =>  d1(60 + d1) <= 400

Testing digits 0-9, we find d1 = 6 since 6*66 = 396 <= 400 but 7*67 = 469 > 400. So the
first decimal digit is 6, and sqrt(13) = 3.6something.

To find the second digit we look for the largest d2 such that (3.6d2)^2 <= 13:

    (3.6 + d2/100)^2 <= 13  =>  d2(720 + d2) <= 400

Testing digits, d2 = 0 since 0*720 = 0 <= 400 but 1*721 = 721 > 400. So sqrt(13) =
3.60something.

## The creative solution

Instead of tracking the quotient qk with k digits, we track a scaled integer version pk =
10^k * qk which is always a non-negative integer (p0 = 3, p1 = 36, p2 = 360).

We also track the scaled remainder Rk = 10^(2k) * n - pk^2, which represents the difference
between n and the square of our best quotient so far, scaled appropriately.

To find the next digit dk when we have quotient with k-1 digits, we need:

    (qk-1 + dk/10^k)^2 <= n  =>  (10*pk-1 + dk)^2 <= 10^(2k) * n

Expanding and rearranging:

    dk(20*pk-1 + dk) <= 10^(2k) * n - 100*pk-1^2 = 100*Rk-1

So starting with p0 = isqrt(n) and R0 = n - p0^2, we iteratively find the largest dk
satisfying the inequality, then update:

    pk = 10*pk-1 + dk
    Rk = 100*Rk-1 - dk(20*pk-1 + dk)

The second formula lets us compute Rk directly from leftovers without tracking k.

## Complexity analysis

Time complexity: O(d)
- We compute exactly d decimal digits, each requiring O(1) digit tests

Space complexity: O(d)
- We store all d digits in a vector (could be O(1) if we summed on the fly)
"""
module BonusRoot13

function compute_sqrt_digits(n, num_decimal_digits)
    integer_part = isqrt(n)

    R = BigInt(n - integer_part^2)
    p = BigInt(integer_part)

    digits = Int[]

    for _ in 1:num_decimal_digits
        R *= 100
        d = 0

        for digit in 0:9
            test_divisor = 20 * p + digit
            test_product = test_divisor * digit

            if test_product <= R
                d = digit
            else
                break
            end
        end

        divisor = 20 * p + d
        R -= divisor * d
        p = p * 10 + d

        push!(digits, d)
    end

    return digits
end

function sum_sqrt_decimal_digits(n, num_digits)
    digits = compute_sqrt_digits(n, num_digits)
    return sum(digits)
end

function solve()
    return sum_sqrt_decimal_digits(13, 1000)
end

end # module
