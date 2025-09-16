"""
Project Euler Problem 130: Composites with prime repunit property

A number consisting entirely of ones is called a repunit. We shall define R(k) to be a
repunit of length k; for example, R(6) = 111111.

Given that n is a positive integer and gcd(n, 10) = 1, it can be shown that there always
exists a value, k, for which R(k) is divisible by n, and let A(n) be the least such value
of k; for example, A(7) = 6 and A(41) = 5.

You are given that for all primes, p > 5, that p - 1 is divisible by A(p). For example,
when p = 41, A(41) = 5, and 40 is divisible by 5.

However, there are rare composite values for which this is also true; the first five
examples being 91, 259, 451, 481, and 703.

Find the sum of the first twenty-five composite values of n for which gcd(n, 10) = 1 and
n - 1 is divisible by A(n).

## Solution approach

We need to find composite numbers n where:
1. gcd(n, 10) = 1 (n is odd and not divisible by 5)
2. (n - 1) is divisible by A(n)
3. n is composite (not prime)

We can reuse the compute_A function from Problem 129 to calculate A(n). For each candidate
n, we check if it's composite, then compute A(n) and verify the divisibility condition.

Since we know the first example is 91, we can start our search from there and check only
odd numbers not divisible by 5.

## Complexity analysis

Time complexity: O(k * n * A(n)) where k=25 and n is the 25th composite number
- For each of the ~25 numbers we find, we need O(A(n)) time to compute A(n)
- We also need to check primality for each candidate, which is O(√n)

Space complexity: O(1)
- Only constant space for calculations and collecting results

## Key insights

This problem extends the prime repunit property to composite numbers. While all primes p > 5
satisfy this property by Fermat's Little Theorem, only rare composite numbers do. The search
can be optimized by starting from known examples and checking only valid candidates.
"""
module Problem0130

using ProjectEulerSolutions.Utils.Primes: is_prime
using ProjectEulerSolutions.Problem0129: compute_A

"""
    find_composite_repunit_numbers(count)

Find the first `count` composite numbers n where gcd(n, 10) = 1 and (n - 1) is divisible by
A(n).
"""
function find_composite_repunit_numbers(count)
    results = Int[]
    n = 91  # Start from first known example

    while length(results) < count
        # Only check odd numbers not divisible by 5 (gcd(n, 10) = 1)
        if n % 5 != 0 && !is_prime(n)
            a_n = compute_A(n)
            if (n - 1) % a_n == 0
                push!(results, n)
                @info "Found composite repunit number: $n, A($n) = $a_n"
            end
        end

        n += 2  # Only check odd numbers
        if n % 5 == 0
            n += 2  # Skip numbers divisible by 5
        end
    end

    return results
end

function solve()
    numbers = find_composite_repunit_numbers(25)
    return sum(numbers)
end

end # module
