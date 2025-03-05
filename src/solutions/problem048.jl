"""
Project Euler Problem 48: Self Powers

The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
"""
module Problem048

"""
    last_ten_digits_of_self_powers(limit)

Calculate the last ten digits of the sum of self powers from 1 to limit.
Uses modular arithmetic to prevent overflow when dealing with large numbers.
"""
function last_ten_digits_of_self_powers(limit)
    modulus = 10^10
    total = 0

    for n in 1:limit
        # Calculate n^n modulo 10^10
        power = powermod(n, n, modulus)

        # Add to total and take modulo again
        total = (total + power) % modulus
    end

    return total
end

function solve()
    return last_ten_digits_of_self_powers(1000)
end

end # module
