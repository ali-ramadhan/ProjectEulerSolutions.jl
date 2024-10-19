function pe001()
    return sum(n for n in 1:999 if n % 3 == 0 || n % 5 == 0)
end

print(pe001())
