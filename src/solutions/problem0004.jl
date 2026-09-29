"""
Project Euler Problem 4: Largest Palindrome Product

Problem description: https://projecteuler.net/problem=4
Solution description: https://aliramadhan.me/blog/project-euler/problem-0004/
"""
module Problem0004

export largest_palindrome_product, largest_palindrome_product_naive, largest_palindrome_product_fermat, solve

using ProjectEulerSolutions.Utils.Digits: is_palindrome

# Check every product i*j, testing whether it's a palindrome by reversing its decimal string
function largest_palindrome_product_naive(lower_limit, upper_limit)
    T = typeof(upper_limit)
    max_palindrome = zero(T)
    best_i, best_j = zero(T), zero(T)

    for i in lower_limit:upper_limit
        for j in lower_limit:upper_limit
            product = i * j
            s = string(product)
            if s == reverse(s) && product > max_palindrome
                max_palindrome = product
                best_i, best_j = i, j
            end
        end
    end

    return (palindrome=max_palindrome, factors=(best_i, best_j))
end

function largest_palindrome_product(lower_limit, upper_limit; max_product=nothing)
    T = typeof(upper_limit)
    max_palindrome = zero(T)
    best_i, best_j = zero(T), zero(T)

    for i in upper_limit:-1:lower_limit
        # break early if we can't find a larger palindrome
        if i * upper_limit < max_palindrome
            break
        end

        # Stop at j = i to avoid duplicate combinations as i*j == j*i
        for j in upper_limit:-1:i
            product = i * j

            # Skip if product exceeds max_product constraint
            if !isnothing(max_product) && product >= max_product
                continue
            end

            if product < max_palindrome
                break
            end

            if is_palindrome(product) && product > max_palindrome
                max_palindrome = product
                best_i, best_j = i, j
            end
        end
    end

    return (palindrome=max_palindrome, factors=(best_i, best_j))
end

# Reverse the decimal digits of h (trailing zeros of h become leading zeros of the result)
function reverse_digits(h)
    ten = oftype(h, 10)
    reversed = zero(h)

    while h > 0
        h, digit = divrem(h, ten)
        reversed = reversed * ten + digit
    end

    return reversed
end

# Check the 2n-digit palindromes from the top down for a pair of n-digit factors using Fermat's factorization method
function largest_palindrome_product_fermat(lower_limit, upper_limit)
    T = typeof(upper_limit)
    B = T(10)^ndigits(upper_limit)

    if !(B >= 100 && lower_limit == B ÷ 10 && upper_limit == B - 1)
        throw(ArgumentError("expected all n-digit factors with n ≥ 2, from 10^(n-1) to 10^n - 1, " *
                            "but got $lower_limit to $upper_limit"))
    end

    uv_max = B - lower_limit  # largest u or v that keeps x and y at n digits

    for m in one(T):uv_max
        H = B - m              # top half of the palindrome, from 99...9 downwards
        L = reverse_digits(H)  # bottom half

        c = zero(T) # carry
        while true
            s = m + c                  # u + v
            D = s^2 - 4 * (c * B + L)  # (u - v)^2
            D < 0 && break             # D shrinks as c grows, so no larger carry can work either

            r = isqrt(D)
            if r^2 == D
                u, v = (s - r) ÷ 2, (s + r) ÷ 2
                if u >= 1 && v <= uv_max  # x and y must both have n digits
                    return (palindrome=widemul(H, B) + L, factors=(B - v, B - u))
                end
            end

            c += 1
        end
    end

    # No 2n-digit palindrome is a product of two n-digit numbers
    return (palindrome=zero(widen(T)), factors=(zero(T), zero(T)))
end

function solve(solve_func=largest_palindrome_product)
    result = solve_func(100, 999)
    @info "Found largest palindrome from 3-digit products: $(result.palindrome) = " *
          "$(result.factors[1]) × $(result.factors[2])"
    return result.palindrome
end

end # module
