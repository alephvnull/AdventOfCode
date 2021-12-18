⨭(p,n) = typeof(p) <: Int ? p + n : [p[1] ⨭ n, p[2]] # add most left

⨮(p,n) = typeof(p) <: Int ? p + n : [p[1], p[2] ⨮ n ] # add most right

~(p) = typeof(p) <: Int ? p : 3*~p[1] + 2*~p[2] # magnitude

function ⋄(p,d) #explode
    typeof(p) <: Int ?  (return p, 0, 0, false) : nothing
    if d == 4 
        0, p[1], p[2], true
    else  
        zr, L, R, mod = p[1] ⋄ (d+1)
        mod  ? (return [zr, p[2] ⨭ R], L, 0, mod) : nothing

        zr, L, R, mod = p[2] ⋄ (d+1)
        mod ? (return [p[1] ⨮ L, zr], 0, R, mod) : nothing

        p, 0, 0, false
    end
end

∛(p) = p < 10 ? (p, false) : ([Int(floor(p//2)), Int(ceil(p//2))], true)

function ∜(p)
    L, R = p
    L, FL = !L
    FL ? (return [L,R], true) : nothing
    R, FR = !R
    [L,R], FR
end

!(p) = typeof(p) <: Int ? ∛p : ∜p #split

function ¬(p) #reduce
    px, _, _, mod = p ⋄ 0
    mod ? (return ¬px) : nothing
    px, mod = !px
    mod ? ¬px : px
end

⊕(x,y) = ¬[x,y] # addition

const inp = readlines("data/2021/input18.txt") .|> Meta.parse .|> eval
@time "Part:1 $(~reduce(⊕, copy(inp)))"  |> println
@time "Part 2: $(maximum([~(x ⊕ y)  for x ∈ inp for y ∈ inp if y ≠ x ]))"  |> println

