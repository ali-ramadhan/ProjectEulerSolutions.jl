"""
Project Euler Problem 36: Double-base Palindromes

Problem description: https://projecteuler.net/problem=36
Solution description: https://aliramadhan.me/blog/project-euler/problem-0036/
"""
module Problem0036

export find_double_base_palindromes, solve

using ProjectEulerSolutions.Utils.Digits: is_palindrome, make_palindrome

# An L-digit palindrome is determined by its first ⌈L/2⌉ digits, so we build every decimal palindrome below N from
# its first half h and keep the ones that are also palindromes in base K.
function find_double_base_palindromes(N, K)
    result = Int[]

    for L in 1:ndigits(N - 1)
        k = cld(L, 2)  # number of digits in the first half
        for h in 10^(k-1):10^k-1
            p = make_palindrome(h; odd=isodd(L))
            p >= N && break
            is_palindrome(p; base=K) && push!(result, p)
        end
    end

    return result
end

function solve()
    palindromes = find_double_base_palindromes(10^6, 2)
    largest = last(palindromes)
    @info "$(length(palindromes)) double-base palindromes below 10^6, the largest being " *
          "$largest = $(string(largest; base=2)) in binary"
    return sum(palindromes)
end

end # module
