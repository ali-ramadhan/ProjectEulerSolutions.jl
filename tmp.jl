using Primes

function is_concatenation_prime(p1::Int, p2::Int)
    return isprime(parse(Int, string(p1, p2))) && isprime(parse(Int, string(p2, p1)))
end

function find_five_primes()
    primes_list = [3, 7]  # Start with the known primes from the 4-prime set
    p = 11  # Start checking from 11

    while length(primes_list) < 5
        if isprime(p) && all(q -> is_concatenation_prime(p, q), primes_list)
            push!(primes_list, p)
        end
        p = nextprime(p+1)
    end

    return primes_list
end

# Find the set of five primes
result = find_five_primes()

# Print the result
println("The set of five primes is: ", result)
println("Their sum is: ", sum(result))