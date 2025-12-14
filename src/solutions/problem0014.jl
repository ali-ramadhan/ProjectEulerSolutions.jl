"""
Project Euler Problem 14: Longest Collatz Sequence

Problem description: https://projecteuler.net/problem=14
Solution description: https://aliramadhan.me/blog/project-euler/problem-0014/
"""
module Problem0014

function collatz_length(n, cache)
    if n == 1
        return 1
    end

    if haskey(cache, n)
        return cache[n]
    end

    if n % 2 == 0
        length = 1 + collatz_length(n ÷ 2, cache)
    else
        length = 1 + collatz_length(3n + 1, cache)
    end

    cache[n] = length
    return length
end

function longest_collatz_under(limit)
    cache = Dict(1 => 1)

    max_length = 0
    max_start = 0

    for start in 1:(limit - 1)
        length = collatz_length(start, cache)
        if length > max_length
            max_length = length
            max_start = start
        end
    end

    return max_start, max_length
end

function solve()
    result, max_length = longest_collatz_under(1_000_000)
    @info "Number $result has longest Collatz sequence with $max_length terms"
    return result
end

end # module
