pos(t, p) = (3*(t%100+1)%100+3 + p -1)%10 +1

fpos((p1,p2), t) = (pos(6 * t, p1) , pos(6 * t + 3, p2))

findwin(p, t, s) = any(s .≥ 1000) ? (return (t,s)) : findwin(fpos(p,t), t+1, s .+ fpos(p, t))

scoreat(p,t,s, tmax) = t < tmax ? scoreat(fpos(p,t), t+1, s .+ fpos(p, t), tmax) : return s

const p0 = (9,4)

(t, (s1, s2)) = findwin(p0, 0, (0,0))

s1 > s2 ? scoreat(p0, 0, (0,0), t-1)[2] * ((t-1) * 6 + 3) : s1 * t * 6 |> x-> "p1: $(x)"|> println

offmod(x) = (x-1)%10 +1

const arr = [i+j+l for i ∈ 1:3 for j ∈ 1:3 for l ∈ 1:3]
const mr = [(x,count(y -> x == y, arr)) for x ∈ unique(arr)]

function findallwin(p, s, i)
    f = i % 6 != 3
    any(s .≥ 21) ? f ? (return 0) : (return 1) : nothing
    map(mr) do (x,c)
        (npos1, npos2), (s1,s2) = p,s
        f ? npos1 = offmod(npos1+x)  : npos2 = offmod(npos2+x)
        f ? s1 += npos1  : s2 += npos2
        c*findallwin((npos1, npos2), (s1,s2), i+3)
    end |> sum
end

@time findallwin(p0,(0,0), 0) |> x-> "p2: $(x)" |> println