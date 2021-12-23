using DataStructures

const input = readlines("data/2021/input23.txt")

frow = split(input[3], "#")[4:7]
srow = split(input[4], "#")[2:5]

dr(n, rw) = [(n,2*j+1) => x[1] for (j,x) in enumerate(rw)]

const input1 = Dict(       
    hcat(dr(2, frow), dr(3, srow))
)

const add1 = ['D', 'C', 'B', 'A']
const add2 = ['D', 'B', 'A', 'C']

const input2 = Dict(
    hcat(dr(2, frow), dr(3, add1), dr(4, add2), dr(5, srow))
)

const corridor = [(1, x) for x in 1:11]

rrn(k,n) = [(x,n) for x in 2:k]

const ABCD = ['A', 'B', 'C', 'D']

const rms1 = Dict(
    l => rrn(3, 1 +2*i) for (i,l) in enumerate(ABCD)
)

const rms2 = Dict(
    l => rrn(5, 1 +2*i) for (i,l) in enumerate(ABCD)
)

↔(x, y) = x < y ? (x:y-1) : (y+1:x)
move(pos, (fx,fy), (tx,ty)) = fy == ty ||
    any((1, i) ∈ keys(pos) for i ∈ (ty ↔ fy)) ||
    tx ≠ 1 && any((x, ty) ∈ keys(pos) for x ∈ (tx ↔ 1)) ||
    fx ≠ 1 && any((x, fy) ∈ keys(pos) for x ∈ (1 ↔ fx)) ? false : true

const Δ = Dict(
    'A' => 1,
    'B' => 10,
    'C' => 100,
    'D' => 1000
)   

manhattan(p1,p2) = sum(abs.(p1.-p2))
function make_move((pos,score), xx, yy)
    npos, npos[yy] = delete!(copy(pos), xx) , pos[xx]

    (npos, score + manhattan(xx, yy) * Δ[npos[yy]])
end

function gnext((mp,score), rooms)
    N = []
    for (xx, c) ∈ mp
        ev = all(mp[r] == c for r ∈ rooms[c] if haskey(mp, r))
        if xx[1] == 1 && ev
            for yy ∈ rooms[c]
                move(mp, xx, yy) ? push!(N, make_move((mp,score), xx, yy)) : nothing
            end
        elseif xx[1] ≠ 1 && !(xx ∈ rooms[c] && ev)
            for yy ∈ corridor
                move(mp, xx, yy) ? push!(N, make_move((mp,score), xx, yy)) : nothing
            end
        end
    end
    N
end

revdict(d) = Dict([pt => k for (k,v) in d for pt in v])
function shortest(mp, rooms)
    reroom = revdict(rooms)
    pq = PriorityQueue()
    pq[(mp, 0)] = 0
    visited = Dict()
    while true
        (pp, score) = dequeue!(pq)
        pp == reroom ? (return score) : nothing
        for (oo,ss) ∈ gnext((pp, score), rooms)
            if oo ∉ keys(visited) || ss < visited[oo]
                visited[oo] = ss
                pq[(oo,ss)] = ss
            end
        end
    end
end


shortest(input1, rms1) |> x-> "p1: $(x)" |> println

shortest(input2, rms2) |> x-> "p2: $(x)" |> println