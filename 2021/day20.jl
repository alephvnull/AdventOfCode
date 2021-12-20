input = readlines("data/2021/input20.txt")

const Δ = Dict([i-1 => (x == "#" ? "1" : "0") for (i,x) ∈ enumerate(split(input[1], ""))])
const α = Δ[0] == "1" && Δ[511] == "0"

bit2int(x) = Δ[parse(Int, reduce(*, x), base = 2)]

const image = Dict((i,j) => (char == '#' ? "1" : "0")
    for (i,row) ∈ enumerate(input[3:end]) 
    for (j,char) ∈ enumerate(row)
)

const adjset = [(-1,-1), (-1,0), (-1,1), 
                (0, -1), (0, 0), (0, 1), 
                (1, -1), (1, 0), (1, 1)]

adjacent(x,y) = [(x,y) .+ adj for adj ∈ adjset]

mask(cp, rw, cl, def) = map(x -> haskey(cp, x) ? cp[x] : def, adjacent(rw,cl)) |> bit2int 
    
function process(step)
    cp, def = image, "0"
    mini, maxi, minj, maxj  = 1, 100, 1, 100
    for _ ∈ 1:step
        nimage = Dict()
        mini -= 2; maxi += 2; minj -= 2; maxj +=2
        for rw ∈ mini:maxi, cl ∈ minj:maxj
            push!(nimage, (rw,cl) => mask(cp, rw, cl, def))
        end
        α ? def = (def == "0" ? "1" : "0") : nothing
        cp = nimage
    end
    sum(parse.(Int,values(cp)))
end

@time "Part 1: $(process(2))"  |> println
@time "Part 2: $(process(50))" |> println