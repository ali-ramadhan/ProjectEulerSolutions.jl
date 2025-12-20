using Test

using ProjectEulerSolutions.Utils.Primes
using ProjectEulerSolutions.Utils.Primes: get_witnesses

@testset "Primes" begin
    @testset "is_prime" begin
        for primality_test in (TrialDivision(), MillerRabin())
                @testset "is_prime ($primality_test)" begin
                # Small primes
                @test !is_prime(1, primality_test)
                @test is_prime(2, primality_test)
                @test is_prime(3, primality_test)
                @test !is_prime(4, primality_test)
                @test is_prime(5, primality_test)
                @test !is_prime(6, primality_test)
                @test is_prime(7, primality_test)
                @test !is_prime(8, primality_test)
                @test !is_prime(9, primality_test)
                @test !is_prime(10, primality_test)
                @test is_prime(11, primality_test)
                @test !is_prime(12, primality_test)
                @test is_prime(13, primality_test)
                @test !is_prime(14, primality_test)
                @test !is_prime(15, primality_test)

                # Larger primes
                @test is_prime(17, primality_test)
                @test is_prime(23, primality_test)
                @test is_prime(41, primality_test)
                @test is_prime(1601, primality_test)
                @test is_prime(3797, primality_test)
                @test is_prime(2143, primality_test)

                # Larger composites
                @test !is_prime(91, primality_test)   # 7 * 13
                @test !is_prime(121, primality_test)  # 11^2
                @test !is_prime(143, primality_test)  # 11 * 13
            end
        end
    end

    @testset "Miller-Rabin precomputed witnesses" begin
        # Test that MillerRabin(max_n) creates correct witness sets
        @test length(MillerRabin(1000).witnesses) == 1
        @test length(MillerRabin(10^6).witnesses) == 2
        @test length(MillerRabin(10^9).witnesses) == 4
        @test length(MillerRabin(10^12).witnesses) == 4
        @test length(MillerRabin(10^15).witnesses) == 9
        @test length(MillerRabin(10^18).witnesses) == 9

        # Test get_witnesses returns correct bounds
        @test get_witnesses(2046) == (2,)
        @test get_witnesses(2047) == (2, 3)  # crosses first threshold
        @test get_witnesses(1_373_652) == (2, 3)
        @test get_witnesses(1_373_653) == (31, 73)  # crosses to next set

        # Test precomputed mode matches auto-select mode
        mr_precomputed = MillerRabin(10^6)
        for n in [2, 3, 4, 5, 97, 100, 1009, 1000, 104729, 104730]
            @test is_prime(n, MillerRabin()) == is_prime(n, mr_precomputed)
        end

        # Test large primes near witness set boundaries
        @test is_prime(2039, MillerRabin())       # prime < 2047 (1 witness)
        @test is_prime(1373639, MillerRabin())    # prime < 1_373_653 (2 witnesses)
        @test is_prime(3215031733, MillerRabin()) # prime < 3_215_031_751 (4 witnesses)

        # Test composites near boundaries (Carmichael-like numbers that might fool weak tests)
        @test !is_prime(2047, MillerRabin())     # 23 * 89
        @test !is_prime(1373653, MillerRabin())  # composite
    end

    @testset "Sieve of Eratosthenes" begin
        @test sieve_of_eratosthenes(10) == [2, 3, 5, 7]
        @test sieve_of_eratosthenes(20) == [2, 3, 5, 7, 11, 13, 17, 19]
        @test sieve_of_eratosthenes(2) == [2]
        @test sieve_of_eratosthenes(1) == Int[]
        @test sieve_of_eratosthenes(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

        # Test that it includes the limit when it's prime
        @test 29 in sieve_of_eratosthenes(29)
        @test 31 in sieve_of_eratosthenes(31)

        @test sum_sieve_of_eratosthenes(10) == 17   # 2 + 3 + 5 + 7
        @test sum_sieve_of_eratosthenes(20) == 77   # 2 + 3 + 5 + 7 + 11 + 13 + 17 + 19
        @test sum_sieve_of_eratosthenes(2) == 2
        @test sum_sieve_of_eratosthenes(1) == 0
        @test sum_sieve_of_eratosthenes(0) == 0
        @test sum_sieve_of_eratosthenes(30) == 129  # 2 + 3 + 5 + 7 + 11 + 13 + 17 + 19 + 23 + 29

        # Verify consistency
        for n in [10, 50, 100, 500, 1024]
            @test sum_sieve_of_eratosthenes(n) == sum(sieve_of_eratosthenes(n))
        end
    end

    @testset "Prime factors" begin
        @test prime_factors(1) == Int[]
        @test prime_factors(2) == [2]
        @test prime_factors(3) == [3]
        @test prime_factors(4) == [2, 2]
        @test prime_factors(6) == [2, 3]
        @test prime_factors(8) == [2, 2, 2]
        @test prime_factors(12) == [2, 2, 3]
        @test prime_factors(15) == [3, 5]
        @test prime_factors(60) == [2, 2, 3, 5]
        @test prime_factors(100) == [2, 2, 5, 5]

        # Prime numbers should return themselves
        @test prime_factors(7) == [7]
        @test prime_factors(11) == [11]
        @test prime_factors(13) == [13]
    end
end
