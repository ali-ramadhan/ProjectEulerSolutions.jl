struct TrialDivision <: PrimalityTest end

"""
    is_prime(n, ::TrialDivision)

Check if n is prime using trial division with 6k±1 optimization.
Only checks divisors up to sqrt(n) and filters common cases.
"""
function is_prime(n, ::TrialDivision)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    # Check divisibility by numbers of form 6k±1 up to sqrt(n)
    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end
