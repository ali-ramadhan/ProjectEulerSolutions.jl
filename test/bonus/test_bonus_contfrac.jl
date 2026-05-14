using Test
using ProjectEulerSolutions.BonusContfrac:
    encode_rotated,
    decode_cycle,
    is_elliptic,
    is_primitive,
    compute_Q,
    solve
using ProjectEulerSolutions.Utils.AnswerHashing

# encode_rotated picks the lexicographically smallest rotation, so cyclic
# shifts of the same cycle must collide.
@test encode_rotated([1, 2, 3]) == encode_rotated([2, 3, 1]) == encode_rotated([3, 1, 2])
@test encode_rotated([3, 1]) == encode_rotated([1, 3])
@test encode_rotated([2, 1]) == encode_rotated([1, 2])

# decode_cycle inverts encode_rotated, returning the canonical rotation.
@test decode_cycle(encode_rotated([2, 3, 1])) == [1, 2, 3]
@test decode_cycle(encode_rotated([3, 1])) == [1, 3]
@test decode_cycle(encode_rotated([0])) == [0]

# Distinct cycles must produce distinct keys.
@test encode_rotated([1, 2]) != encode_rotated([1, 3])
@test encode_rotated([1, 1]) != encode_rotated([1, 2])

# Every seed cycle in the algorithm is elliptic (trace ∈ {-1, 0, +1}).
for seed in ([0], [1], [1, 1], [1, 2], [2, 1], [1, 3], [3, 1])
    @test is_elliptic(seed)
end

# Cycles whose matrix product is parabolic (|tr|=2) or hyperbolic (|tr|>2)
# must not be flagged elliptic.
@test !is_elliptic([2, 2])  # trace = 2 (parabolic)
@test !is_elliptic([5])     # trace = 5 (hyperbolic)

# Primitivity: repetitions of a shorter cycle are not primitive.
@test is_primitive([1, 2])
@test is_primitive([1, 3])
@test is_primitive([0, 0, 1])
@test !is_primitive([1, 1])           # period 1
@test !is_primitive([1, 2, 1, 2])     # period 2
@test !is_primitive([1, 2, 3, 1, 2, 3])  # period 3

# Q(1): only the seeds [0] and [1], each a primitive cycle of length 1.
@test compute_Q(1) == 2

# Q(2): adds three new primitive classes ([1,2] and [1,3]; [1,1] is non-primitive).
# Counts as 2 (length 1) + 2*2 (two primitive length-2 classes) = 6.
@test compute_Q(2) == 6

# Correct answer
@test_answer solve() "contfrac" "bonus"
