const input = split.(readlines("data/2021/input25.txt"), "")
lnx, lny = length(input), length(input[1])

mp = Dict()
for (i,line) ∈ enumerate(input)
    for (j, y) ∈ enumerate(line)
        if y == ">" || y == "v" push!(mp, (i,j) => y) end
    end
end

function simulate()
    cp, step = deepcopy(mp), 0
    while true
        step += 1
        new, change = copy(cp), false
        for ((i,j),v) ∈ cp
            if v == ">" && !haskey(cp,  (i, j%lny+1))
                delete!(new, (i,j))
                push!(new, (i, j%lny+1) => ">")
                change = true
            end
        end
        cp = copy(new)
        for ((i,j),v) ∈ cp
            if v == "v" && !haskey(cp, (i%lnx+1,j))
                delete!(new, (i,j))
                push!(new, (i%lnx+1, j) => "v")
                change = true
            end
        end
        !change ? break : cp = copy(new)
    end
    step
end

simulate() |> x -> "p1: $(x)" |> println