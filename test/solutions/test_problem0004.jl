using Test
import CUDA
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0004

for largest_palindrome in (largest_palindrome_product_naive, largest_palindrome_product_pruned,
                           largest_palindrome_product_fermat, largest_palindrome_product_fermat_filtered)
    # Test example from problem description
    @test largest_palindrome(2).palindrome == 9009
    @test largest_palindrome(2).factors == (91, 99)

    # Test type genericity
    @test largest_palindrome(2, Int32).palindrome == Int32(9009)
    @test largest_palindrome(3, Int128).palindrome == Int128(906609)

    # Correct answer
    @test_answer solve(largest_palindrome) "0004"
end

# 6-digit factors take hours with the naive search, so only the pruned one is tested there
@test largest_palindrome_product_pruned(6).palindrome == 999000000999

# The palindrome-first searches find the same palindrome and factors as the pruned search for 2- to 8-digit factors
for n in 2:8
    expected = largest_palindrome_product_pruned(n)
    @test largest_palindrome_product_fermat(n) == expected
    @test largest_palindrome_product_fermat_filtered(n) == expected
end

for fermat in (largest_palindrome_product_fermat, largest_palindrome_product_fermat_filtered)
    # Beyond that the pruned search is slow, so check against known answers. For 9-digit factors u*v carries into
    # the top half.
    @test fermat(9) == (palindrome=999900665566009999, factors=(999920317, 999980347))
    @test fermat(10).palindrome == 99999834000043899999
    @test fermat(12).palindrome == 999999000000000000999999

    # The palindrome-first searches only look at 2n-digit palindromes, so they need n ≥ 2
    @test_throws ArgumentError fermat(1)
end

# The filtered search is fast enough to also check a carry of 2 (17 digits) and Int128 factors (20 digits)
@test largest_palindrome_product_fermat_filtered(17) ==
      (palindrome=9999999887065624224265607889999999, factors=(99999999127775321, 99999999742880919))
@test largest_palindrome_product_fermat_filtered(20).palindrome == big"9999999999694448232002328444969999999999"

# The GPU search needs a working NVIDIA GPU, and Julia 1.12 or later to pass UInt128s to the kernel
if CUDA.functional() && VERSION >= v"1.12"
    # Below 6 digits the answer is too far from the top for the residue rules, and past 37 digits 4B overflows
    @test_throws ArgumentError largest_palindrome_product_gpu(5)
    @test_throws ArgumentError largest_palindrome_product_gpu(38)

    for n in 6:16
        @test largest_palindrome_product_gpu(n) == largest_palindrome_product_fermat_filtered(n)
    end

    @test largest_palindrome_product_gpu(17) ==
          (palindrome=9999999887065624224265607889999999, factors=(99999999127775321, 99999999742880919))
    @test largest_palindrome_product_gpu(20).palindrome == big"9999999999694448232002328444969999999999"

    # The GPU search found this first, and the filtered search on the CPU agrees
    @test largest_palindrome_product_gpu(25) ==
          (palindrome=99999999999994430707230000003270703449999999999999,
           factors=(9999999999999449006736499, 9999999999999994063986501))
else
    @info "Skipping the GPU tests since they need a working GPU and Julia 1.12 or later"
end

# Test max_product constraint (HackerRank version)
@test largest_palindrome_product_pruned(3, max_product=900000).palindrome == 888888
@test largest_palindrome_product_pruned(3, max_product=900000).factors == (924, 962)

# Both searches over pairs find the same palindrome. The factors can differ when a palindrome has several factor
# pairs since the two searches visit pairs in different orders.
for n in 1:3
    @test largest_palindrome_product_pruned(n).palindrome == largest_palindrome_product_naive(n).palindrome
end

# Correct answer
@test_answer solve() "0004"
