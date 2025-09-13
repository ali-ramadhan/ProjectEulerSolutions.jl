"""
Project Euler Problem 100: Arranged probability

If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red
discs, and two discs were taken at random, it can be seen that the probability of taking
two blue discs, P(BB) = (15/21)×(14/20) = 1/2.

The next such arrangement, for which there is exactly 50% chance of taking two blue
discs, is a box containing eighty-five blue discs and thirty-five red discs.

By finding the first arrangement to contain over 10^12 = 1,000,000,000,000 discs in
total, determine the number of blue discs that the box would contain.
"""
module Problem0100

function solve()
    return find_blue_discs(10^12)
end

function find_blue_discs(min_total)
    # For probability P(BB) = 1/2, we need:
    # b(b-1) = n(n-1)/2, where b = blue discs, n = total discs
    # This leads to the Pell equation: y² - 2x² = -1
    # where x = 2b-1 and y = 2n-1

    # Start with first known solution (15, 21)
    b, n = 15, 21

    # If min_total is exactly 21, return the first solution
    if n == min_total
        return b
    end

    # Generate solutions using the recurrence relation for Pell equation y² - 2x² = -1:
    # y_{k+1} = 3*y_k + 4*x_k
    # x_{k+1} = 2*y_k + 3*x_k
    # where x = 2b-1, y = 2n-1

    while n < min_total
        x = 2*b - 1
        y = 2*n - 1

        # Generate next solution
        new_y = 3*y + 4*x
        new_x = 2*y + 3*x

        # Convert back to b and n
        b = (new_x + 1) ÷ 2
        n = (new_y + 1) ÷ 2

        # If we found exact match, return it
        if n == min_total
            return b
        end
    end

    return b
end

end # module
