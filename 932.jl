"""
    is_2025_number(num)

Check if a number is a 2025-number by trying all possible ways to split it into two parts.
Returns a tuple (is_valid, a, b) where is_valid is a boolean indicating if it's a 2025-number,
and a, b are the two parts of the split if valid.
"""
function is_2025_number(num)
    # Convert number to string for digit manipulation
    num_str = string(num)
    n_digits = length(num_str)
    
    # Try all possible ways to split the number
    for split_point in 1:(n_digits-1)
        a_str = num_str[1:split_point]
        b_str = num_str[(split_point+1):end]
        
        # Skip if b starts with 0 (not a valid integer)
        if b_str[1] == '0'
            continue
        end
        
        a = parse(Int, a_str)
        b = parse(Int, b_str)
        
        # Check if it's a 2025-number
        if a + b == isqrt(num)
            return true, a, b
        end
    end
    
    return false, 0, 0
end

"""
    find_all_2025_numbers(max_digits)

Find all 2025-numbers with up to max_digits digits and calculate their sum.
A 2025-number is a number formed by concatenating two positive integers a and b
such that the concatenation equals (a+b)².
"""
function find_all_2025_numbers(max_digits)
    total_sum = 0
    found_numbers = Int[]
    
    println("Searching for 2025-numbers with up to $max_digits digits...")
    
    # For a given sum s, check if s² is a 2025-number
    for s in 1:10^(max_digits÷2+1)
        s_squared = big(s)^2
        
        # Stop if s² exceeds the maximum number of digits
        if ndigits(s_squared) > max_digits
            println("Reached maximum digits at s = $s")
            break
        end
        
        is_2025, a, b = is_2025_number(s_squared)
        
        if is_2025
            total_sum += s_squared
            push!(found_numbers, s_squared)
            if length(found_numbers) % 10 == 0
                println("Found $(length(found_numbers)) 2025-numbers so far...")
            end
            println("Found: $s_squared = ($a)($b) where $a + $b = $s")
        end
    end
    
    println("Total 2025-numbers found: $(length(found_numbers))")
    println("Numbers: $(sort(found_numbers))")
    
    return total_sum
end

# Verify with the known result for T(4)
t4 = find_all_2025_numbers(4)
println("\nT(4) = $t4")

# Calculate T(16)
t16 = find_all_2025_numbers(16)
println("\nT(16) = $t16")
