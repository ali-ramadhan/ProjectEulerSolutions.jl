"""
Project Euler Problem 19: Counting Sundays

You are given the following information, but you may prefer to do some research for
yourself.

1 Jan 1900 was a Monday.
Thirty days has September, April, June and November.
All the rest have thirty-one, saving February alone,
Which has twenty-eight, rain or shine.
And on leap years, twenty-nine.

A leap year occurs on any year evenly divisible by 4, but not on a century unless it is
divisible by 400.

How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to
31 Dec 2000)?

## Solution approach

We simulate the calendar starting from the known fact that Jan 1, 1900 was a Monday.
For each month, we:
1. Check if the first day is a Sunday and count it (only for years 1901-2000)
2. Calculate the number of days in the current month
3. Advance the day-of-week by that number of days (mod 7)

We handle leap years correctly using the standard rule: divisible by 4, but not
by 100 unless also divisible by 400.

## Complexity analysis

Time complexity: O(n)
- We iterate through 101 years × 12 months = 1212 iterations
- Each iteration performs constant-time calculations
- Linear in the number of months in the date range

Space complexity: O(1)
- Only uses a constant amount of additional space for counters and variables
"""
module Problem0019

"""
    is_leap_year(year)

Determine if the given year is a leap year according to the rule:

  - A leap year occurs on any year evenly divisible by 4
  - But not on a century unless it is divisible by 400
"""
function is_leap_year(year)
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

"""
    days_in_month(month, year)

Return the number of days in the given month of the specified year,
accounting for leap years.
"""
function days_in_month(month, year)
    if month == 2  # February
        return is_leap_year(year) ? 29 : 28
    elseif month in [4, 6, 9, 11]  # April, June, September, November
        return 30
    else
        return 31
    end
end

"""
    count_sundays_on_first(start_year, end_year)

Count the number of Sundays that fell on the first day of the month
from January of start_year to December of end_year, inclusive.

The algorithm works by:

 1. Starting with Jan 1, 1900 as a Monday (day 1)
 2. Tracking the day of week for the first of each month
 3. Counting when the first falls on a Sunday during the specified period
"""
function count_sundays_on_first(start_year, end_year)
    # 0 = Sunday, 1 = Monday, ..., 6 = Saturday
    day_of_week = 1

    sunday_count = 0

    for year in 1900:end_year
        for month in 1:12
            if day_of_week == 0 && year >= start_year
                sunday_count += 1
            end

            days = days_in_month(month, year)
            day_of_week = (day_of_week + days) % 7
        end
    end

    return sunday_count
end

function solve()
    return count_sundays_on_first(1901, 2000)
end

end # module
