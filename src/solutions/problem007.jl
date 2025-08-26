"""
Project Euler Problem 7: 10001st Prime

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th
prime is 13.

What is the 10,001st prime number?

## Solution approach

Use the `is_prime` utility function from Utils.Primes, which efficiently checks if a number
is prime using trial division with 6k±1 optimization. Keep a count of primes found and
check if it's prime using the is_prime utility function. Keep a count of primes found and
return the number when we've found the nth prime.

## Complexity analysis

Time complexity: O(n * sqrt(p_n))
- We check roughly n * ln(n) numbers for primality (by the Prime Number Theorem)
- Each primality check takes O(sqrt(k)) time for number k
- The nth prime p_n is approximately n * ln(n), so sqrt(p_n) ≈ sqrt(n * ln(n))

Space complexity: O(1)
- Only uses a constant amount of extra space for counters and variables
"""
module Problem007

using ProjectEulerSolutions.Utils.Primes: is_prime

function find_nth_prime(n)
    count = 0
    num = 1

    while count < n
        num += 1
        if is_prime(num)
            count += 1
        end
    end

    return num
end

function solve()
    return find_nth_prime(10001)
end

end # module
