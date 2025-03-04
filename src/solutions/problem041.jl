"""
Project Euler Problem 41: Pandigital Prime

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once.
For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?
"""
module Problem041

using Combinatorics

"""
    is_prime(n)

Check if n is prime using trial division with 6k±1 optimization.
Only checks divisors up to sqrt(n) and filters common cases.
"""
function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end

"""
    digits_to_number(digits)

Convert an array of digits to a number.
"""
function digits_to_number(digits)
    num = 0
    for d in digits
        num = num * 10 + d
    end
    return num
end

"""
    find_largest_pandigital_prime()

Find the largest n-digit pandigital prime.
A pandigital number uses all digits from 1 to n exactly once.
Optimized by skipping n values where sum of digits 1 to n is divisible by 3
and checking only numbers that end in 1, 3, 7, or 9.

By divisibility rules, 9-digit, 8-digit, 6-digit, and 3-digit pandigitals
cannot be prime (sum of digits 1 to n is divisible by 3).


"""
function find_largest_pandigital_prime()
    for n in 7:-1:1
        if sum(1:n) % 3 == 0
            continue
        end

        # Generate pandigital candidates that may be prime
        candidates = Int[]
        for p in permutations(1:n)
            if p[end] % 2 != 0 && p[end] != 5
                push!(candidates, digits_to_number(p))
            end
        end

        sort!(candidates, rev=true)

        for num in candidates
            if is_prime(num)
                return num
            end
        end
    end

    return nothing
end

function solve()
    n = find_largest_pandigital_prime()
    @info "The largest pandigital prime is $n with $(length(digits(n))) digits!"
    return n
end

end # module
