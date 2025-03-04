"""
Project Euler Problem 34: Digit Factorials

145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: As 1! = 1 and 2! = 2 are not sums they are not included.
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
    return sum(numbers)
end

end # module
