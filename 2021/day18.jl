input = readlines("data/2021/input18.txt")

⨭(p,n) = typeof(p) <: Int ? p + n : [p[1] ⨭ n, p[2]] # add most left

⨮(p,n) = typeof(p) <: Int ? p + n : [p[1], p[2] ⨮ n ] # add most right

~(p) = typeof(p) <: Int ? p : 3*~(p[1]) + 2*~(p[2]) # magnitude

function ⩝(p,d) #explode
    typeof(p) <: Int ?  (return p, 0, 0, false) : nothing

    if d < 4 
        r, al, ar, m = p[1] ⩝ (d+1)
        m  ? (return [r, p[2] ⨭ ar], al, 0, m) : nothing

        r, al, ar, m = p[2] ⩝ (d+1)
        m ? (return [p[1] ⨮ al, r], 0, ar, m) : nothing

        return p, 0, 0, false
    else  
        0, p[1], p[2], true
    end
end

function !(p) #split
    if typeof(p) <: Int
        if p < 10 
            return p, false
        else
            return [Int(floor(p//2)), Int(ceil(p//2))], true
        end

    else
        L, R = p
        a, ra = !L
        if ra
            return [a,R], true
        end
        b, rb = !R
        return [a,b], rb
    end
end

function ¬(p) #reduce
    px, _, _, mod = p ⩝ 0
    mod ? (return ¬px) : nothing
    px, mod = !px
    mod ? ¬px : px
end

⊕(x,y) = ¬[x,y] # addition

str2num(x) = eval(Meta.parse(x))

~reduce(⊕,str2num.(input)) |> println
inp = str2num.(input)
maximum([~(x ⊕ y)  for x in inp for y in inp if y ≠ x ])

