"""
Project Euler Problem 99: Largest Exponential

Comparing two numbers written in index form like 2^11 and 3^7 is not difficult, as any
calculator would confirm that 2^11 = 2048 < 3^7 = 2187.

However, confirming that 632382^518061 > 519432^525806 would be much more difficult, as both
numbers contain over three million digits.

Using base_exp.txt, a 22K text file containing one thousand lines with a base/exponent pair
on each line, determine which line number has the greatest numerical value.

NOTE: The first two lines in the file represent the numbers in the example given above.

## Solution approach

Instead of computing massive exponentials directly, we use logarithms to compare values.

For base^exponent, we compute: log(base^exponent) = exponent × log(base)

The exponential with the largest logarithmic value corresponds to the largest original
value. This avoids numerical overflow while preserving the relative ordering.

## Complexity analysis

Time complexity: O(n) where n = 1000 lines
- Read and parse each line: O(n)
- Compute logarithm for each pair: O(n)

Space complexity: O(n)
- Store all base-exponent pairs from file
"""
module Problem99

function read_base_exp_pairs(filename)
    pairs = Tuple{Int64, Int64}[]
    open(filename, "r") do file
        for line in eachline(file)
            parts = split(strip(line), ",")
            base = parse(Int64, parts[1])
            exponent = parse(Int64, parts[2])
            push!(pairs, (base, exponent))
        end
    end
    return pairs
end

function find_largest_exponential(pairs)
    max_log_value = -Inf
    max_line = 0

    for (i, (base, exponent)) in enumerate(pairs)
        log_value = exponent * log(base)
        if log_value > max_log_value
            max_log_value = log_value
            max_line = i
        end
    end

    return max_line
end

function solve()
    data_path = joinpath(@__DIR__, "..", "..", "data", "0099_base_exp.txt")
    pairs = read_base_exp_pairs(data_path)
    return find_largest_exponential(pairs)
end

end # module
