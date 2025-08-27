"""
Project Euler Problem 93: Arithmetic expressions

By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the
four arithmetic operations (+, -, *, /) and brackets/parentheses, it is possible to form
different positive integer targets.

For example,

8 = (4 * (1 + 3)) / 2
14 = 4 * (3 + 1 / 2)
19 = 4 * (2 + 3) - 1
36 = 3 * 4 * (2 + 1)

Note that concatenations of the digits, like 12 + 34, are not allowed.

Using the set {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of
which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering
the first non-obtainable number.

Find the set of four distinct digits, a < b < c < d, for which the longest set of
consecutive positive integers, 1 to n, can be obtained, giving your answer as a four digit
number abcd.

## Solution approach

We systematically evaluate all possible arithmetic expressions for each 4-digit combination:

1. **Digit permutations**: Try all 24 permutations of 4 digits
2. **Operation combinations**: Try all 64 combinations of (+, -, ×, ÷) for 3 operations
3. **Parenthesization patterns**: Use 5 explicit patterns covering all binary tree
   structures
4. **Rational arithmetic**: Handle fractional intermediate results exactly to avoid
   precision issues

For each valid positive integer result, we track which consecutive integers starting from 1
can be formed.

## Complexity analysis

Time complexity: O(C(10,4) × 4! × 4³ × P) = O(210 × 24 × 64 × 5) ≈ O(1.6M operations)
- C(10,4): Choose 4 digits from 0-9
- 4!: All permutations of chosen digits
- 4³: All operation combinations
- P=5: Parenthesization patterns

Space complexity: O(R) where R is the number of achievable results per digit set
- Typically R ≤ 100 for most digit combinations
"""
module Problem093

using Combinatorics

function safe_op(op, a, b)
    """Safely apply operation using rational arithmetic, returning nothing if invalid."""
    # Convert to rational to handle fractional intermediate results exactly
    ra, rb = Rational(a), Rational(b)

    if op === (/) && rb == 0
        return nothing
    end

    result = op(ra, rb)

    # Check for infinite or invalid results
    if !isfinite(result)
        return nothing
    end

    return result
end

function is_positive_integer(val)
    """Check if rational value represents a positive integer."""
    return val !== nothing && val > 0 && denominator(val) == 1
end

function all_expressions(a, b, c, d)
    """
    Generate all possible arithmetic expressions using four digits.

    Uses 5 explicit parenthesization patterns to cover all possible binary tree structures.
    Alternative: Could use 2 fundamental patterns ((a·b)·c)·d and (a·b)·(c·d) with
    permutations, but current approach is clearer and performs well for 4 digits.
    """
    digits = [a, b, c, d]
    operations = [+, -, *, /]
    results = Set{Int}()

    # Generate all permutations of the four digits
    for perm in permutations(digits)
        x, y, z, w = perm

        # Try all combinations of three operations
        for op1 in operations, op2 in operations, op3 in operations
            # Different ways to parenthesize: ((xy)z)w, (x(yz))w, (xy)(zw), x((yz)w), x(y(zw))

            # Pattern 1: ((xy)z)w
            xy = safe_op(op1, x, y)
            if xy !== nothing
                xy_z = safe_op(op2, xy, z)
                if xy_z !== nothing
                    val = safe_op(op3, xy_z, w)
                    if is_positive_integer(val)
                        push!(results, Int(numerator(val)))
                    end
                end
            end

            # Pattern 2: (x(yz))w
            yz = safe_op(op2, y, z)
            if yz !== nothing
                x_yz = safe_op(op1, x, yz)
                if x_yz !== nothing
                    val = safe_op(op3, x_yz, w)
                    if is_positive_integer(val)
                        push!(results, Int(numerator(val)))
                    end
                end
            end

            # Pattern 3: (xy)(zw)
            xy = safe_op(op1, x, y)
            zw = safe_op(op3, z, w)
            if xy !== nothing && zw !== nothing
                val = safe_op(op2, xy, zw)
                if is_positive_integer(val)
                    push!(results, Int(val))
                end
            end

            # Pattern 4: x((yz)w)
            yz = safe_op(op2, y, z)
            if yz !== nothing
                yz_w = safe_op(op3, yz, w)
                if yz_w !== nothing
                    val = safe_op(op1, x, yz_w)
                    if is_positive_integer(val)
                        push!(results, Int(numerator(val)))
                    end
                end
            end

            # Pattern 5: x(y(zw))
            zw = safe_op(op3, z, w)
            if zw !== nothing
                y_zw = safe_op(op2, y, zw)
                if y_zw !== nothing
                    val = safe_op(op1, x, y_zw)
                    if is_positive_integer(val)
                        push!(results, Int(numerator(val)))
                    end
                end
            end
        end
    end

    return results
end

function consecutive_length(numbers)
    """Find the length of consecutive integers starting from 1."""
    sorted_nums = sort(collect(numbers))

    n = 1
    while n in sorted_nums
        n += 1
    end

    return n - 1
end

function solve()
    max_consecutive = 0
    best_digits = ""

    # Try all combinations of 4 distinct digits from 0-9
    for combo in combinations(0:9, 4)
        a, b, c, d = combo

        # Generate all possible results
        results = all_expressions(a, b, c, d)

        # Find consecutive length
        consecutive = consecutive_length(results)

        if consecutive > max_consecutive
            max_consecutive = consecutive
            best_digits = string(a) * string(b) * string(c) * string(d)
        end
    end

    return best_digits
end

end # module
