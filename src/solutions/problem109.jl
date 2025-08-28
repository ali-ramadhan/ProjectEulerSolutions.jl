"""
Project Euler Problem 109: Darts

In the game of darts players will usually check out when their remaining score is less
than 100. You are not allowed to score below 1 (i.e. if you have 12 to go out you
cannot score 11 and 1). The common way of finishing in darts is to score a double (the
outer red/green ring on the dart board); however, at the professional level any double
or triple can be used.

When a player is able to finish on their current score it is called a "check out" and
the highest check out is 170: T20 T20 D25 (two treble 20s and double bull).

There are exactly eleven distinct ways to check out on a score of 6:

D3
D1 D2
S2 D2
D2 D1
S4 D1
S1 S1 D2
S1 T1 D1
S1 S3 D1
D1 S2 D1
D1 T1 D1
S2 S2 D1

Note that D1 D2 and D2 D1 are considered different ways, as are S1 T1 D1 and T1 S1 D1.
However, the combination S1 T1 D1 is the same as S1 T1 D1.

How many distinct ways can a player check out with a score less than 100?

## Solution approach

The key insight is that we need to count all possible dart combinations that:
1. Sum to each target score from 2 to 99
2. End with a double (last dart must be a double)
3. Use at most 3 darts
4. Order matters between different dart positions

We generate all possible dart scores with their types:
- Singles: 1-20, 25
- Doubles: 2, 4, 6, ..., 40, 50
- Triples: 3, 6, 9, ..., 60

The counting rules are:
- 1-dart checkouts: Just doubles that equal the target
- 2-dart checkouts: Order matters completely
- 3-dart checkouts: First two darts are combinations (unordered)

## Complexity analysis

Time complexity: O(n × d³) where n is the number of target scores (98) and d is the
number of distinct dart scores (62).

Space complexity: O(d) for storing the dart arrays.

## Key insights

The critical insight is properly handling the ordering rules:
- 2-dart: D1 D2 ≠ D2 D1 (different finishing doubles)
- 3-dart: S1 T1 D1 = T1 S1 D1 (first two darts are unordered)
"""
module Problem109

"""
    generate_dart_values()

Generate all possible dart scores including singles, doubles, triples, and miss.

Returns a tuple (all_values, doubles) where:
- all_values: Vector of all possible dart scores including 0 for miss
- doubles: Vector of all possible finishing doubles
"""
function generate_dart_values()
    singles = [1:20..., 25]  # Singles 1-20 plus outer bull (25)
    doubles = [2:2:40..., 50]  # Doubles 2,4,...,40 plus inner bull (50) 
    triples = [3:3:60...]  # Triples 3,6,...,60
    
    all_values = [singles..., doubles..., triples..., 0]  # Include miss (0)
    
    return all_values, doubles
end

"""
    count_checkouts_under_limit(limit)

Count the number of distinct dart checkout combinations that total less than the given limit.
Each checkout must end with a double (doubles-out rule).

The first two darts can be any combination (with replacement) of all possible dart values.
Order doesn't matter for the first two darts (combinations, not permutations).
"""
function count_checkouts_under_limit(limit)
    all_values, doubles = generate_dart_values()
    
    num_checkouts = 0
    
    # Each checkout: up to 2 preliminary darts + 1 finishing double
    for double in doubles
        # First two throws: combinations with replacement
        for i in 1:length(all_values)
            for j in i:length(all_values)
                throw1, throw2 = all_values[i], all_values[j]
                checkout_total = double + throw1 + throw2
                if checkout_total < limit
                    num_checkouts += 1
                end
            end
        end
    end
    
    return num_checkouts
end

function solve()
    return count_checkouts_under_limit(100)
end

end # module