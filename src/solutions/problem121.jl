"""
Project Euler Problem 121: Disc Game Prize Fund

A bag contains one red disc and one blue disc. In a game of chance a player takes a disc at
random and its colour is noted. After each turn the disc is returned to the bag, an extra
red disc is added, and another disc is taken at random.

The player pays £1 to play and wins if they have taken more blue discs than red discs at the
end of the game.

If the game is played for four turns, the probability of a player winning is exactly 11/120,
and so the maximum prize fund the banker should allocate for winning in this game would be
£10 before they would expect to incur a loss. Note that any payout will be a whole number of
pounds and also includes the original £1 paid to play the game, so in the example given the
player actually wins £9.

Find the maximum prize fund that should be allocated to a single game in which fifteen turns
are played.

## Solution approach

The problem requires calculating the exact probability of drawing more blue than red discs
over 15 turns, then finding the maximum integer prize fund such that the expected payout
doesn't exceed the £1 entry fee.

In turn i (1 ≤ i ≤ n), the bag contains 1 blue disc and i red discs, so:
- Probability of blue = 1/(i+1)
- Probability of red = i/(i+1)

We use dynamic programming to compute the probability of drawing exactly k blue discs in n
turns. The recurrence relation is: P(n, k) = P(n-1, k) × n/(n+1) + P(n-1, k-1) × 1/(n+1)

Where P(n, k) is the probability of drawing exactly k blue discs in n turns.

To win with n turns, the player needs more than n/2 blue discs. For n=15, they need at least
8 blue discs.

## Complexity analysis

Time complexity: O(n²)
- We compute P(i, j) for all i from 1 to n and j from 0 to i
- Each computation involves constant time rational arithmetic

Space complexity: O(n²)
- We store the dynamic programming table of size n×(n+1)
- Using rational arithmetic preserves exact precision

## Mathematical background

This is a probability problem involving independent events with changing probabilities.
Using exact rational arithmetic is crucial because the final probability is a fraction with
a large denominator, and floating-point arithmetic would introduce rounding errors.

The maximum prize fund is floor(1/P_win) where P_win is the probability of winning. This
ensures the expected payout (P_win × prize) is less than the £1 entry fee.
"""
module Problem121

function calculate_winning_probability(n::Int)
    # dp[i][j] = probability of getting exactly j blue discs in first i turns
    # Using Rational for exact arithmetic
    dp = Matrix{Rational{BigInt}}(undef, n + 1, n + 1)

    # Initialize: 0 turns, 0 blue discs has probability 1
    for j in 0:n
        dp[1, j + 1] = (j == 0) ? Rational{BigInt}(1) : Rational{BigInt}(0)
    end

    # Fill the DP table
    for i in 2:(n + 1)
        for j in 0:(i - 1)
            prob_red = Rational{BigInt}(i - 1, i)  # (i-1)/i probability of red in turn i-1
            prob_blue = Rational{BigInt}(1, i)     # 1/i probability of blue in turn i-1

            dp[i, j + 1] = Rational{BigInt}(0)

            # Case 1: drew red in turn i-1, had j blue discs before
            if j <= i - 2
                dp[i, j + 1] += dp[i - 1, j + 1] * prob_red
            end

            # Case 2: drew blue in turn i-1, had j-1 blue discs before
            if j > 0 && j - 1 <= i - 2
                dp[i, j + 1] += dp[i - 1, j] * prob_blue
            end
        end
    end

    # Calculate probability of winning (more blue than red)
    # With n turns, need more than n/2 blue discs
    min_blue_to_win = div(n, 2) + 1

    winning_prob = Rational{BigInt}(0)
    for j in min_blue_to_win:n
        winning_prob += dp[n + 1, j + 1]
    end

    return winning_prob
end

function solve()
    n = 15
    winning_prob = calculate_winning_probability(n)

    # Maximum prize fund is floor(1 / winning_prob)
    max_prize = Int(floor(1 / winning_prob))

    @info "Probability of winning with $n turns: $winning_prob"
    @info "Maximum prize fund: £$max_prize"

    return max_prize
end

end # module
