"""
Project Euler Problem 25: 1000-digit Fibonacci Number

Problem description: https://projecteuler.net/problem=25
Solution description: https://aliramadhan.me/blog/project-euler/problem-0025/
"""
module Problem0025

function first_fibonacci_with_n_digits_formula(n)
    φ = (1 + √5) / 2
    return ceil(Int, ((n - 1) * log(10) + 0.5 * log(5)) / log(φ))
end

function first_fibonacci_with_n_digits(n)
    a, b = BigInt(1), BigInt(1)
    i = 2

    while ndigits(b) < n
        a, b = b, a + b
        i += 1
    end

    return i
end

function solve()
    result = first_fibonacci_with_n_digits(1000)
    @info "F_$result is the first Fibonacci number with 1000 digits"
    return result
end

end # module
