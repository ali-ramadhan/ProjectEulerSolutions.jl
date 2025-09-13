"""
Project Euler Problem 123: Prime square remainders

Let p_n be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder when
(p_n-1)^n + (p_n+1)^n is divided by p_n^2.

For example, when n = 3, p_3 = 5, and 4^3 + 6^3 = 280 ≡ 5 (mod 25).

The least value of n for which the remainder first exceeds 10^9 is 7037.

Find the least value of n for which the remainder first exceeds 10^10.

## Solution approach

Using the binomial theorem, we can expand (p_n-1)^n + (p_n+1)^n:
- (p_n-1)^n = ∑(k=0 to n) C(n,k) * p_n^k * (-1)^(n-k)
- (p_n+1)^n = ∑(k=0 to n) C(n,k) * p_n^k * 1^(n-k)

Adding these expressions:

(p_n-1)^n + (p_n+1)^n = ∑(k=0 to n) C(n,k) * p_n^k * [(-1)^(n-k) + 1]

The term [(-1)^(n-k) + 1] equals:
- 0 when n-k is odd (k and n have different parity)
- 2 when n-k is even (k and n have same parity)

When taken modulo p_n^2, only terms with k < 2 survive:
- For odd n: only k=1 contributes → r = 2n*p_n mod p_n^2
- For even n: only k=0 contributes → r = 2

Since we want large remainders (> 10^10), we focus on odd n values where r = 2n*p_n. For odd
n, when 2n*p_n < p_n^2 (i.e., n < p_n/2), the remainder is exactly 2n*p_n.

## Complexity analysis

Time complexity: O(n log log p_n) where p_n is the nth prime
- Uses sieve of Eratosthenes to generate primes up to required limit
- Linear scan through odd n values until condition is met

Space complexity: O(p_n)
- Stores prime numbers up to the nth prime needed

## Key insights

For large n, we expect p_n ≈ n ln(n) by the prime number theorem, so:
- The remainder for odd n is approximately 2n² ln(n)
- We need 2n² ln(n) > 10^10, so n is roughly around √(10^10 / (2 ln(n))) ≈ few thousand
- This matches the given hint that n=7037 exceeds 10^9
"""
module Problem0123

using ..Utils.Primes: sieve_of_eratosthenes

function calculate_remainder(n, p_n)
    if n % 2 == 0
        return 2
    else
        return 2 * n * p_n
    end
end

function solve()
    # Generate primes up to a reasonable limit
    # We expect the answer to be around 20000-30000 based on the pattern
    # p_30000 ≈ 350000, so we generate primes up to 400000 to be safe
    primes = sieve_of_eratosthenes(400000)

    target = 10^10

    # Start from n=7037 since we know that's where it first exceeds 10^9
    # and we're looking for 10^10
    for n in 7037:2:length(primes)  # Only check odd n values
        if n > length(primes)
            break
        end

        p_n = primes[n]
        remainder = calculate_remainder(n, p_n)

        if remainder > target
            @info "Found solution: n=$n, p_n=$p_n, remainder=$remainder"
            return n
        end
    end

    error("Solution not found within prime limit. Increase prime generation limit.")
end

end # module
