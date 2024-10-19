using Combinatorics: fibonaccinum

function pe002()
    Σ = 0
    n = 0
    while true
        f = fibonaccinum(n)
        if f < 4_000_000 && f % 2 == 0
            Σ += f
        end
        f >= 4_000_000 && break
        n += 1
    end
    return Σ
end

print(pe002())
