"""
Project Euler Problem 29: Distinct Powers

Problem description: https://projecteuler.net/problem=29
Solution description: https://aliramadhan.me/blog/project-euler/problem-0029/
"""
module Problem0029

export count_distinct_powers, solve

function count_distinct_powers(n)
    max_log = floor(Int, log2(n))

    # Precompute: for each max_power (1 to max_log), count unique exponents
    # in the union of {k×j : j ∈ [2,n]} for k = 1 to max_power
    unique_counts = Vector{Int}(undef, max_log)
    for max_power in 1:max_log
        seen = Set{Int}()
        for k in 1:max_power
            for j in 2:n
                push!(seen, k * j)
            end
        end
        unique_counts[max_power] = length(seen)
    end

    # Find primitive roots and sum their contributions
    is_perfect_power = falses(n)
    result = 0

    for base in 2:n
        if is_perfect_power[base]
            continue
        end

        # Count how many powers of base are ≤ n
        power_count = 1
        val = base
        while true
            next_val = val * base
            if next_val > n
                break
            end
            val = next_val
            power_count += 1
            is_perfect_power[val] = true
        end

        result += unique_counts[power_count]
    end

    return result
end

function solve()
    return count_distinct_powers(100)
end

end # module
