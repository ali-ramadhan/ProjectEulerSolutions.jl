"""
Project Euler Problem 54: Poker Hands

In the card game poker, a hand consists of five cards and are ranked, from lowest to
highest:

  - High Card: Highest value card.
  - One Pair: Two cards of the same value.
  - Two Pairs: Two different pairs.
  - Three of a Kind: Three cards of the same value.
  - Straight: All cards are consecutive values.
  - Flush: All cards of the same suit.
  - Full House: Three of a kind and a pair.
  - Four of a Kind: Four cards of the same value.
  - Straight Flush: All cards are consecutive values of same suit.
  - Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

The cards are valued in the order: 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins.
But if two ranks tie, for example, both players have a pair of queens, then highest cards
in each hand are compared; if the highest cards tie then the next highest cards are
compared, and so on.

The file poker.txt contains one-thousand random hands dealt to two players.
Each line of the file contains ten cards (separated by a single space):
the first five are Player 1's cards and the last five are Player 2's cards.

How many hands does Player 1 win?

## Solution approach

The solution implements a complete poker hand evaluator using enumerated hand ranks and
structured card representation. Each hand is evaluated to determine its rank and
tie-breaking values. Hand comparison follows poker rules exactly, including special cases
like ace-low straights. The implementation groups cards by value frequency for efficient
pattern matching.

## Complexity analysis

Time complexity: O(n)
- n hands to process, each taking O(1) time to evaluate and compare
- Hand evaluation involves sorting 5 cards and pattern matching

Space complexity: O(1)
- Constant space for hand evaluation regardless of input size
"""
module Problem0054

const CARD_VALUES = Dict(
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14,
)

@enum HandRank begin
    HighCard = 1
    OnePair = 2
    TwoPairs = 3
    ThreeOfAKind = 4
    Straight = 5
    Flush = 6
    FullHouse = 7
    FourOfAKind = 8
    StraightFlush = 9
    RoyalFlush = 10
end

"""
    Card

Represents a playing card with a value (2-14) and a suit (H, D, C, S).
"""
struct Card
    value::Int  # 2-14 (Ace is 14)
    suit::Char  # H, D, C, S
end

"""
    parse_card(card_str)

Parse a card from string representation (e.g., "5H", "TC", "AS").
"""
function parse_card(card_str)
    value = CARD_VALUES[card_str[1]]
    suit = card_str[2]
    return Card(value, suit)
end

"""
    parse_hand(hand_str)

Parse a hand of 5 cards from a space-separated string.
"""
function parse_hand(hand_str)
    card_strs = split(hand_str)
    return [parse_card(card_str) for card_str in card_strs]
end

"""
    parse_line(line)

Parse a line containing both player hands (10 cards total).
"""
function parse_line(line)
    cards = split(line)
    player1_hand = [parse_card(cards[i]) for i in 1:5]
    player2_hand = [parse_card(cards[i]) for i in 6:10]
    return player1_hand, player2_hand
end

"""
    get_value_counts(hand)

Count the frequency of each card value in the hand.
Returns a dictionary where keys are card values and values are counts.
"""
function get_value_counts(hand)
    value_counts = Dict{Int, Int}()
    for card in hand
        value_counts[card.value] = get(value_counts, card.value, 0) + 1
    end
    return value_counts
end

"""
    group_by_count(value_counts)

Group card values by their frequency count.
Returns a dictionary where keys are counts (1-4) and values are lists of card values.
Each list is sorted in descending order (higher card values first).
"""
function group_by_count(value_counts)
    result = Dict{Int, Vector{Int}}()
    for (value, count) in value_counts
        if !haskey(result, count)
            result[count] = Int[]
        end
        push!(result[count], value)
    end

    for count in keys(result)
        sort!(result[count]; rev = true)
    end

    return result
end

"""
    is_flush(hand)

Check if all cards in the hand have the same suit.
"""
function is_flush(hand)
    return length(Set(card.suit for card in hand)) == 1
end

"""
    is_ace_low_straight(values)

Check if the sorted values form an A-5 straight (A,2,3,4,5).
"""
function is_ace_low_straight(sorted_values)
    return sorted_values == [2, 3, 4, 5, 14]
end

"""
    is_straight(sorted_values)

Check if the sorted values form a straight.
"""
function is_straight(sorted_values)
    if is_ace_low_straight(sorted_values)
        return true
    end

    return (sorted_values[5] - sorted_values[1] == 4) && (length(Set(sorted_values)) == 5)
end

"""
    get_straight_high_value(sorted_values)

Get the high value of a straight. For A-5 straight, returns 5.
For other straights, returns the highest card.
"""
function get_straight_high_value(sorted_values)
    if is_ace_low_straight(sorted_values)
        return 5
    else
        return sorted_values[5]  # Highest card
    end
end

"""
    evaluate_hand(hand)

Evaluate the hand and return its rank and values for comparison.
Returns a tuple with the hand rank and an array of values for tie-breaking.
"""
function evaluate_hand(hand)
    values = sort([card.value for card in hand])
    value_counts = get_value_counts(hand)
    grouped = group_by_count(value_counts)

    has_flush = is_flush(hand)
    has_straight = is_straight(values)

    # Royal flush
    if has_flush && has_straight && values[1] == 10
        return RoyalFlush, [0]  # No tiebreaker needed
    end

    # Straight flush
    if has_flush && has_straight
        return StraightFlush, [get_straight_high_value(values)]
    end

    # Four of a kind
    if haskey(grouped, 4)
        four_value = grouped[4][1]
        kicker = get(grouped, 1, Int[])[1]
        return FourOfAKind, [four_value, kicker]
    end

    # Full house
    if haskey(grouped, 3) && haskey(grouped, 2)
        three_value = grouped[3][1]
        two_value = grouped[2][1]
        return FullHouse, [three_value, two_value]
    end

    # Flush
    if has_flush
        return Flush, reverse(values)
    end

    # Straight
    if has_straight
        return Straight, [get_straight_high_value(values)]
    end

    # Three of a kind
    if haskey(grouped, 3)
        three_value = grouped[3][1]
        kickers = get(grouped, 1, Int[])
        return ThreeOfAKind, [three_value, kickers...]
    end

    # Two pairs
    if haskey(grouped, 2) && length(grouped[2]) == 2
        pairs = grouped[2]
        kicker = get(grouped, 1, Int[])[1]
        return TwoPairs, [pairs..., kicker]
    end

    # One pair
    if haskey(grouped, 2)
        pair_value = grouped[2][1]
        kickers = get(grouped, 1, Int[])
        return OnePair, [pair_value, kickers...]
    end

    # High card
    return HighCard, reverse(values)  # High to low
end

"""
    compare_hands(hand1, hand2)

Compare two hands and return true if hand1 wins, false otherwise.
"""
function compare_hands(hand1, hand2)
    rank1, values1 = evaluate_hand(hand1)
    rank2, values2 = evaluate_hand(hand2)

    if rank1 > rank2
        return true
    elseif rank1 < rank2
        return false
    else
        for (v1, v2) in zip(values1, values2)
            if v1 > v2
                return true
            elseif v1 < v2
                return false
            end
        end
        return false  # Tie, which doesn't happen in this problem
    end
end

"""
    count_player1_wins(filename)

Count how many hands Player 1 wins from the hands in the given file.
"""
function count_player1_wins(filename)
    lines = readlines(filename)
    player1_wins = 0

    for line in lines
        hand1, hand2 = parse_line(line)
        if compare_hands(hand1, hand2)
            player1_wins += 1
        end
    end

    return player1_wins
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0054_poker.txt")
    wins = count_player1_wins(data_filepath)
    @info "Player 1 wins $wins out of 1000 poker hands"
    return wins
end

end # module
