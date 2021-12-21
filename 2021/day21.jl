pos(t, p0) = (3*(t%100+1)%100+3 + p0 -1)%10 +1

fpos((p1,p2), t) = (pos(6 * t, p1) , pos(6 * t + 3, p2))

findwin(p0, t, s) = any(s .>= 1000) ? (return (t,s)) : findwin(fpos(p0,t), t+1, s .+ fpos(p0, t))

scoreat(p0,t,s, tmax) = t < tmax ? scoreat(fpos(p0,t), t+1, s .+ fpos(p0, t), tmax) : return s

const p0 = (9,4)

(t, (s1, s2)) = findwin(p0, 0, (0,0))

s1 > s2 ? scoreat(p0, 0, (0,0), t-1)[2] * ((t-1) * 6 + 3) : s1 * t * 6 |> println

offmod(x) = (x-1)%10 +1

const arr = [i+j+l for i in 1:3 for j in 1:3 for l in 1:3]
const mr = [(x,count(y -> x == y, arr)) for x in unique(arr)]

function findallwin(p0, s, i)
    f = i % 6 != 3
    any(s .>= 21) ? f ? (return 0) : (return 1) : nothing
    map(mr) do (x,c)
        (npos1, npos2), (s1,s2) = p0,s
        f ? npos1 = offmod(npos1+x)  : npos2 = offmod(npos2+x)
        f ? s1 += npos1  : s2 += npos2
        c*findallwin((npos1, npos2), (s1,s2), i+3)
    end |> sum
end

@time findallwin(p0,(0,0), 0) |> println



