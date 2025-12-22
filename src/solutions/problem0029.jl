"""
Project Euler Problem 29: Distinct Powers

Problem description: https://projecteuler.net/problem=29
Solution description: https://aliramadhan.me/blog/project-euler/problem-0029/
"""
module Problem0029

export count_distinct_powers, solve

function count_distinct_powers(N)
    max_log = floor(Int, log2(N))

    # Precompute S_m = |⋃_{j=1}^m {jb : 2 ≤ b ≤ N}| for m = 1 to log₂(N)
    unique_exponent_counts = Vector{Int}(undef, max_log)
    for m in 1:max_log
        seen = Set{Int}()
        for j in 1:m
            for b in 2:N
                push!(seen, j * b)
            end
        end
        unique_exponent_counts[m] = length(seen)
    end

    # Find primitive roots and sum their contributions
    is_perfect_power = falses(N)
    result = 0

    for base in 2:N
        if is_perfect_power[base]
            continue
        end

        # Count how many powers of base are ≤ N
        power_count = 1
        val = base
        while true
            next_val = val * base
            if next_val > N
                break
            end
            val = next_val
            power_count += 1
            is_perfect_power[val] = true
        end

        result += unique_exponent_counts[power_count]
    end

    return result
end

function solve()
    return count_distinct_powers(100)
end

end # module
