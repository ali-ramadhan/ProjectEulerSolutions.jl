"""
Project Euler Problem 97: Large non-Mersenne prime

The first known prime found to exceed one million digits was discovered in 1999, and is
a Mersenne prime of the form 2^6972593 - 1;
it contains exactly 2,098,960 digits. Subsequently other Mersenne primes, of the form
2^p - 1, have been found which contain more digits.

However, in 2004, a massive non-Mersenne prime was discovered which contains 2,357,207
digits: 28433 × 2^7830457 + 1.

Find the last ten digits of this prime number.
"""
module Problem097

function solve()
    # We need to find the last 10 digits of 28433 × 2^7830457 + 1
    # This is equivalent to (28433 × 2^7830457 + 1) mod 10^10

    modulus = 10^10

    # Use modular exponentiation to compute 2^7830457 mod 10^10
    power_of_2 = powermod(2, 7830457, modulus)

    # Multiply by 28433 and add 1, all modulo 10^10
    result = (28433 * power_of_2 + 1) % modulus

    return result
end

end # module
