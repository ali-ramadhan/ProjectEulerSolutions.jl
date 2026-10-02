"""
Project Euler Problem 4: Largest Palindrome Product

Problem description: https://projecteuler.net/problem=4
Solution description: https://aliramadhan.me/blog/project-euler/problem-0004/
"""
module Problem0004

export largest_palindrome_product, largest_palindrome_product_naive, largest_palindrome_product_fermat,
       largest_palindrome_product_fermat_filtered, largest_palindrome_product_gpu, solve

using ProjectEulerSolutions.Utils.Digits: is_palindrome
using CUDA: CUDA, @cuda, blockDim, blockIdx, gridDim, threadIdx

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

# The filtered search can also run on an NVIDIA GPU. The GPU checks groups of 120 consecutive sums s, skipping the
# residues that the rules above rule out, and keeps the smallest m it finds in an atomic minimum. The CPU launches
# batches of groups from s = 0 upwards until no larger s can beat that m, and then works out the palindrome's factors.
#
# The GPU's integer instructions are 32 bits wide, so 64-bit arithmetic takes a few of them, 128-bit arithmetic many
# more, and division is slowest of all. So the kernel only adds, multiplies and compares 128-bit integers, the digit
# reversal divides 32-bit halves, and square roots start from a Float64 estimate.

# Below 6 digits the answer lies past s = 10^(n-3), where the residue rules no longer hold. Past 37 digits, 4B
# doesn't fit in a UInt128.
const MIN_GPU_DIGITS = 6
const MAX_GPU_DIGITS = 37

# Kernel launches. Each one covers at most 2^34 groups, about 0.7 s on a V100, so the search never runs far past the
# answer.
const THREADS_PER_BLOCK = 256
const BLOCKS_PER_MULTIPROCESSOR = 32
const FIRST_LAUNCH_GROUPS = 2^12
const MAX_LAUNCH_GROUPS = 2^34

# Everything the GPU search needs for a given n, worked out on the CPU. Since m ≤ 10^18, the upper half U = B - m is
# n - k nines followed by the k-digit tail 10^k - m, where k = min(n, 18). For n ≤ 18 the tail is all of U.
Base.@kwdef struct GPUSearch
    B::UInt128                    # 10^n
    max_sum::UInt64               # min(10^18, 10^(n-3)), the largest s to check
    leading_digit_place::UInt128  # 10^(n-1), the place value of L's first digit
    tail_digits::Int              # k = min(n, 18)
    ten_to_tail_digits::UInt64    # 10^k
    nines_shift::UInt64           # 10^(n-k), which shifts the reversed tail past the n - k nines that end L
    only_40_below::UInt64         # groups ending below this can only pass with s ≡ 40 (mod 120) and no carry
    no_carry_below::UInt64        # groups ending below this have s² < 4B, so no carry
end

function GPUSearch(n::Integer)
    B = big(10)^n
    k = min(n, 18)
    ceil_sqrt(x) = isqrt(x - 1) + 1

    # The search stops at s = min(10^18, 10^(n-3)). The 10^18 keeps s in a UInt64 and s² in a UInt128, and it's deep
    # enough for every n that's feasible. The 10^(n-3) keeps m ≤ 10^(n-3), since m ≤ s, so the upper half starts with
    # 999 as the residue rules need. Both factors are then within 10^(n-3) of B, so they always have n digits.
    return GPUSearch(
        B=UInt128(B),
        max_sum=UInt64(min(big(10)^18, big(10)^(n - 3))),
        leading_digit_place=UInt128(10)^(n - 1),
        tail_digits=k,
        ten_to_tail_digits=UInt64(10)^k,
        nines_shift=UInt64(10)^(n - k),
        only_40_below=UInt64(ceil_sqrt(16 * big(10)^(n - 1))),  # s ≡ 16 has d = 4, so the middle digit rule needs this
        no_carry_below=UInt64(ceil_sqrt(4B)))                   # a carry needs s² ≥ 4B
end

# The filtered search on the current CUDA device, for 6 ≤ n ≤ 37 digits. The palindrome and factors are BigInts.
# It needs Julia 1.12 or later, which is the first that CUDA.jl lets pass UInt128s to a kernel.
function largest_palindrome_product_gpu(n)
    MIN_GPU_DIGITS <= n <= MAX_GPU_DIGITS ||
        throw(ArgumentError("expected $MIN_GPU_DIGITS ≤ n ≤ $MAX_GPU_DIGITS, but got n = $n"))

    search = GPUSearch(n)
    no_hit = typemax(UInt64)  # the smallest m until the GPU finds a palindrome product
    best_m = CUDA.fill(no_hit, 1)
    num_blocks = BLOCKS_PER_MULTIPROCESSOR * CUDA.attribute(CUDA.device(), CUDA.DEVICE_ATTRIBUTE_MULTIPROCESSOR_COUNT)

    # Launch batches of groups from s = 0 upwards, doubling the batch size so that answers near the top are found
    # quickly. Groups start at multiples of 120, and the last one can run past max_sum.
    first_sum = UInt64(0)
    groups_per_launch = UInt64(FIRST_LAUNCH_GROUPS)
    while first_sum <= search.max_sum
        num_groups = min(groups_per_launch, (search.max_sum - first_sum) ÷ 120 + 1)
        @cuda threads=THREADS_PER_BLOCK blocks=num_blocks search_kernel!(best_m, first_sum, num_groups, search)
        first_sum += 120 * num_groups
        next_sum = min(first_sum, search.max_sum + 1)  # the first sum that hasn't been checked

        m = Array(best_m)[1]  # waits for the kernel to finish
        if m != no_hit && no_smaller_m_from(UInt128(next_sum), m, search)  # UInt128 so that s² doesn't overflow
            return palindrome_and_factors(n, m)
        end
        groups_per_launch = min(2groups_per_launch, UInt64(MAX_LAUNCH_GROUPS))
    end

    error("found no palindrome product with u + v ≤ $(search.max_sum) for n = $n")
end

# The palindrome with upper half U = B - m and its two factors, B - u and B - v. Here u and v are the roots of
# t² - st + (cB + L) for the smallest carry c whose discriminant is a perfect square.
function palindrome_and_factors(n, m)
    B = big(10)^n
    U = B - m
    L = parse(BigInt, reverse(string(U)))
    c = 0
    while true
        s = big(m) + c
        D = s^2 - 4 * (c * B + L)
        D >= 0 || error("m = $m from the GPU doesn't give a product of two $n-digit numbers")
        root = isqrt(D)
        if root^2 == D
            u, v = (s - root) ÷ 2, (s + root) ÷ 2
            return (palindrome=U * B + L, factors=(B - v, B - u))
        end
        c += 1
    end
end

# The GPU kernel. Each thread checks every num_threads-th group of 120 sums, starting from the group at first_sum.
function search_kernel!(best_m, first_sum::UInt64, num_groups::UInt64, search::GPUSearch)
    thread_index = UInt64((blockIdx().x - 1) * blockDim().x + threadIdx().x - 1)  # from 0
    num_threads = UInt64(gridDim().x) * UInt64(blockDim().x)
    group = thread_index
    while group < num_groups
        check_group!(best_m, first_sum + 120group, search)
        group += num_threads
    end
    return nothing
end

# Check the sums group_start, group_start + 1, ..., group_start + 119 that the residue rules allow. Without a carry
# the mod 3 rule only leaves s ≡ 16, 40 and 64, and closer to the top the middle digit rule only leaves 40.
@inline function check_group!(best_m, group_start::UInt64, search::GPUSearch)
    group_end = group_start + 119
    if group_end < search.only_40_below
        check_sum!(best_m, group_start + 40, 40, search)
    elseif group_end < search.no_carry_below
        check_sum!(best_m, group_start + 16, 16, search)
        check_sum!(best_m, group_start + 40, 40, search)
        check_sum!(best_m, group_start + 64, 64, search)
    else
        for residue in SUM_RESIDUES
            check_sum!(best_m, group_start + residue, residue, search)
        end
    end
    return nothing
end

# Try every carry c for the sum s ≡ residue (mod 120), recording each palindrome that's a product in best_m
@inline function check_sum!(best_m, s::UInt64, residue::Int, search::GPUSearch)
    s <= search.max_sum || return nothing  # only the last group can run past max_sum
    s_squared = widemul(s, s)
    four_B = 4 * search.B
    c = 0
    four_cB = UInt128(0)
    while four_cB <= s_squared  # cB ≤ uv ≤ s²/4
        if passes_mod_3_rule(residue, c) && passes_middle_digit_rule_gpu(s_squared, four_cB, residue, c, search)
            m = s - UInt64(c)
            four_uv = four_cB + 4 * lower_half_gpu(m, search)
            if four_uv <= s_squared && is_perfect_square(s_squared - four_uv)
                CUDA.@atomic best_m[1] = min(best_m[1], m)
            end
        end
        c += 1
        four_cB += four_B
    end
    return nothing
end

# passes_middle_digit_rule with 4cB passed in, since check_sum! keeps it as a running total
@inline function passes_middle_digit_rule_gpu(s_squared, four_cB, residue, c, search::GPUSearch)
    d = mod(c - residue, 10)
    return four_cB + UInt128(4d) * search.leading_digit_place <= s_squared
end

# lower_half on the GPU: the reversed k-digit tail followed by n - k nines
@inline function lower_half_gpu(m::UInt64, search::GPUSearch)
    tail = search.ten_to_tail_digits - m
    # From n = 18 on every tail has 18 digits. Passing that as a constant lets the compiler unroll the digit loops,
    # which makes large n about 10% faster.
    reversed_tail = search.tail_digits == 18 ? reverse_tail_gpu(tail, 18) : reverse_tail_gpu(tail, search.tail_digits)
    return widemul(reversed_tail, search.nines_shift) + (search.nines_shift - 1)
end

# reverse_tail on the GPU, for num_digits ≤ 18. The last 9 digits of x and the rest are reversed separately, which
# makes every division by 10 a cheap 32-bit one. Dividing x itself by 10 makes the whole search about 1.5× slower on
# a V100.
@inline function reverse_tail_gpu(x::UInt64, num_digits::Int)
    high, low = divrem(x, UInt64(10)^9)
    reversed_low, _ = reverse_last_digits(low % UInt32, min(num_digits, 9))
    reversed_high, high_place = reverse_last_digits(high % UInt32, num_digits - 9)
    return UInt64(reversed_low) * high_place + reversed_high
end

# Reverse the last num_digits digits of x, with leading zeros, and also return 10^num_digits
@inline function reverse_last_digits(x::UInt32, num_digits::Int)
    reversed = UInt32(0)
    place = UInt32(1)
    for _ in 1:num_digits
        x, digit = divrem(x, UInt32(10))
        reversed = UInt32(10) * reversed + digit
        place *= UInt32(10)
    end
    return reversed, place
end

# Only 12 of the 64 residues modulo 64 are squares, so checking the low bits first rules out about 81% of the
# non-squares before taking the square root
@inline function is_perfect_square(x::UInt128)
    isodd(SQUARES_MOD_64 >> ((x % UInt64) & 63)) || return false
    root = isqrt_uint128(x)
    return widemul(root, root) == x
end

# ⌊√x⌋ from a Float64 estimate, corrected by comparing squares. Base's isqrt corrects its estimate with a Newton step
# that divides two UInt128s, which makes the whole search about 6× slower on a V100.
@inline function isqrt_uint128(x::UInt128)
    estimate = Float64((x >> 64) % UInt64) * 2.0^64 + Float64(x % UInt64)
    root = unsafe_trunc(UInt64, sqrt(estimate))
    while widemul(root, root) > x
        root -= 1
    end
    while widemul(root + 1, root + 1) <= x
        root += 1
    end
    return root
end

function solve(solve_func=largest_palindrome_product)
    result = solve_func(3)
    @info "Found largest palindrome from 3-digit products: $(result.palindrome) = " *
          "$(result.factors[1]) × $(result.factors[2])"
    return result.palindrome
end

end # module
