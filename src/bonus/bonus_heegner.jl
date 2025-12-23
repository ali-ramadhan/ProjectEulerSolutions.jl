"""
Project Euler Bonus Problem: Heegner

Problem description: https://projecteuler.net/problem=heegner
Solution description: https://aliramadhan.me/blog/project-euler/bonus-heegner/
"""
module BonusHeegner

using Printf

function distance_to_nearest_integer(x)
    return abs(x - round(x))
end

function required_precision_bits(limit; fractional_digits=32)
    val = cosh(big(π) * sqrt(big(limit)))
    integer_digits = ceil(Int, log10(val))
    total_digits = integer_digits + fractional_digits
    return ceil(Int, total_digits * log2(10))
end

function process_chunk(chunk_start, chunk_end, precision_bits)
    setprecision(BigFloat, precision_bits) do
        local_results = Vector{Tuple{Int,BigFloat,BigFloat}}()
        for n in chunk_start:chunk_end
            n == 0 && continue
            isqrt(abs(n))^2 == abs(n) && continue

            if n > 0
                val = cos(big(π) * sqrt(big(n)))
            else
                val = cosh(big(π) * sqrt(big(-n)))
            end

            dist = distance_to_nearest_integer(val)
            push!(local_results, (n, val, dist))
        end
        return local_results
    end
end

function find_closest_cos_to_integer(limit)
    precision_bits = required_precision_bits(limit)
    @info "Using $precision_bits bits of precision for limit=$limit"

    num_chunks = Threads.nthreads()

    if num_chunks == 1
        results = process_chunk(-limit, limit, precision_bits)
        sort!(results, by=x -> x[3])
        log_top_results(results)
        return results[1][1]
    end

    # Multi-threaded: chunk the range from -limit to limit
    total_range = 2 * limit + 1
    chunk_size = cld(total_range, num_chunks)

    tasks = map(1:num_chunks) do i
        chunk_start = -limit + (i - 1) * chunk_size
        chunk_end = min(chunk_start + chunk_size - 1, limit)
        Threads.@spawn process_chunk(chunk_start, chunk_end, precision_bits)
    end

    # Combine results from all chunks
    all_results = reduce(vcat, fetch.(tasks))
    sort!(all_results, by=x -> x[3])
    log_top_results(all_results)

    return all_results[1][1]
end

function log_top_results(results)
    @info "Top 10 values of n where cos(π√n) is closest to an integer:"
    for i in 1:min(10, length(results))
        n, val, dist = results[i]
        @info @sprintf("%d: n = %d, value ≈ %.10e, distance ≈ %.10e", i, n, val, dist)
    end
end

function solve()
    return find_closest_cos_to_integer(1000)
end

end # module
