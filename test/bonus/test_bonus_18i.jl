using Test
using ProjectEulerSolutions.Bonus18i: R_mod_p, sum_R_in_range, solve

# Given examples
@test R_mod_p(11) == 0
@test R_mod_p(29) == 13

# Spot checks against a naive product for small primes
function R_naive(p)
    prod = 1 % p
    for x in 0:p-1
        prod = (prod * mod(x^3 - 3x + 4, p)) % p
        if prod == 0
            return 0
        end
    end
    return prod
end

for p in (5, 13, 17, 29, 37, 61, 73)
    @test R_mod_p(p) == R_naive(p)
end

# Correct answer
@test solve() == 842507000531275
