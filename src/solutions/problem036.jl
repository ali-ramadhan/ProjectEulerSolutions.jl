"""
Project Euler Problem 36: Double-base Palindromes

The decimal number, 585 = 1001001001_2 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
"""
module Problem036

"""
    is_palindromic_base10(n)

Check if the number n is palindromic in base 10 (decimal).
"""
function is_palindromic_base10(n)
    str = string(n)
    return str == reverse(str)
end

"""
    is_palindromic_base2(n)

Check if the number n is palindromic in base 2 (binary).
"""
function is_palindromic_base2(n)
    binary = string(n; base = 2)
    return binary == reverse(binary)
end

"""
    sum_double_base_palindromes(limit)

Find the sum of all numbers less than the given limit which are palindromic
in both base 10 (decimal) and base 2 (binary).

Note: We only check odd numbers since even numbers cannot be palindromic in base 2.
This is because an even number's binary representation ends with 0, and for it to be
palindromic, it would need to start with 0 as well, which violates the no-leading-zeros rule.
"""
function sum_double_base_palindromes(limit)
    total_sum = 0

    for n in 1:2:(limit - 1)
        if is_palindromic_base10(n) && is_palindromic_base2(n)
            total_sum += n
        end
    end

    return total_sum
end

function solve()
    return sum_double_base_palindromes(1_000_000)
end

end # module
