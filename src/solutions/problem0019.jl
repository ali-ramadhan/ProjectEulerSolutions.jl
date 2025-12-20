"""
Project Euler Problem 19: Counting Sundays

Problem description: https://projecteuler.net/problem=19
Solution description: https://aliramadhan.me/blog/project-euler/problem-0019/
"""
module Problem0019

export is_leap_year, days_in_month, count_sundays_on_first, solve

function is_leap_year(year)
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
end

function days_in_month(month, year)
    if month == 2  # February
        return is_leap_year(year) ? 29 : 28
    elseif month in [4, 6, 9, 11]  # April, June, September, November
        return 30
    else
        return 31
    end
end


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
