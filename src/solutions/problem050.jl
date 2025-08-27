"""
Project Euler Problem 50: Consecutive Prime Sum

The prime 41, can be written as the sum of six consecutive primes:
41 = 2 + 3 + 5 + 7 + 11 + 13.

This is the longest sum of consecutive primes that adds to a prime below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21
terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most consecutive primes?

## Solution approach

Use cumulative sums for efficient range sum calculation. For each starting position,
try increasingly longer sequences of consecutive primes until the sum exceeds the limit.
Track the longest sequence that produces a prime sum.

The cumulative sum technique reduces computing sum of k consecutive primes from
O(k) to O(1) time per sum.

## Complexity analysis

Time complexity: O(π(N)² + N log log N)
- O(N log log N) to generate primes up to N using sieve
- O(π(N)²) to check all consecutive subsequences, where π(N) ≈ N/ln(N)

Space complexity: O(π(N))
- Store all primes and cumulative sums up to N
"""
module Problem050

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

"""
    find_longest_consecutive_prime_sum(limit)

Find the prime number below limit that can be written as the sum of the most consecutive primes.
Returns a tuple (prime, length) where length is the number of consecutive primes.

Uses a technique of cumulative sums to efficiently calculate the sum of any consecutive range of primes.
This reduces the computation of each sum from O(n) to O(1).

Search for the longest consecutive prime sum:
For each possible starting position in the list of primes
For each possible sequence length from that starting position
Calculate the sum of those consecutive primes
If the sum is below our limit and is itself a prime, update our records if this sequence is longer than our current best
"""
function find_longest_consecutive_prime_sum(limit)
    primes = sieve_of_eratosthenes(limit)
    prime_set = Set(primes)

    max_length = 0
    max_prime = 0

    # Calculate cumulative sums for efficient range summing
    # cum_sums[i] = sum of first i-1 primes
    cum_sums = [0]
    for prime in primes
        push!(cum_sums, cum_sums[end] + prime)
    end

    for start in 1:length(primes)
        # Early termination: if we can't improve max_length, we're done
        if length(primes) - start + 1 <= max_length
            break
        end

        for len in (max_length + 1):(length(primes) - start + 1)
            prime_sum = cum_sums[start + len] - cum_sums[start]

            if prime_sum >= limit
                break
            end

            if prime_sum in prime_set
                max_length = len
                max_prime = prime_sum
            end
        end
    end

    return max_prime, max_length
end

function solve()
    prime, length = find_longest_consecutive_prime_sum(1_000_000)
    @info "Found prime $prime as sum of $length consecutive primes"
    return prime
end

end # module
