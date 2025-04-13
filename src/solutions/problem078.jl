"""
Project Euler Problem 78: Coin Partitions

Let p(n) represent the number of different ways in which n coins can be separated into piles.
For example, five coins can be separated into piles in exactly seven different ways, so p(5) = 7.

Find the least value of n for which p(n) is divisible by one million.
"""
module Problem078

"""
    calculate_partition_numbers(max_n=nothing; target_mod=nothing, divisible_by=nothing)

Calculate partition numbers p(n) using Euler's pentagonal number theorem.
Returns the array of partition numbers.

Optional parameters:
- max_n: If provided, calculate up to p(max_n)
- target_mod: Calculate values modulo this number
- divisible_by: If provided, stop when p(n) is divisible by this value and return (p_array, n)

The pentagonal number theorem gives an efficient recurrence relation:
p(n) = p(n-1) + p(n-2) - p(n-5) - p(n-7) + p(n-12) + ...

Where the indices come from the generalized pentagonal numbers k(3k-1)/2 and k(3k+1)/2
with alternating signs.
"""
function calculate_partition_numbers(max_n=nothing; target_mod=nothing, divisible_by=nothing)
    # Initialize array with p(0) = 1
    p = [1]
    
    n = 1
    while isnothing(max_n) || n <= max_n
        # Calculate p(n)
        p_n = 0
        k = 1
        sign = 1
        
        # Apply the pentagonal number theorem recurrence
        while true
            # Generate pentagonal numbers: k(3k-1)/2 and k(3k+1)/2
            pent1 = div(k * (3k - 1), 2)
            pent2 = div(k * (3k + 1), 2)
            
            if pent1 > n
                break
            end
            
            # Apply the recurrence relation with alternating signs
            if n >= pent1
                p_n = (p_n + sign * p[n - pent1 + 1]) % (target_mod === nothing ? typemax(Int) : target_mod)
            end
            
            if n >= pent2
                p_n = (p_n + sign * p[n - pent2 + 1]) % (target_mod === nothing ? typemax(Int) : target_mod)
            end
            
            sign = -sign
            k += 1
        end
        
        if !isnothing(target_mod) && p_n < 0
            p_n += target_mod
        end
        
        push!(p, p_n)
        
        if !isnothing(divisible_by) && p_n % divisible_by == 0
            return (p, n)
        end
        
        n += 1
    end
    
    return p
end

"""
    partition_number(n, mod_value)

Calculate p(n), the number of ways to partition n, using Euler's pentagonal number theorem.
Results are computed modulo mod_value.
"""
function partition_number(n, mod_value)
    p = calculate_partition_numbers(n; target_mod=mod_value)
    return p[n + 1]  # Return p(n)
end

"""
    find_divisible_partition(divisor)

Find the smallest n for which p(n) is divisible by divisor.
Uses Euler's pentagonal number theorem to efficiently compute partition numbers.
"""
function find_divisible_partition(divisor)
    _, n = calculate_partition_numbers(; target_mod=divisor, divisible_by=divisor)
    return n
end

function solve()
    return find_divisible_partition(1_000_000)
end

end # module