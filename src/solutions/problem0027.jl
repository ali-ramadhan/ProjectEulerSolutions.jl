"""
Project Euler Problem 27: Quadratic Primes

Problem description: https://projecteuler.net/problem=27
Solution description: https://aliramadhan.me/blog/project-euler/problem-0027/
"""
module Problem0027

export count_consecutive_primes, find_quadratic_with_most_primes, solve

using ProjectEulerSolutions.Utils.Primes: is_prime

function count_consecutive_primes(a, b)
    n = 0

    while true
        value = n^2 + a*n + b

        if value < 0 || !is_prime(value)
            break
        end

        n += 1
    end

    return n
end

function find_quadratic_with_most_primes(; a_max=1000, b_max=1000)
    max_prime_count = 0
    best_a = 0
    best_b = 0

    b_primes = [p for p in 3:b_max if is_prime(p)]

    for b in b_primes
        for p in 3:(a_max + b)
            if !is_prime(p)
                continue
            end

            a = p - b - 1

            if a >= a_max
                break
            end

            count = count_consecutive_primes(a, b)

            if count > max_prime_count
                max_prime_count = count
                best_a = a
                best_b = b
            end
        end
    end

    return best_a, best_b, max_prime_count
end

function solve()
    a, b, max_count = find_quadratic_with_most_primes()
    @info "Found n² + $(a)n + $b which produces $max_count primes!"
    return a * b
end

end # module
