"""
Project Euler Problem 110: Diophantine reciprocals II

In the following equation x, y, and n are positive integers.
1/x + 1/y = 1/n

For n = 4 there are exactly three distinct solutions:
1/5 + 1/20 = 1/4
1/6 + 1/12 = 1/4
1/8 + 1/8 = 1/4

What is the least value of n for which the number of distinct solutions exceeds four
million?

## Mathematical foundation

Starting with 1/x + 1/y = 1/n, we can derive that (x-n)(y-n) = n².
This means we need to find pairs of divisors (d₁, d₂) of n² where d₁ × d₂ = n².
The number of distinct solutions is (τ(n²) + 1)/2, where τ(n²) is the divisor count of n².

For n with prime factorization n = p₁^a₁ × p₂^a₂ × ... × pₖ^aₖ:
- n² = p₁^(2a₁) × p₂^(2a₂) × ... × pₖ^(2aₖ)
- τ(n²) = (2a₁ + 1)(2a₂ + 1)...(2aₖ + 1)

We need (τ(n²) + 1)/2 > 4,000,000, so τ(n²) > 7,999,999.

## Solution approach

The key insight is that the optimal n will be highly composite with many small prime
factors. Rather than testing every integer sequentially (which is too slow), we use
recursive search with intelligent pruning.

Algorithm steps:
1. Build systematically: Construct n from prime factorizations n = 2^a₁ × 3^a₂ × 5^a₃ × ...
2. Recursive exploration: For each prime position, try different exponents (0, 1, 2, ...)
3. Smart pruning:
   - Skip branches where current n already exceeds our best candidate
   - Limit maximum exponents based on position (smaller primes get higher powers)
   - Calculate remaining divisor target and prune impossible branches
4. Greedy optimization: Always update our best solution when we find a better one

Why this works:
- The optimal n heavily favors small primes with high exponents
- We explore in a systematic way that naturally finds smaller solutions first
- Pruning eliminates vast search spaces that can't improve our answer

Exponent strategy:
- First prime (2): Can have very high exponents (up to 50)
- Early primes (3,5,7,11,13): Decreasing exponent limits
- Later primes: Lower exponent limits to avoid explosion

## Complexity analysis

Time complexity: O(E^P) where E is average exponent tried and P is number of primes
- With pruning, this becomes much more manageable
- Exponential in worst case but pruning makes it practical

Space complexity: O(P) for the recursion stack depth

## Key insights

1. Highly composite preference: Solutions favor many small prime factors over fewer large
   ones
2. Exponential vs linear: Building from prime powers is exponentially faster than linear
   search
3. Pruning effectiveness: Most of the search space can be eliminated early
4. Mathematical structure: The divisor function's multiplicative property enables efficient
   computation
"""
module Problem110

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes


"""
    recursive_search(primes, prime_idx, current_n, remaining_target, max_exp_allowed, best_n)

Recursively search for the minimum n with pruning optimization. Returns the best n found.
"""
function recursive_search(primes, prime_idx, current_n, remaining_target, max_exp_allowed, best_n)
    if prime_idx > length(primes) || remaining_target <= 1
        if remaining_target <= 1 && current_n < best_n
            @info "Found candidate: n = $current_n"
            return current_n
        end
        return best_n
    end

    if current_n >= best_n
        return best_n
    end

    p = big(primes[prime_idx])

    # Try different exponents, but be smart about the maximum
    max_exp = min(max_exp_allowed, Int(floor(log(best_n / current_n) / log(p))))

    for exp in 0:max_exp
        new_n = current_n * p^exp
        if new_n >= best_n
            break
        end

        factor_contribution = 2 * exp + 1
        new_target = ceil(Int, remaining_target / factor_contribution)

        # Determine maximum exponent for next prime
        next_max_exp = if prime_idx == 1
            50  # First prime can have high exponent
        elseif prime_idx <= 5
            min(exp + 1, 20)  # Decreasing exponents
        else
            min(exp, 10)
        end

        best_n = recursive_search(primes, prime_idx + 1, new_n, new_target, next_max_exp, best_n)
    end

    return best_n
end

"""
    find_n_with_solutions_exceeding(target)

Find the smallest n where the number of distinct solutions to 1/x + 1/y = 1/n
exceeds the target, using recursive search approach.
"""
function find_n_with_solutions_exceeding(target)
    target_divisors = 2 * target - 1
    @info "Searching for n where τ(n²) > $target_divisors (solutions > $target)"

    # For large targets like 4 million, use a more sophisticated approach
    # The optimal n will have many small prime factors
    primes = sieve_of_eratosthenes(100)

    # Start the search with a high initial bound
    best_n = recursive_search(primes, 1, big(1), target_divisors, 50, big(10)^20)

    if best_n >= big(10)^20
        error("Could not find solution for target $target")
    end

    @info "Found minimum n = $best_n"
    return best_n
end

function solve()
    return find_n_with_solutions_exceeding(4_000_000)
end

end # module
