xr = [
((x, y, z)) -> (x, y, z), ((x, y, z)) -> (x, y, -z), ((x, y, z)) -> (x, -y, z), ((x, y, z)) -> (x, -y, -z), ((x, y, z)) -> (-x, y, z), ((x, y, z)) -> (-x, y, -z), ((x, y, z)) -> (-x, -y, z), ((x, y, z)) -> (-x, -y, -z),
((x, y, z)) -> (x, z, y), ((x, y, z)) -> (x, z, -y), ((x, y, z)) -> (x, -z, y), ((x, y, z)) -> (x, -z, -y), ((x, y, z)) -> (-x, z, y), ((x, y, z)) -> (-x, z, -y), ((x, y, z)) -> (-x, -z, y), ((x, y, z)) -> (-x, -z, -y),
((x, y, z)) -> (y, x, z), ((x, y, z)) -> (y, x, -z), ((x, y, z)) -> (y, -x, z), ((x, y, z)) -> (y, -x, -z), ((x, y, z)) -> (-y, x, z), ((x, y, z)) -> (-y, x, -z), ((x, y, z)) -> (-y, -x, z), ((x, y, z)) -> (-y, -x, -z),
((x, y, z)) -> (y, z, x), ((x, y, z)) -> (y, z, -x), ((x, y, z)) -> (y, -z, x), ((x, y, z)) -> (y, -z, -x), ((x, y, z)) -> (-y, z, x), ((x, y, z)) -> (-y, z, -x), ((x, y, z)) -> (-y, -z, x), ((x, y, z)) -> (-y, -z, -z),
((x, y, z)) -> (z, x, y), ((x, y, z)) -> (z, x, -y), ((x, y, z)) -> (z, -x, y), ((x, y, z)) -> (z, -x, -y), ((x, y, z)) -> (-z, x, y), ((x, y, z)) -> (-z, x, -y), ((x, y, z)) -> (-z, -x, y), ((x, y, z)) -> (-z, -x, -y),
((x, y, z)) -> (z, y, x), ((x, y, z)) -> (z, y, -x), ((x, y, z)) -> (z, -y, x), ((x, y, z)) -> (z, -y, -x), ((x, y, z)) -> (-z, y, x), ((x, y, z)) -> (-z, y, -x), ((x, y, z)) -> (-z, -y, x), ((x, y, z)) -> (-z, -y, -x),
]

const input = readlines("data/2021/input19.txt")

manhattan(p1,p2) = sum(abs.(p1-p2))

translate(st, off) = Set([[s[i] + off[i] for i in 1:3]  for s in st ])

function allrotatedsets(stx)
    sets = []
    for rot in xr 
        st = Set()
        for (x,y,z) in stx
            push!(st, rot(x,y,z))
        end 
        push!(sets, st)
    end
    sets
end

function getsets(input)
    sets = []
    st = Set()
    for line in input
        if line == ""
            push!(sets, st)
            st = Set()
        elseif line[1:3] == "---"
            continue
        else
            push!(st, parse.(Int, split(line, ",")))
        end
    end
    push!(sets, st)
    sets
end

const sets = getsets(input)
const mset = Dict([i => allrotatedsets(s) for (i,s) ∈ enumerate(sets)])

perms(o) = [(s,m) for s in values(o) for m in values(o) if values(s) != values(m) ]
dmax(o) = maximum([manhattan(a, b) for (a, b) in perms(o)])

function fold()
    fixed = Set([sets[1]])
    off = Dict([1 => [0,0,0]])
    while length(fixed) ≠ length(sets)
    for (i,s) in enumerate(sets)
        s ∈ fixed ? continue : nothing
        fixed_bacons = reduce(union, fixed)
        for rs in mset[i], fb in fixed_bacons, sb in rs
            offset = [fb[1] - sb[1], fb[2] - sb[2], fb[3] - sb[3]]
            shifted = translate(rs, offset)
            if length(shifted ∩ fixed_bacons) >= 12 
                push!(fixed, shifted) 
                push!(off, i => offset)
                break
            end
            
        end
    end
    end
    length(reduce(union,fixed)), dmax(off)
end

@time fold() |> x -> "Part 1 : $(x[1])\nPart 2 : $(x[2])" |> println




# println(hcat([-4:-1], [1:4]))

# x1 = Set([Set([1,1,23])])
# x2 = Set([Set([1,1,23]), Set([4,1,23])])

# println([x for x in x1][1])

# println(reduce(union ,x1))

#fold()

