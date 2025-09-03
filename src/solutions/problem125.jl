"""
Project Euler Problem 125: Palindromic sums

The palindromic number 595 is interesting because it can be written as the sum of
consecutive squares: 6² + 7² + 8² + 9² + 10² + 11² + 12².

There are exactly eleven palindromes below one-thousand that can be written as consecutive
square sums, and the sum of these palindromes is 4164. Note that 1 = 0² + 1² has not been
included as this problem is concerned with the squares of positive integers.

Find the sum of all the numbers less than 10⁸ that are both palindromic and can be written
as the sum of consecutive squares.

## Solution approach

1. Generate all possible sums of consecutive squares by:
   - Starting from each positive integer k
   - Computing sums k² + (k+1)² + ... + (k+n)² for increasing values of n
   - Stopping when the sum exceeds 10⁸

2. For each sum, check if it's a palindrome using the existing `is_palindrome` function

3. Use a Set to collect unique palindromic sums to avoid double-counting (different
   consecutive sequences might produce the same sum)

4. Return the sum of all unique palindromes found

The key insight is that we need at least 2 consecutive squares (since the problem excludes 1
= 0² + 1²), and we can optimize by noting that once a sum exceeds our limit, all subsequent
sums in that sequence will also exceed it.

## Complexity analysis

Time complexity: O(n√n) where n = 10⁸
- For each starting point k (up to √n), we check consecutive sums until exceeding the limit
- Each palindrome check is O(log n) for the number of digits

Space complexity: O(m) where m is the number of unique palindromes found
- We store palindromes in a Set to avoid duplicates
"""
module Problem125

using ProjectEulerSolutions.Utils.Digits: is_palindrome

function find_palindromic_consecutive_square_sums(limit)
    palindromes = Set{Int}()

    # Start from 1, but we need at least 2 consecutive squares
    k = 1
    while k * k < limit
        sum_squares = k * k
        n = k + 1

        # Add consecutive squares starting from k
        while true
            sum_squares += n * n

            # Stop if sum exceeds limit
            if sum_squares >= limit
                break
            end

            # Check if this sum is a palindrome (and we have at least 2 squares)
            if n > k && is_palindrome(sum_squares)
                push!(palindromes, sum_squares)
            end

            n += 1
        end

        k += 1
    end

    return palindromes
end

function solve()
    limit = 100_000_000  # 10^8
    palindromes = find_palindromic_consecutive_square_sums(limit)

    result = sum(palindromes)

    @info "Found $(length(palindromes)) unique palindromic consecutive square sums"

    return result
end

end # module
