"""
Project Euler Problem 34: Digit Factorials

145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: As 1! = 1 and 2! = 2 are not sums they are not included.

## Solution approach

We need to find all numbers where the number equals the sum of the factorials of its digits.
The key insight is determining the upper bound for our search.

For a k-digit number, the maximum possible sum of digit factorials is k × 9! = k × 362,880.
However, the minimum k-digit number is 10^(k-1). For k ≥ 8, we have 10^(k-1) > k × 362,880,
meaning no k-digit number with k ≥ 8 can equal its digit factorial sum.

Therefore, we only need to check numbers up to 7 × 9! = 2,540,160. We iterate through all
numbers from 3 (excluding 1 and 2 as stated) up to this bound and check the condition.

## Complexity analysis

Time complexity: O(n × d)
- Where n = 2,540,160 (our upper bound) and d is the average number of digits (≈ log₁₀(n))
- For each number, we extract digits and compute factorials, taking O(d) time per number
- Total: approximately O(2,540,160 × 7) operations

Space complexity: O(1)
- We only use constant extra space for temporary calculations
- No data structures that grow with input size
"""
module Problem034

"""
    sum_of_digit_factorials(n)

Compute the sum of the factorials of the digits of n.
"""
function sum_of_digit_factorials(n)
    sum = 0
    while n > 0
        digit = n % 10
        sum += factorial(digit)
        n ÷= 10
    end
    return sum
end

"""
    find_digit_factorial_numbers(upper_bound)

Find all numbers up to upper_bound which are equal to the sum of the factorial of their digits.
Returns an array of such numbers.
"""
function find_digit_factorial_numbers(upper_bound)
    result = Int[]
    for n in 3:upper_bound
        if n == sum_of_digit_factorials(n)
            push!(result, n)
        end
    end
    return result
end

"""
    solve()

Solve Problem 34 by finding the sum of all numbers which equal the sum of
the factorials of their digits.

The upper bound is determined by the fact that for a number with k digits,
the maximum sum of factorials would be k*9!. Any number with 8+ digits will
always exceed its factorial digit sum, so we only need to check up to 7*9!.
"""
function solve()
    upper_bound = 7 * factorial(9)
    numbers = find_digit_factorial_numbers(upper_bound)
    result = sum(numbers)

    @info "Found $(length(numbers)) digit factorials with sum $result"

    return result
end

end # module
