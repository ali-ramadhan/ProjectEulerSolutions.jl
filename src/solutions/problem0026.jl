"""
Project Euler Problem 26: Reciprocal Cycles

Problem description: https://projecteuler.net/problem=26
Solution description: https://aliramadhan.me/blog/project-euler/problem-0026/
"""
module Problem0026

export cycle_length, find_longest_cycle, solve

function cycle_length(d)
    # Remove factors of 2 and 5 (they only affect termination, not cycle length)
    while d % 2 == 0
        d ÷= 2
    end
    while d % 5 == 0
        d ÷= 5
    end

    # No recurring cycle if only factors were 2 and 5
    d == 1 && return 0

    # Find smallest k where 10^k ≡ 1 (mod d)
    remainder = 10 % d
    k = 1
    while remainder != 1
        remainder = (remainder * 10) % d
        k += 1
    end
    return k
end

function find_longest_cycle(limit)
    max_length = 0
    max_d = 0

    for d in 2:(limit - 1)
        length = cycle_length(d)
        if length > max_length
            max_length = length
            max_d = d
        end
    end

    return max_d
end

function solve()
    result = find_longest_cycle(1000)
    max_length = cycle_length(result)
    @info "1/$result has the longest recurring cycle with $max_length digits"
    return result
end

end # module
