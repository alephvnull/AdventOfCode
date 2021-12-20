input = readlines("data/2021/input20.txt")

Δ = Dict([i-1 => (x == "#" ? "1" : "0") for (i,x) in enumerate(split(input[1], ""))])

bit2int(x) = Δ[parse(Int, reduce(*, x), base = 2)]

α = Δ[0] == "1" && Δ[511] == "0"

#if not in a dict get default that is alternating based on alpha

image = Dict((i,j) => (char == '#' ? "1" : "0")
    for (i,row) in enumerate(input[3:end]) 
    for (j,char) in enumerate(row)
)

adjset = [(-1,-1), (-1,0), (-1,1), (0,-1), (0,0),(0,1), (1,-1), (1,0),(1,1)]

adjacent(x,y) = [(x,y).+adj for adj ∈ adjset]

mask(cp, rw, cl, def) = map(x -> haskey(cp, x) ? cp[x] : def, adjacent(rw,cl)) |> bit2int 
    
function process()
    cp = image
     
    def = "0"

    step = 50
    for i in 1:step
        nimage = Dict()
        maxi = maximum([i for ((i,j), k) in cp])
        mini = minimum([i for ((i,j), k) in cp])
        maxj = maximum([j for ((i,j), k) in cp])
        minj = minimum([j for ((i,j), k) in cp])

        for rw in mini-2:maxi+3, cl in minj-2:maxj+3
            push!(nimage, (rw,cl) => mask(cp, rw, cl, def))
        end

        α ? def = (def == "0" ? "1" : "0") : nothing
        cp = nimage
    end

    sum(parse.(Int,values(cp)))
   
end
process()