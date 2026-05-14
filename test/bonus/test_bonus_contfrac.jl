using Test
using ProjectEulerSolutions.BonusContfrac:
    encode_rotated,
    decode_cycle,
    is_trace_complex,
    is_primitive,
    compute_Q,
    solve
using ProjectEulerSolutions.Utils.AnswerHashing

# encode_rotated picks the lexicographically smallest rotation, so cyclic
# shifts of the same cycle must collide.
@test encode_rotated([1, 2, 3]) == encode_rotated([2, 3, 1])
@test encode_rotated([1, 2, 3]) == encode_rotated([3, 1, 2])
@test encode_rotated([1, 1]) == encode_rotated([1, 1])
@test encode_rotated([1, 2]) == encode_rotated([2, 1])
@test encode_rotated([1, 3]) == encode_rotated([3, 1])

# Distinct cycles must encode differently.
@test encode_rotated([1, 2]) != encode_rotated([1, 3])
@test encode_rotated([1, 1]) != encode_rotated([1, 2])

# decode_cycle returns the canonical rotation produced by encode_rotated.
@test decode_cycle(encode_rotated([2, 3, 1])) == [1, 2, 3]
@test decode_cycle(encode_rotated([3, 1])) == [1, 3]
@test decode_cycle(encode_rotated([0])) == [0]

# All seed cycles in the algorithm have |trace| <= 1.
for seed in ([0], [1], [1, 1], [1, 2], [2, 1], [1, 3], [3, 1])
    @test is_trace_complex(seed)
end

# A cycle whose product is hyperbolic (|trace| > 1) must not be flagged complex.
@test !is_trace_complex([2, 2])  # trace = 2
@test !is_trace_complex([5])     # trace = 5

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
