"""
Project Euler Problem 30: Digit Fifth Powers
Problem description: https://projecteuler.net/problem=30
Solution description: https://aliramadhan.me/blog/project-euler/problem-0030/
"""
module Problem0030

export find_digit_power_numbers, solve

using Combinatorics: with_replacement_combinations

function calculate_max_digits(power)
    n = 1
    while n * 9^power >= 10^(n - 1)
        n += 1
    end
    return n - 1
end

function digit_power_sum(n, power)
    s = 0
    while n > 0
        n, d = divrem(n, 10)
        s += d^power
    end
    return s
end

function find_digit_power_numbers(power)
    max_digits = calculate_max_digits(power)
    results = Set{Int}()

    for combo in with_replacement_combinations(0:9, max_digits)
        s = sum(d^power for d in combo)
        s < 2 && continue

        if digit_power_sum(s, power) == s
            push!(results, s)
        end
    end

    return collect(results)
end

function solve()
    numbers = find_digit_power_numbers(5)
    result = sum(numbers)
    @info "Found digit fifth power numbers: $numbers, sum = $result"
    return result
end

end # module
