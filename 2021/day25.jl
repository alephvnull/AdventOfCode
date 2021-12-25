input = split.(readlines("data/2021/input25.txt"), "")

function simulate()

    
    cp = Dict()

    for (i,x) in enumerate(input)
        for (j, y) in enumerate(x)
            if y == ">" || y == "v"   push!(cp, (i,j) => y) end
        end
    end
    lnx = length(input)
    lny = length(input[1])
    step = 0
    while true
        step += 1
        new = deepcopy(cp)
        change = false
        for ((i,j),v) in cp
            if v == ">" && !haskey(cp,  (i, j%lny+1))
                delete!(new, (i,j))
                push!(new, (i, j%lny+1) => ">")
                change = true
            end
        end
        cp = deepcopy(new)
        new = deepcopy(cp)
        for ((i,j),v) in cp
            if v == "v" && !haskey(cp, (i%lnx+1,j))
                delete!(new, (i,j))
                push!(new, (i%lnx+1, j) => "v")
                change = true
            end
        end
        if !change break end
        cp = deepcopy(new)
        
    end
    step

end

simulate()

