using Test

using ProjectEulerSolutions.Utils.Primes: is_prime, sieve_of_eratosthenes, prime_factors

@testset "Primes" begin
    @testset "is_prime" begin
        # Small primes
        @test !is_prime(1)
        @test is_prime(2)
        @test is_prime(3)
        @test !is_prime(4)
        @test is_prime(5)
        @test !is_prime(6)
        @test is_prime(7)
        @test !is_prime(8)
        @test !is_prime(9)
        @test !is_prime(10)
        @test is_prime(11)
        @test !is_prime(12)
        @test is_prime(13)
        @test !is_prime(14)
        @test !is_prime(15)

        # Larger primes
        @test is_prime(17)
        @test is_prime(23)
        @test is_prime(41)
        @test is_prime(1601)
        @test is_prime(3797)
        @test is_prime(2143)

        # Larger composites
        @test !is_prime(91)   # 7 * 13
        @test !is_prime(121)  # 11^2
        @test !is_prime(143)  # 11 * 13
    end

    @testset "sieve_of_eratosthenes" begin
        @test sieve_of_eratosthenes(10) == [2, 3, 5, 7]
        @test sieve_of_eratosthenes(20) == [2, 3, 5, 7, 11, 13, 17, 19]
        @test sieve_of_eratosthenes(2) == [2]
        @test sieve_of_eratosthenes(1) == Int[]
        @test sieve_of_eratosthenes(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

        # Test that it includes the limit when it's prime
        @test 29 in sieve_of_eratosthenes(29)
        @test 31 in sieve_of_eratosthenes(31)
    end

    @testset "prime_factors" begin
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
