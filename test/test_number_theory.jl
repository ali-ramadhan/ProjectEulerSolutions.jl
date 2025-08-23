using ProjectEulerSolutions.Utils.NumberTheory: euler_totient, totient_sieve, is_coprime

@testset "NumberTheory Utils" begin
    @testset "is_coprime" begin
        @test is_coprime(1, 1)
        @test is_coprime(1, 5)
        @test is_coprime(5, 1)
        @test is_coprime(3, 5)
        @test is_coprime(7, 9)
        @test is_coprime(8, 9)
        @test is_coprime(14, 15)
        
        @test !is_coprime(6, 9)   # gcd = 3
        @test !is_coprime(12, 18) # gcd = 6
        @test !is_coprime(4, 8)   # gcd = 4
        @test !is_coprime(10, 15) # gcd = 5
    end

    @testset "euler_totient" begin
        @test euler_totient(1) == 1
        @test euler_totient(2) == 1   # only 1 is coprime with 2
        @test euler_totient(3) == 2   # 1, 2 are coprime with 3
        @test euler_totient(4) == 2   # 1, 3 are coprime with 4
        @test euler_totient(5) == 4   # 1, 2, 3, 4 are coprime with 5
        @test euler_totient(6) == 2   # 1, 5 are coprime with 6
        @test euler_totient(7) == 6   # 1, 2, 3, 4, 5, 6 are coprime with 7
        @test euler_totient(8) == 4   # 1, 3, 5, 7 are coprime with 8
        @test euler_totient(9) == 6   # 1, 2, 4, 5, 7, 8 are coprime with 9
        @test euler_totient(10) == 4  # 1, 3, 7, 9 are coprime with 10
        
        # Prime numbers: φ(p) = p - 1
        @test euler_totient(11) == 10
        @test euler_totient(13) == 12
        @test euler_totient(17) == 16
        
        # Powers of primes: φ(p^k) = p^k - p^(k-1)
        @test euler_totient(25) == 20  # φ(5²) = 5² - 5¹ = 25 - 5 = 20
        @test euler_totient(27) == 18  # φ(3³) = 3³ - 3² = 27 - 9 = 18
    end

    @testset "totient_sieve" begin
        result = totient_sieve(10)
        @test length(result) == 10  # indices 1 to 10
        @test result[1] == 1
        @test result[2] == 1
        @test result[3] == 2
        @test result[4] == 2
        @test result[5] == 4
        @test result[6] == 2
        @test result[7] == 6
        @test result[8] == 4
        @test result[9] == 6
        @test result[10] == 4
        
        # Test consistency with individual euler_totient calls
        for i in 1:10
            @test result[i] == euler_totient(i)
        end
    end

    @testset "totient_sieve performance vs individual calls" begin
        # For larger numbers, sieve should give same results
        sieve_result = totient_sieve(50)
        for i in 1:50
            @test sieve_result[i] == euler_totient(i)
        end
    end
end