"""
Project Euler Problem 111: Primes with runs

Considering 4-digit primes containing repeated digits it is clear that they cannot all be the
same: 1111 is divisible by 11, 2222 is divisible by 11 and 2, 3333 is divisible by 3, etc.
But there are nine 4-digit primes containing three ones:
1117, 1151, 1171, 1181, 1511, 1811, 2111, 4111, 8111

We shall define M(n, d) to be the maximum number of repeated digits for an n-digit prime
where d is the repeated digit, N(n, d) to be the number of such primes, and S(n, d) to be
the sum of these primes.

So M(4, 1) = 3, N(4, 1) = 9, and S(4, 1) = 22275. It turns out that for d = 0, it is only
possible to have M(4, 0) = 2, and there are N(4, 0) = 13 such primes, and S(4, 0) = 67061.

For d = 0 to 9, the sum of all S(4, d) is 273700.

Find the sum of all S(10, d).

## Solution approach

For each digit d from 0 to 9, we need to find the maximum number of times d can appear in
a 10-digit prime (M(10,d)), then find all such primes and sum them.

The approach is:
1. For each digit d, start with M = 9 (maximum possible repeated digits)
2. Generate all 10-digit numbers with exactly M occurrences of digit d
3. Test each for primality
4. If no primes found, decrease M and try again
5. Sum all primes found for the maximum M value

For generation, we:
- Choose positions for the M repeated digits
- Fill remaining positions with other digits (avoiding leading zeros)
- Use efficient primality test from Utils.Primes

## Complexity analysis

Time complexity: O(C(10,M) × 9^(10-M) × √N) where:
- C(10,M) is combinations for placing repeated digits
- 9^(10-M) is choices for non-repeated positions
- √N is trial division primality test cost for 10-digit numbers

Space complexity: O(1) - only storing candidates one at a time

## Key insights

1. Most digits will have M(10,d) = 8 or 9 due to the large search space
2. Digit 0 is special - it cannot be the leading digit
3. Trial division primality test handles 10-digit numbers efficiently
4. We can skip even numbers (except when d=2) and multiples of 5 (except when d=5)
"""
module Problem0111

using ProjectEulerSolutions.Utils.Primes: is_prime
using Combinatorics: combinations


"""
    generate_numbers_with_repeated_digit(digit, count, total_length)

Generate all numbers of length total_length that contain exactly count occurrences
of the given digit. Optimized with last digit constraint for non-prime ending digits.
Returns an array of unique integers.
"""
function generate_numbers_with_repeated_digit(digit, count, total_length)
    if digit in [0, 2, 4, 5, 6, 8]
        # For non-prime ending digits, apply last digit constraint
        return generate_with_last_digit_constraint(digit, count, total_length)
    else
        # For prime-ending digits (1,3,7,9), use standard generation
        return generate_standard(digit, count, total_length)
    end
end

"""
    generate_with_last_digit_constraint(digit, count, total_length)

Generate numbers with the constraint that the last digit must be in {1,3,7,9}.
Used for digits that cannot be the last digit of a prime.
"""
function generate_with_last_digit_constraint(digit, count, total_length)
    numbers = Int[]
    positions = 1:total_length
    prime_ending_digits = [1, 3, 7, 9]
    
    for pos_combo in combinations(positions, count)
        # Last position cannot contain the repeated digit if it's not prime-ending
        if total_length in pos_combo
            continue
        end
        
        non_repeated_positions = setdiff(positions, pos_combo)
        num_non_repeated = length(non_repeated_positions)
        
        if num_non_repeated == 0
            continue
        end
        
        # Available digits for non-repeated positions (0-9 except the repeated digit)
        available_digits = [d for d in 0:9 if d != digit]
        
        # Last position index in non_repeated_positions
        last_pos_idx = findfirst(==(total_length), non_repeated_positions)
        
        for digit_assignment in Iterators.product(fill(available_digits, num_non_repeated)...)
            # Construct the full number
            digits_arr = fill(digit, total_length)
            for (i, pos) in enumerate(non_repeated_positions)
                digits_arr[pos] = digit_assignment[i]
            end
            
            # Skip numbers with leading zeros
            if digits_arr[1] == 0
                continue
            end
            
            # Ensure last digit is in {1,3,7,9}
            if !(digits_arr[total_length] in prime_ending_digits)
                continue
            end
            
            number = sum(digits_arr[i] * 10^(total_length - i) for i in 1:total_length)
            push!(numbers, number)
        end
    end
    
    return unique(numbers)
end

"""
    generate_standard(digit, count, total_length)

Standard generation for digits that can be the last digit of a prime.
"""
function generate_standard(digit, count, total_length)
    numbers = Int[]
    positions = 1:total_length

    for pos_combo in combinations(positions, count)
        non_repeated_positions = setdiff(positions, pos_combo)
        num_non_repeated = length(non_repeated_positions)

        if num_non_repeated == 0
            continue
        end

        available_digits = [d for d in 0:9 if d != digit]

        for digit_assignment in Iterators.product(fill(available_digits, num_non_repeated)...)
            digits_arr = fill(digit, total_length)
            for (i, pos) in enumerate(non_repeated_positions)
                digits_arr[pos] = digit_assignment[i]
            end

            # Skip numbers with leading zeros
            if digits_arr[1] == 0
                continue
            end

            number = sum(digits_arr[i] * 10^(total_length - i) for i in 1:total_length)
            push!(numbers, number)
        end
    end

    return unique(numbers)
end

"""
    count_digit_occurrences(n, digit)

Count how many times a digit appears in number n.
"""
function count_digit_occurrences(n, digit)
    count = 0
    temp = n
    while temp > 0
        if temp % 10 == digit
            count += 1
        end
        temp ÷= 10
    end
    return count
end

"""
    find_primes_with_repeated_digit(digit, total_length)

Find M(total_length, digit), N(total_length, digit), and S(total_length, digit).
Returns (M, N, S).
"""
function find_primes_with_repeated_digit(digit, total_length)
    # Start with maximum possible repeated count and work down
    for repeat_count in (total_length-1):-1:1
        @info "Testing digit $digit with $repeat_count repetitions"

        candidates = generate_numbers_with_repeated_digit(digit, repeat_count, total_length)
        primes_found = []

        for candidate in candidates
            # Verify the candidate actually has the expected number of repeated digits
            actual_count = count_digit_occurrences(candidate, digit)
            if actual_count != repeat_count
                continue
            end

            # Quick checks for obvious non-primes
            if candidate % 2 == 0 && digit != 2
                continue
            end
            if candidate % 5 == 0 && digit != 5
                continue
            end
            
            # Check divisibility by 3 (sum of digits divisible by 3)
            digit_sum = sum(digits(candidate))
            if digit_sum % 3 == 0 && candidate != 3
                continue
            end

            if is_prime(candidate)
                push!(primes_found, candidate)
            end
        end

        if !isempty(primes_found)
            M = repeat_count
            N = length(primes_found)
            S = sum(primes_found)

            @info "Found M($total_length, $digit) = $M, N($total_length, $digit) = $N, S($total_length, $digit) = $S"
            return M, N, S
        end
    end

    # If no primes found with any repeat count > 0, return zeros
    return 0, 0, 0
end

function solve()
    total_sum = 0

    for digit in 0:9
        M, N, S = find_primes_with_repeated_digit(digit, 10)
        total_sum += S
        @info "M(10,$digit)=$M, N(10,$digit)=$N, S(10,$digit)=$S (running sum: $total_sum)"
    end

    return total_sum
end

end # module
