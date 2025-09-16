"""
Project Euler Problem 129: Repunit Divisibility

A number consisting entirely of ones is called a repunit. We shall define R(k) to be a
repunit of length k; for example, R(6) = 111111.

Given that n is a positive integer and gcd(n, 10) = 1, it can be shown that there always
exists a value, k, for which R(k) is divisible by n, and let A(n) be the least such value of
k; for example, A(7) = 6 and A(41) = 5.

The least value of n for which A(n) first exceeds ten is 17.

Find the least value of n for which A(n) first exceeds one-million.

## Solution approach

A repunit R(k) = 111...1 (k ones) = (10^k - 1) / 9. For R(k) to be divisible by n where
gcd(n,10) = 1, we need R(k) ≡ 0 (mod n).

The key insight is that A(n) is the multiplicative order of 10 modulo n. However, we can
compute it more directly by building the repunit iteratively:
- Start with remainder = 1 (representing R(1) = 1)
- For each subsequent k, remainder = (10 * remainder + 1) mod n
- Continue until remainder = 0

To find the first n where A(n) > 1,000,000, we search starting from n = 1,000,001 (since
A(n) > n is impossible), checking only odd numbers not divisible by 5 (to ensure gcd(n,10) =
1).

## Complexity analysis

Time complexity: O(n * A(n)) where n is the answer
- For each candidate n, computing A(n) takes O(A(n)) time
- The search continues until we find n with A(n) > 1,000,000

Space complexity: O(1)
- Only constant space for calculations

## Key insights

The multiplicative order A(n) can be computed efficiently by iteratively building R(k) mod n
rather than computing large powers of 10. This avoids overflow issues and is more direct
than using modular exponentiation.
"""
module Problem0129

"""
    compute_A(n)

Compute A(n), the smallest positive integer k such that R(k) is divisible by n. R(k) is a
repunit with k digits (all ones). Requires gcd(n, 10) = 1.
"""
function compute_A(n)
    remainder = 1 % n  # R(1) = 1
    k = 1

    while remainder != 0
        k += 1
        remainder = (10 * remainder + 1) % n  # Build R(k) mod n
    end

    return k
end

"""
    find_first_exceeding(target)

Find the smallest n where A(n) first exceeds the target value.
Only considers n where gcd(n, 10) = 1.
"""
function find_first_exceeding(target)
    # Start searching from target + 1, since A(n) ≤ n for most cases
    n = target + 1

    # Ensure n is odd and not divisible by 5 (so gcd(n,10) = 1)
    if n % 2 == 0
        n += 1
    end
    if n % 5 == 0
        n += 2  # Skip to next odd number not divisible by 5
    end

    while true
        if n % 5 != 0  # Ensure gcd(n, 10) = 1
            a_n = compute_A(n)
            @info "A($n) = $a_n"

            if a_n > target
                return n
            end
        end

        n += 2  # Only check odd numbers
        if n % 5 == 0
            n += 2  # Skip numbers divisible by 5
        end
    end
end

function solve()
    return find_first_exceeding(1_000_000)
end

end # module
