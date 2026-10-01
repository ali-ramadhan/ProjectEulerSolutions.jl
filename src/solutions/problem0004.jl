"""
Project Euler Problem 4: Largest Palindrome Product

Problem description: https://projecteuler.net/problem=4
Solution description: https://aliramadhan.me/blog/project-euler/problem-0004/
"""
module Problem0004

export largest_palindrome_product, largest_palindrome_product_naive, largest_palindrome_product_fermat,
       largest_palindrome_product_fermat_filtered, solve

using ProjectEulerSolutions.Utils.Digits: is_palindrome

# The smallest of Int64, Int128 and BigInt that holds every number with up to num_digits digits
integer_type(num_digits) = num_digits <= 18 ? Int64 : num_digits <= 38 ? Int128 : BigInt

# Check every product i*j of two n-digit numbers, testing whether it's a palindrome by reversing its decimal string.
# The products have up to 2n digits, which sets the default integer type T.
function largest_palindrome_product_naive(n, ::Type{T}=integer_type(2n)) where {T}
    lower_limit, upper_limit = T(10)^(n - 1), T(10)^n - 1
    max_palindrome = zero(T)
    best_i, best_j = zero(T), zero(T)

    for i in lower_limit:upper_limit
        for j in lower_limit:upper_limit
            product = i * j
            s = string(product)
            if s == reverse(s) && product > max_palindrome
                max_palindrome = product
                best_i, best_j = i, j
            end
        end
    end

    return (palindrome=max_palindrome, factors=(best_i, best_j))
end

# The products have up to 2n digits, which sets the default integer type T
function largest_palindrome_product(n, ::Type{T}=integer_type(2n); max_product=nothing) where {T}
    lower_limit, upper_limit = T(10)^(n - 1), T(10)^n - 1
    max_palindrome = zero(T)
    best_i, best_j = zero(T), zero(T)

    for i in upper_limit:-1:lower_limit
        # break early if we can't find a larger palindrome
        if i * upper_limit < max_palindrome
            break
        end

        # Stop at j = i to avoid duplicate combinations as i*j == j*i
        for j in upper_limit:-1:i
            product = i * j

            # Skip if product exceeds max_product constraint
            if !isnothing(max_product) && product >= max_product
                continue
            end

            if product < max_palindrome
                break
            end

            if is_palindrome(product) && product > max_palindrome
                max_palindrome = product
                best_i, best_j = i, j
            end
        end
    end

    return (palindrome=max_palindrome, factors=(best_i, best_j))
end

# Reverse the decimal digits of h (trailing zeros of h become leading zeros of the result)
function reverse_digits(h)
    ten = oftype(h, 10)
    reversed = zero(h)

    while h > 0
        h, digit = divrem(h, ten)
        reversed = reversed * ten + digit
    end

    return reversed
end

# Check the 2n-digit palindromes from the top down for a pair of n-digit factors using Fermat's factorization method
function largest_palindrome_product_fermat(n, ::Type{T}=integer_type(n)) where {T}
    n >= 2 || throw(ArgumentError("expected n ≥ 2 digits, but got n = $n"))

    B = T(10)^n
    uv_max = B - B ÷ 10  # largest u or v that keeps x and y at n digits

    for m in one(T):uv_max
        H = B - m              # top half of the palindrome, from 99...9 downwards
        L = reverse_digits(H)  # bottom half

        c = zero(T) # carry
        while true
            s = m + c                  # u + v
            D = s^2 - 4 * (c * B + L)  # (u - v)^2
            D < 0 && break             # D shrinks as c grows, so no larger carry can work either

            r = isqrt(D)
            if r^2 == D
                u, v = (s - r) ÷ 2, (s + r) ÷ 2
                if u >= 1 && v <= uv_max  # x and y must both have n digits
                    return (palindrome=widemul(H, B) + L, factors=(B - v, B - u))
                end
            end

            c += 1
        end
    end

    # No 2n-digit palindrome is a product of two n-digit numbers
    return (palindrome=zero(widen(T)), factors=(zero(T), zero(T)))
end

# Near the top the upper half starts with 999, so the palindrome ends in 999 and so does uv. That makes s ≡ 0 (mod 8)
# and s end in 0, 4 or 6, which leaves these residues mod 120.
const SUM_RESIDUES = (0, 16, 24, 40, 56, 64, 80, 96, 104)

# Bit i is set when i is a square modulo 64
const SQUARES_MOD_64 = reduce(|, UInt64(1) << (i^2 % 64) for i in 0:63)

# Constants for the filtered search, in an integer type W wide enough for s² and 4cB
struct FilteredSearch{W}
    B::W                # 10^n
    leading_place::W    # 10^(n-1), the place value of the lower half's first digit
    tail_digits::Int    # k: while m ≤ 10^k the upper half is n - k nines followed by a k-digit tail
    ten_to_tail::Int64  # 10^k
    nines_shift::W      # 10^(n-k), which shifts the reversed tail past the n - k nines that end the lower half
    max_sum::W          # the largest s to check, since the residue rules need m ≤ 10^(n-3) and the tail needs m ≤ 10^k
end

function FilteredSearch(n, ::Type{W}) where W
    k = min(n, cld(n, 2) + 3, 18)  # deeper than any answer, and short enough for an Int64
    max_sum = n >= 3 ? min(W(10)^(n - 3), W(10)^k) : zero(W)
    return FilteredSearch(W(10)^n, W(10)^(n - 1), k, 10^k, W(10)^(n - k), max_sum)
end

# The Fermat search over only the sums s = u + v that the palindrome's digits allow
function largest_palindrome_product_fermat_filtered(n, ::Type{T}=integer_type(n)) where T
    n >= 2 || throw(ArgumentError("expected n ≥ 2 digits, but got n = $n"))

    search = FilteredSearch(n, promote_type(T, Int128))
    best = find_smallest_m(search)

    # Fall back to the plain search unless no sum past max_sum can beat the best m, which only happens for n ≤ 5
    if isnothing(best) || !no_smaller_m_from(search.max_sum + 1, best.m, search)
        return largest_palindrome_product_fermat(n, T)
    end

    B = T(10)^n
    U = B - T(best.m)
    return (palindrome=widemul(U, B) + reverse_digits(U), factors=(B - T(best.v), B - T(best.u)))
end

# The smallest m whose palindrome is a product, as (m, u, v), over the sums up to max_sum in blocks of 120, or nothing
function find_smallest_m(search::FilteredSearch{W}) where {W}
    best = nothing
    for block_start in zero(W):W(120):search.max_sum
        !isnothing(best) && no_smaller_m_from(block_start, best.m, search) && break
        block_end = block_start + 119
        no_carry = block_end * block_end < 4 * search.B  # cB ≤ uv ≤ s²/4

        for r in SUM_RESIDUES
            no_carry && r % 3 != 1 && continue  # with c = 0 the mod 3 rule needs s ≡ 1 (mod 3)
            s = block_start + r
            s <= search.max_sum || break

            hit = smallest_m_for_sum(s, r, search)
            if !isnothing(hit) && (isnothing(best) || hit.m < best.m)
                best = hit
            end
        end
    end
    return best
end

# The smallest m among the palindromes with u + v = s that are products, as (m, u, v), or nothing. Each carry c gives a
# different palindrome, with m = s - c. Here s ≡ r (mod 120).
function smallest_m_for_sum(s::W, r, search::FilteredSearch{W}) where {W}
    s_squared = s * s  # not s^2, which isn't a plain multiplication for Int128
    best = nothing
    c = 0
    while 4 * c * search.B <= s_squared  # cB ≤ uv ≤ s²/4
        if passes_mod_3_rule(r, c) && passes_middle_digit_rule(s_squared, r, c, search)
            m = s - c
            root = perfect_square_root(s_squared - 4 * (c * search.B + lower_half(m, search)))
            if !isnothing(root)
                best = (m=m, u=(s - root) ÷ 2, v=(s + root) ÷ 2)  # a larger carry gives a smaller m
            end
        end
        c += 1
    end
    return best
end

# The lower half L has the same digits as the upper half U = B - s + c, so L ≡ U (mod 3) and the discriminant
# D = s² - 4(cB + L) ≡ s² + s + c - 1 (mod 3). No square is 2 mod 3. Here s ≡ r (mod 3) since 120 is a multiple of 3.
passes_mod_3_rule(r, c) = mod(r^2 + r + c - 1, 3) != 2

# U's last digit, d = (c - s) mod 10, is also L's first digit. So L ≥ d·10^(n-1), and D ≥ 0 needs
# s² ≥ 4cB + 4d·10^(n-1). Here s ≡ r (mod 10) since 120 is a multiple of 10.
function passes_middle_digit_rule(s_squared, r, c, search)
    d = mod(c - r, 10)
    return 4 * (c * search.B + d * search.leading_place) <= s_squared
end

# The lower half of the palindrome with upper half B - m: the reversed k-digit tail 10^k - m followed by n - k nines
function lower_half(m, search)
    reversed_tail = reverse_tail(search.ten_to_tail - Int64(m), search.tail_digits)
    return reversed_tail * search.nines_shift + (search.nines_shift - 1)
end

# Reverse t as a k-digit number, with leading zeros. The tail fits in an Int64, where division is much cheaper.
function reverse_tail(t::Int64, k)
    reversed = 0
    for _ in 1:k
        t, digit = divrem(t, 10)
        reversed = 10reversed + digit
    end
    return reversed
end

# √x if x is a perfect square, or nothing. Only 12 of the 64 residues modulo 64 are squares, so checking the low bits
# first rules out most non-squares before taking the square root.
function perfect_square_root(x)
    (x >= 0 && isodd(SQUARES_MOD_64 >> ((x % UInt8) & 0x3f))) || return nothing
    root = isqrt(x)
    return root * root == x ? root : nothing
end

# Whether no sum from s on can give a smaller m than m_best. The carry is at most s²/4B since cB ≤ uv ≤ s²/4, so a sum
# s gives m ≥ s - ⌊s²/4B⌋, which only grows with s.
no_smaller_m_from(s, m_best, search) = s - fld(s * s, 4 * search.B) > m_best

function solve(solve_func=largest_palindrome_product)
    result = solve_func(3)
    @info "Found largest palindrome from 3-digit products: $(result.palindrome) = " *
          "$(result.factors[1]) × $(result.factors[2])"
    return result.palindrome
end

end # module
