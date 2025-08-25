"""
Project Euler Problem 84: Monopoly Odds

In the game, Monopoly, the standard board is set up in the following way:

GO	A1	CC1	A2	T1	R1	B1	CH1	B2	B3	JAIL
H2										C1
T2										U1
H1										C2
CH3										C3
R4										R2
G3										D1
CC3										CC2
G2										D2
G1										D3
G2J	F3	U2	F2	F1	R3	E3	E2	CH2	E1	FP

A player starts on the GO square and adds the scores on two 6-sided dice to determine
the number of squares they advance in a clockwise direction. Without any further rules
we would expect to visit each square with equal probability: 2.5%. However, landing on
G2J (Go To Jail), CC (community chest), and CH (chance) changes this distribution.

In addition to G2J, and one card from each of CC and CH, that orders the player to go
directly to jail, if a player rolls three consecutive doubles, they do not advance the
result of their 3rd roll. Instead they proceed directly to jail.

The heart of this problem concerns the likelihood of visiting a particular square. That
is, the probability of finishing at that square after a roll. For this reason it should
be clear that, with the exception of G2J for which the probability of finishing on it is
zero, the CH squares will have the lowest probabilities, as 5/8 request a movement to
another square, and it is the final square that the player finishes at on each roll that
we are interested in. We shall make no distinction between "Just Visiting" and being
sent to JAIL, and with CH the condition is that a player is sent to the nearest utility
if they draw the "utility" card and are on CH1, they will go to U1; if they are on CH2,
they will go to U2; if they are on CH3, they will go to U1 (wrapping around).

At the beginning of the game, the CC and CH cards are shuffled. When a player lands on
CC or CH they take a card from the top of the respective pile and, after following the
instructions, it is returned to the bottom of the pile. There are sixteen cards in each
pile, but for the sake of this problem we are only concerned with cards that order a
movement; any instruction not concerned with movement will be ignored and the player
will remain on the CC/CH square.

Community Chest (2/16 cards):
1. Advance to GO
2. Go to JAIL

Chance (10/16 cards):
1. Advance to GO
2. Go to JAIL
3. Go to C1
4. Go to E3
5. Go to H2
6. Go to R1
7. Go to the next R (railway company)
8. Go to the next R
9. Go to next U (utility company)
10. Go back 3 squares.

So, the most popular squares, in order, are JAIL (6.24%) = Square 10, E3 (3.18%) =
Square 24, and GO (3.09%) = Square 00. So these give the six-digit modal string 102400.

If, instead of using two 6-sided dice, two 4-sided dice are used, find the six-digit
modal string.
"""
module Problem084

# Monopoly board squares (0-39)
const BOARD_SQUARES = [
    "GO",
    "A1",
    "CC1",
    "A2",
    "T1",
    "R1",
    "B1",
    "CH1",
    "B2",
    "B3",      # 00-09
    "JAIL",
    "C1",
    "U1",
    "C2",
    "C3",
    "R2",
    "D1",
    "CC2",
    "D2",
    "D3",     # 10-19
    "FP",
    "E1",
    "CH2",
    "E2",
    "E3",
    "R3",
    "F1",
    "F2",
    "U2",
    "F3",       # 20-29
    "G2J",
    "G1",
    "CC3",
    "G2",
    "G3",
    "R4",
    "CH3",
    "H1",
    "T2",
    "H2",      # 30-39
]

# Special squares
const GO = 0
const JAIL = 10
const G2J = 30
const CC_SQUARES = [2, 17, 33]
const CH_SQUARES = [7, 22, 36]
const R_SQUARES = [5, 15, 25, 35]  # Railways
const U_SQUARES = [12, 28]         # Utilities

"""
    community_chest()

Handle Community Chest card draw.
Returns the destination square (or nothing if no movement).
"""
function community_chest()
    card = rand(1:16)
    if card == 1
        return GO  # Advance to GO
    elseif card == 2
        return JAIL  # Go to JAIL
    else
        return nothing  # Stay where you are
    end
end

"""
    chance(current_square::Int)

Handle Chance card draw from the given square.
Returns the destination square (or nothing if no movement).
"""
function chance(current_square::Int)
    # 16 cards total, 10 cause movement
    card = rand(1:16)

    if card == 1
        return GO  # Advance to GO
    elseif card == 2
        return JAIL  # Go to JAIL
    elseif card == 3
        return 11  # C1
    elseif card == 4
        return 24  # E3
    elseif card == 5
        return 39  # H2
    elseif card == 6
        return 5   # R1
    elseif card == 7 || card == 8
        # Next railway
        next_railway = findfirst(r -> r > current_square, R_SQUARES)
        return next_railway === nothing ? R_SQUARES[1] : R_SQUARES[next_railway]
    elseif card == 9
        # Next utility
        next_utility = findfirst(u -> u > current_square, U_SQUARES)
        return next_utility === nothing ? U_SQUARES[1] : U_SQUARES[next_utility]
    elseif card == 10
        # Go back 3 squares
        return (current_square - 3 + 40) % 40
    else
        return nothing  # Stay where you are
    end
end

"""
    simulate_monopoly(num_rolls::Int, dice_sides::Int)

Simulate Monopoly game for the given number of rolls using dice with given sides.
Returns a dictionary with square visit counts.
"""
function simulate_monopoly(num_rolls::Int, dice_sides::Int)
    position = 0
    doubles_count = 0
    visit_counts = zeros(Int, 40)

    for _ in 1:num_rolls
        # Roll dice
        die1 = rand(1:dice_sides)
        die2 = rand(1:dice_sides)
        roll_sum = die1 + die2
        is_double = die1 == die2

        if is_double
            doubles_count += 1
            if doubles_count == 3
                # Three consecutive doubles - go to jail
                position = JAIL
                doubles_count = 0
                visit_counts[position + 1] += 1
                continue
            end
        else
            doubles_count = 0
        end

        # Move based on dice roll
        position = (position + roll_sum) % 40

        # Handle special squares
        if position == G2J
            # Go To Jail
            position = JAIL
        elseif position in CC_SQUARES
            # Community Chest
            cc_destination = community_chest()
            if cc_destination !== nothing
                position = cc_destination
            end
        elseif position in CH_SQUARES
            # Chance
            ch_destination = chance(position)
            if ch_destination !== nothing
                position = ch_destination
                # Handle secondary effects (if we land on another special square)
                if position == G2J
                    position = JAIL
                elseif position in CC_SQUARES
                    cc_destination = community_chest()
                    if cc_destination !== nothing
                        position = cc_destination
                    end
                end
            end
        end

        # Record visit
        visit_counts[position + 1] += 1
    end

    return visit_counts
end

"""
    get_modal_string(visit_counts::Vector{Int})

Get the six-digit modal string representing the three most visited squares.
"""
function get_modal_string(visit_counts::Vector{Int})
    sorted_indices = sortperm(visit_counts; rev = true)

    top_three = [(sorted_indices[i] - 1) for i in 1:3]

    return string(
        lpad(top_three[1], 2, '0'),
        lpad(top_three[2], 2, '0'),
        lpad(top_three[3], 2, '0'),
    )
end

function solve()
    num_rolls = 5_000_000
    visit_counts = simulate_monopoly(num_rolls, 4)
    return get_modal_string(visit_counts)
end

end # module
