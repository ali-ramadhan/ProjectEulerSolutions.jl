"""
Project Euler Problem 75: Singular Integer Right Triangles

It turns out that 12 cm is the smallest length of wire that can be bent to form 
an integer sided right angle triangle in exactly one way, but there are many more examples.

12 cm: (3,4,5)
24 cm: (6,8,10)
30 cm: (5,12,13)
36 cm: (9,12,15)
40 cm: (8,15,17)
48 cm: (12,16,20)

In contrast, some lengths of wire, like 20 cm, cannot be bent to form an integer sided 
right angle triangle, and other lengths allow more than one solution to be found; 
for example, using 120 cm it is possible to form exactly three different integer sided right angle triangles.

120 cm: (30,40,50), (20,48,52), (24,45,51)

Given that L is the length of the wire, for how many values of L ≤ 1,500,000 
can exactly one integer sided right angle triangle be formed?
"""
module Problem075

"""
    is_valid_pair(m, n)

Check if a pair (m, n) is valid for generating primitive Pythagorean triples.
Valid pairs have gcd(m, n) = 1 and not both m and n are odd.
"""
function is_valid_pair(m, n)
    return gcd(m, n) == 1 && !(m % 2 == 1 && n % 2 == 1)
end

"""
    generate_pythagorean_triple(m, n)

Generate a primitive Pythagorean triple (a, b, c) and its perimeter p from a valid pair (m, n).
Using Euclid's formula for Pythagorean triples.
"""
function generate_pythagorean_triple(m, n)
    a = m^2 - n^2
    b = 2*m*n
    c = m^2 + n^2
    p = a + b + c
    return a, b, c, p
end

"""
    count_singular_integer_right_triangles(limit)

Count the number of values L ≤ limit for which exactly one integer-sided 
right angle triangle can be formed with perimeter L.
"""
function count_singular_integer_right_triangles(limit)
    perimeter_counts = Dict{Int, Int}()
    
    # Upper bound for m: m < sqrt(limit / 2)
    max_m = isqrt(limit ÷ 2)
    
    for m in 2:max_m
        for n in 1:(m-1)
            if !is_valid_pair(m, n)
                continue
            end
            
            a, b, c, p = generate_pythagorean_triple(m, n)
            
            if p > limit
                break
            end
            
            for k in 1:(limit ÷ p)
                perimeter = k * p
                perimeter_counts[perimeter] = get(perimeter_counts, perimeter, 0) + 1
            end
        end
    end
    
    singular_count = count(c -> c == 1, values(perimeter_counts))
    
    return singular_count
end

function solve()
    return count_singular_integer_right_triangles(1_500_000)
end

end # module
