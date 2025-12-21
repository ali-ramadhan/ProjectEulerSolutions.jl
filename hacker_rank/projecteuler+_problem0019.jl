# Project Euler Problem 19: Counting Sundays
# https://www.hackerrank.com/contests/projecteuler/challenges/euler019/problem
#
# Project Euler: https://projecteuler.net/problem=19
# Solution: https://aliramadhan.me/blog/project-euler/problem-0019/
#
# Problem:
#   1 Jan 1900 was a Monday.
#   - Thirty days has September, April, June and November.
#   - All the rest have thirty-one, saving February alone, which has
#     twenty-eight, rain or shine. And on leap years, twenty-nine.
#   - A leap year occurs on any year evenly divisible by 4, but not on a
#     century unless it is divisible by 400.
#
#   How many Sundays fell on the first of the month between two dates
#   (both inclusive)?
#
# Input Format:
#   First line: T (number of test cases)
#   Each test case has two lines:
#     Y1 M1 D1 (starting date)
#     Y2 M2 D2 (ending date)
#
# Constraints:
#   1 <= T <= 100
#   1900 <= Y1 <= 10^16
#   Y1 <= Y2 <= (Y1 + 1000)
#   1 <= M1, M2 <= 12
#   1 <= D1, D2 <= 31
#
# Output Format:
#   Print the count for each test case.

function is_leap_year(year)
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

function days_in_month(month, year)
    if month == 2
        return is_leap_year(year) ? 29 : 28
    elseif month in (4, 6, 9, 11)
        return 30
    else
        return 31
    end
end

# Calculate day of week for the 1st of a given month/year
# 0 = Sunday, 1 = Monday, ..., 6 = Saturday
# Reference: Jan 1, 1900 = Monday (day 1)
function day_of_week_first(month, year)
    # Use 400-year cycle: the calendar repeats exactly every 400 years
    # because 400 years = 146097 days = 20871 weeks exactly
    # This allows us to handle years up to 10^16 efficiently
    equiv_year = 1900 + mod(year - 1900, 400)

    # Count leap years from year 1 to year y (inclusive)
    function leap_count(y)
        return div(y, 4) - div(y, 100) + div(y, 400)
    end

    # Days from Jan 1, 1900 to Jan 1, equiv_year
    year_diff = equiv_year - 1900
    leap_days = year_diff > 0 ? leap_count(equiv_year - 1) - leap_count(1899) : 0
    days = year_diff * 365 + leap_days

    # Add days for months before current month
    for m in 1:(month - 1)
        days += days_in_month(m, equiv_year)
    end

    # Jan 1, 1900 was Monday (day 1)
    return mod(1 + days, 7)
end

function count_sundays_on_first(y1, m1, d1, y2, m2, d2)
    # Find the first 1st-of-month in the range
    if d1 == 1
        start_month, start_year = m1, y1
    else
        # Move to the next month's 1st
        if m1 == 12
            start_month, start_year = 1, y1 + 1
        else
            start_month, start_year = m1 + 1, y1
        end
    end

    # Check if start is past the end date
    if start_year > y2 || (start_year == y2 && start_month > m2)
        return 0
    end

    # Get day of week for the first 1st-of-month
    dow = day_of_week_first(start_month, start_year)

    count = 0
    curr_month, curr_year = start_month, start_year

    # Iterate through all 1st-of-months in the range
    while curr_year < y2 || (curr_year == y2 && curr_month <= m2)
        if dow == 0  # Sunday
            count += 1
        end

        # Advance day of week by days in current month
        days_this_month = days_in_month(curr_month, curr_year)
        dow = mod(dow + days_this_month, 7)

        # Move to next month
        if curr_month == 12
            curr_month = 1
            curr_year += 1
        else
            curr_month += 1
        end
    end

    return count
end

T = parse(Int, readline())
for _ in 1:T
    parts1 = split(readline())
    y1 = parse(Int, parts1[1])
    m1 = parse(Int, parts1[2])
    d1 = parse(Int, parts1[3])

    parts2 = split(readline())
    y2 = parse(Int, parts2[1])
    m2 = parse(Int, parts2[2])
    d2 = parse(Int, parts2[3])

    println(count_sundays_on_first(y1, m1, d1, y2, m2, d2))
end
