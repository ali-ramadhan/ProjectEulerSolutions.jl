"""
Project Euler Problem 4: Largest Palindrome Product

A palindromic number reads the same both ways.
The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 * 99.

Find the largest palindrome made from the product of two 3-digit numbers.
"""
module Problem004

"""
    is_palindrome(n)

Check if the number n is a palindrome (reads the same forward and backward).
"""
function is_palindrome(n)
    str = string(n)
    return str == reverse(str)
end

"""
    largest_palindrome_product(n_digits)

Find the largest palindrome that is a product of two n-digit numbers.
"""
function largest_palindrome_product(n_digits)
    lower_bound = 10^(n_digits-1)
    upper_bound = 10^n_digits - 1
    
    max_palindrome = 0
    
    for i in upper_bound:-1:lower_bound
        # break early if we can't find a larger palindrome
        if i * upper_bound < max_palindrome
            break
        end
        
        # Start from j=i to avoid duplicate combinations
        for j in upper_bound:-1:i
            product = i * j
            
            if product < max_palindrome
                break
            end
            
            if is_palindrome(product) && product > max_palindrome
                max_palindrome = product
            end
        end
    end
    
    return max_palindrome
end

function solve()
    return largest_palindrome_product(3)
end

end # module
