"""
Project Euler Bonus Problem: Contfrac

Problem description: https://projecteuler.net/problem=contfrac
Solution description: https://aliramadhan.me/blog/project-euler/bonus-contfrac/
"""
module BonusContfrac

export compute_Q, solve

const LEN_BITS = 4
const DIGIT_BITS = 5
const DIGIT_MASK = (1 << DIGIT_BITS) - 1

# Find the lexicographically smallest rotation of the cycle and pack it into a UInt64.
function encode_rotated(seq::Vector{Int})
    n = length(seq)
    best_s = 1
    for s in 2:n
        for k in 0:(n-1)
            a = seq[mod1(s + k, n)]
            b = seq[mod1(best_s + k, n)]
            if a < b
                best_s = s
                break
            elseif a > b
                break
            end
        end
    end

    key = UInt64(n)
    for i in 0:(n-1)
        v = seq[mod1(best_s + i, n)]
        key |= (UInt64(v) << (LEN_BITS + DIGIT_BITS * i))
    end
    return key
end

function decode_cycle(key::UInt64)
    n = Int(key & ((1 << LEN_BITS) - 1))
    seq = Vector{Int}(undef, n)
    for i in 0:(n-1)
        seq[i+1] = Int((key >> (LEN_BITS + DIGIT_BITS * i)) & DIGIT_MASK)
    end
    return seq
end

# Multiply the PSL_2(Z) generator matrices for the cycle and check |trace| <= 1.
# Int128 is enough headroom for cycle lengths up to ~12 with small entries.
function is_trace_complex(seq::Vector{Int})
    A, B = Int128(1), Int128(0)
    C, D = Int128(0), Int128(1)

    for a in seq
        nA = A * a + B
        nB = -A
        nC = C * a + D
        nD = -C
        A, B, C, D = nA, nB, nC, nD
    end

    tr = A + D
    return -1 <= tr <= 1
end

function is_primitive(seq::Vector{Int})
    n = length(seq)
    for d in 1:(n-1)
        if n % d == 0
            periodic = true
            for i in 1:n
                if seq[i] != seq[mod1(i + d, n)]
                    periodic = false
                    break
                end
            end
            if periodic
                return false
            end
        end
    end
    return true
end

# Rule 2: (a, b) -> (a+1, 1, b+1)
function expand1!(seq::Vector{Int}, out_set::Set{UInt64}, max_n::Int)
    n = length(seq)
    if n < 2 || n + 1 > max_n
        return
    end

    for i in 1:n
        j = mod1(i + 1, n)
        new_seq = Vector{Int}(undef, n + 1)

        new_seq[1] = seq[i] + 1
        new_seq[2] = 1
        new_seq[3] = seq[j] + 1

        idx = 4
        k = mod1(j + 1, n)
        while k != i
            new_seq[idx] = seq[k]
            idx += 1
            k = mod1(k + 1, n)
        end

        if is_trace_complex(new_seq)
            push!(out_set, encode_rotated(new_seq))
        end
    end
end

# Rule 1: (c) -> (a, 0, b) where a + b = c
function expand0!(seq::Vector{Int}, out_set::Set{UInt64}, max_n::Int)
    n = length(seq)
    if n + 2 > max_n
        return
    end

    for i in 1:n
        v = seq[i]
        for a in 0:v
            b = v - a
            new_seq = Vector{Int}(undef, n + 2)

            new_seq[1] = a
            new_seq[2] = 0
            new_seq[3] = b

            idx = 4
            k = mod1(i + 1, n)
            while k != i
                new_seq[idx] = seq[k]
                idx += 1
                k = mod1(k + 1, n)
            end

            if is_trace_complex(new_seq)
                push!(out_set, encode_rotated(new_seq))
            end
        end
    end
end

function compute_Q(max_n::Int=12)
    classes = [Set{UInt64}() for _ in 1:max_n]

    # The irreducible fundamental base cycles
    seeds = [[0], [1], [1, 1], [1, 2], [2, 1], [1, 3], [3, 1]]

    for s in seeds
        if length(s) <= max_n && is_trace_complex(s)
            push!(classes[length(s)], encode_rotated(s))
        end
    end

    for n in 1:max_n
        if isempty(classes[n])
            continue
        end

        for key in classes[n]
            seq = decode_cycle(key)

            if n + 1 <= max_n
                expand1!(seq, classes[n+1], max_n)
            end

            if n + 2 <= max_n
                expand0!(seq, classes[n+2], max_n)
            end
        end
    end

    q_total = 0
    for n in 1:max_n
        class_cnt = 0
        for key in classes[n]
            seq = decode_cycle(key)
            if is_primitive(seq)
                class_cnt += 1
            end
        end

        # Each primitive cycle of length n represents n unique sequences
        # (one per cyclic shift).
        q_total += class_cnt * n
    end

    return q_total
end

solve() = compute_Q(12)

end # module
